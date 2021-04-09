import 'package:assist_agro/features/admin/domain/models/login_response_data.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final loginRequestDataJson = {"token": "token"};
  final LoginResponseData loginRequestData = LoginResponseData(token: 'token');

  test('ensure transform json to obj', () async {
    //Arrange
    //Act
    final tLoginRequest = LoginResponseData.fromJson(loginRequestDataJson);
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
