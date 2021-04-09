import 'package:assist_agro/features/admin/domain/models/login_request_data.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final loginRequestDataJson = {
    "type": "user",
    "pass": "testPass",
    "userName": "anyUserName"
  };
  final LoginRequestData loginRequestData =
      LoginRequestData(type: 'user', pass: 'testPass', userName: 'anyUserName');

  test('ensure transform json to obj', () async {
    //Arrange
    //Act
    final tLoginRequest = LoginRequestData.fromJson(loginRequestDataJson);
    //Assert
    expect(tLoginRequest, loginRequestData);
  });

  test('ensure parse obj to json', () async {
    //Arrange
    //Act
    final tJson = loginRequestData.toJson();
    //Assert
    expect(tJson, loginRequestDataJson);
  });
}
