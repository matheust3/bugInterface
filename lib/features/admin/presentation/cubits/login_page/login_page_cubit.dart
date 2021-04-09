import 'dart:async';

import 'package:assist_agro/core/navigator/navigator_service.dart';
import 'package:assist_agro/features/admin/domain/models/login_request_data.dart';
import 'package:assist_agro/features/admin/domain/usecases/login.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  String userName = '';
  String pass = '';
  Stream<String?> get snackMessage => _snackMessageController.stream;
  final _snackMessageController = StreamController<String?>();
  Stream<String?> get userNameError => _userNameErrorController.stream;
  final _userNameErrorController = StreamController<String?>();
  Stream<String?> get passError => _passErrorController.stream;
  final _passErrorController = StreamController<String?>.broadcast();
  Stream<bool> get loading => _loadingController.stream;
  final _loadingController = StreamController<bool>();
  Stream<bool> get showPass => _showPassController.stream;
  final _showPassController = StreamController<bool>();
  bool _showPass = false;
  final LoginUseCase loginUseCase;
  final NavigatorService navigatorService;

  LoginPageCubit({required this.loginUseCase, required this.navigatorService})
      : super(LoginPageInitial());

  @override
  Future<void> close() async {
    await this._snackMessageController.close();
    await this._userNameErrorController.close();
    await this._showPassController.close();
    await this._passErrorController.close();
    await this._loadingController.close();
    return super.close();
  }

  Future<void> login() async {
    if (this.userName == '') {
      this._userNameErrorController.sink.add("O campo 'Usuário' é obrigatório");
    } else if (this.pass == '') {
      this._passErrorController.sink.add("O campo 'Senha' é obrigatório");
    } else {
      this._loadingController.sink.add(true);
      final result = await loginUseCase(
          param: LoginRequestData(
              type: 'admin', pass: this.pass, userName: this.userName));
      this._loadingController.sink.add(false);
      if (!result.hasFailure) {
        if (result.response?.token == '') {
          this._snackMessageController.sink.add('Usuário ou senha inválidos');
        } else {
          await this.navigatorService.navigateTo('/admin');
        }
      } else {
        this._snackMessageController.sink.add(
            'Erro interno, se persistir contate o administrador do sistema');
      }
    }
  }

  void onUserName(String data) {
    this.userName = data.trim();
    this._userNameErrorController.sink.add(null);
  }

  void onPass(String data) {
    this.pass = data.trim();
    this._passErrorController.sink.add(null);
  }

  void onShowPass() {
    this._showPassController.sink.add(!this._showPass);
    this._showPass = !this._showPass;
  }
}
