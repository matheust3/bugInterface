import 'package:assist_agro/core/core/admin_data.dart';
import 'package:assist_agro/features/admin/data/datasources/login_datasource.dart';
import 'package:assist_agro/features/admin/data/repositories/admin_repository_impl.dart';
import 'package:assist_agro/features/admin/domain/models/login_request_data.dart';
import 'package:assist_agro/features/admin/domain/models/login_response_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'admin_repository_impl_test.mocks.dart';

@GenerateMocks([LoginDatasource, SharedPreferences])
main() {
  late MockLoginDatasource mockLoginDatasource;
  late AdminRepositoryImpl repositoryImpl;
  late MockSharedPreferences mockSharedPreferences;

  LoginResponseData loginResponseData = LoginResponseData(token: 'token');
  LoginRequestData loginRequestData =
      LoginRequestData(type: 'user', pass: 'pass', userName: 'userName');

  setUp(() async {
    mockLoginDatasource = MockLoginDatasource();
    mockSharedPreferences = MockSharedPreferences();
    final AdminData adminData = AdminData(mockSharedPreferences);

    when(mockLoginDatasource.login(requestData: anyNamed('requestData')))
        .thenAnswer((realInvocation) async => loginResponseData);
    when(mockSharedPreferences.setString(any, any))
        .thenAnswer((realInvocation) async => true);
    repositoryImpl = AdminRepositoryImpl(
        loginDatasource: mockLoginDatasource, adminData: adminData);
  });
  test('ensure save login token in admin data', () async {
    //Arrange
    //Act
    final result =
        await repositoryImpl.login(loginRequestData: loginRequestData);
    //Assert
    verify(mockSharedPreferences.setString(captureAny, 'token')).called(1);
    expect(result.response, loginResponseData);
  });
  test('ensure return failure if datasource throws', () async {
    //Arrange
    when(mockLoginDatasource.login(requestData: anyNamed('requestData')))
        .thenThrow(Error());
    //Act
    final result =
        await repositoryImpl.login(loginRequestData: loginRequestData);
    //Assert
    expect(result.hasFailure, true);
  });
}
