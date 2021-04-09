import 'package:assist_agro/core/adapters/web_adapter.dart';
import 'package:assist_agro/core/core/core_handler.dart';
import 'package:assist_agro/core/errors/errors.dart';
import 'package:assist_agro/core/errors/failures.dart';
import 'package:assist_agro/features/admin/data/datasources/login_datasource.dart';
import 'package:assist_agro/features/admin/domain/models/login_request_data.dart';
import 'package:assist_agro/features/admin/domain/models/login_response_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_datasource_test.mocks.dart';

@GenerateMocks([WebAdapter])
main() {
  late MockWebAdapter mockWebAdapter;
  late LoginDatasource datasource;
  LoginResponseData loginResponseData = LoginResponseData(token: 'token');
  LoginRequestData loginRequestData =
      LoginRequestData(type: 'user', pass: 'pass', userName: 'userName');
  final responseHandle = CoreHandle(response: loginResponseData.toJson());
  setUp(() {
    mockWebAdapter = MockWebAdapter();
    when(mockWebAdapter.get(
            url: anyNamed('url'), queryParams: anyNamed('queryParams')))
        .thenAnswer((realInvocation) async => responseHandle);

    datasource = LoginDatasourceImpl(webAdapter: mockWebAdapter);
  });

  test('ensure ensure call web with correct params', () async {
    //Arrange
    //Act
    await datasource.login(requestData: loginRequestData);
    //Assert
    final captured = verify(mockWebAdapter.get(
        url: '/api/admin/login', queryParams: captureAnyNamed('queryParams')));
    expect(captured.captured[0], {"data": loginRequestData.toJson()});
  });

  test('ensure return result', () async {
    //Arrange
    //Act
    final result = await datasource.login(requestData: loginRequestData);
    //Assert
    expect(result, loginResponseData);
  });

  test('ensure throws if json not is a valid loginResponseData', () async {
    //Arrange
    final json = {'test': 'test'};
    when(mockWebAdapter.get(
            queryParams: anyNamed('queryParams'), url: anyNamed('url')))
        .thenAnswer((realInvocation) async => CoreHandle(response: json));
    //Act
    //Assert
    await expectLater(() => datasource.login(requestData: loginRequestData),
        throwsA(isInstanceOf<Error>()));
  });

  test('ensure throw is webAdapter return a failure', () async {
    //Arrange
    when(mockWebAdapter.get(
            url: anyNamed('url'), queryParams: anyNamed('queryParams')))
        .thenAnswer((realInvocation) async =>
            CoreHandle(failure: GenericFailure(message: 'test message')));
    //Act
    //Assert
    await expectLater(() => datasource.login(requestData: loginRequestData),
        throwsA(isInstanceOf<WebAdapterError>()));
  });
}
