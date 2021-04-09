import 'dart:io';

import 'package:git_hooks/git_hooks.dart';

void main(List<String> arguments) {
  // ignore: omit_local_variable_types
  Map<Git, UserBackFun> params = {
    Git.commitMsg: commitMsg,
    Git.preCommit: preCommit
  };
  GitHooks.call(arguments, params);
}

Future<bool> commitMsg() async {
  var commitMsg = Utils.getCommitEditMsg();

  if (commitMsg.startsWith('fix: ') ||
      commitMsg.startsWith('chore: ') ||
      commitMsg.startsWith('test: ') ||
      commitMsg.startsWith('feat: ')) {
    return true;
  } else {
    print('Error on git commit message lint');
    return false;
  }
}

Future<bool> preCommit() async {
  try {
    final directoryPath = Directory.current.path;
    bool result = await _analyze(directoryPath);
    if (result) {
      result = await _format(directoryPath);
      if (result) {
        print('Committed!');
        return await _test(directoryPath);
      }
    }
  } catch (e) {
    print('Error no pre commit');
    print(e);
  }
  return false;
}

Future<bool> _test(String path) async {
  ProcessResult result = await Process.run(
      'git', ['diff', '--name-only', '--cached'],
      workingDirectory: path);
  if (result.exitCode != 0) {
    print(result.stdout);
    return false;
  } else {
    final filesStaged = result.stdout.toString().split('\n');
    List<String> testArgs = ['test'];
    filesStaged.forEach((element) {
      if (element.contains('_test.dart')) {
        testArgs.add(element);
      }
    });
    if (testArgs.length > 1) {
      result = await Process.run('flutter', testArgs, workingDirectory: path);
      if (result.exitCode != 0) {
        print(result.stdout);
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}

Future<bool> _format(String path) async {
  ProcessResult result =
      await Process.run('flutter', ['format', './'], workingDirectory: path);
  if (result.exitCode != 0) {
    print(result.stdout);
    return false;
  } else {
    // Coloca os arquivos formatados no git
    result = await Process.run('git', ['diff', '--name-only', '--cached'],
        workingDirectory: path);
    if (result.exitCode != 0) {
      print(result.stdout);
      return false;
    } else {
      final filesStaged = result.stdout.toString().split('\n');
      List<String> addArgs = ['add'];
      filesStaged.forEach((element) {
        if (element.contains('/')) {
          addArgs.add(element);
        }
      });
      result = await Process.run('git', addArgs, workingDirectory: path);
      if (result.exitCode != 0) {
        print(result.stdout);
        return false;
      } else {
        return true;
      }
    }
  }
}

Future<bool> _analyze(String path) async {
  ProcessResult result = await Process.run(
      'flutter', ['analyze', '--fatal-warnings', './'],
      workingDirectory: path);
  if (result.exitCode != 0) {
    print(result.stdout);
    return false;
  } else {
    return true;
  }
}
