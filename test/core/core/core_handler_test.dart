import 'package:assist_agro/core/core/core_handler.dart';
import 'package:assist_agro/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('ensure handle a failure if is failure', () async {
    //Arrange
    //Act
    final result = CoreHandle(failure: GenericFailure(message: 'test failure'));
    //Assert
    expect(result.hasFailure, true);
    expect(result.failure, GenericFailure(message: 'test failure'));
    expect(result.response, null);
  });
  test('ensure handle a response if not is a failure', () async {
    //Arrange
    //Act
    final result = CoreHandle(response: 'test');
    //Assert
    expect(result.response, 'test');
    expect(result.hasFailure, false);
    expect(result.failure, null);
  });
  test('ensure throws if not pass a response or failure', () async {
    //Arrange
    //Act
    //Assert
    expect(() => CoreHandle(), throwsA(isInstanceOf<Error>()));
  });
}
