import 'package:assist_agro/core/core/core_handler.dart';
import 'package:assist_agro/features/admin/domain/models/login_request_data.dart';
import 'package:assist_agro/features/admin/domain/models/login_response_data.dart';
import 'package:assist_agro/features/admin/domain/repositories/admin_repository.dart';
import 'package:assist_agro/features/admin/domain/usecases/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_test.mocks.dart';

@GenerateMocks([AdminRepository])
main() {
  late MockAdminRepository mockAdminRepository;
  late LoginUseCase useCase;
  LoginResponseData loginResponseData = LoginResponseData(token: 'token');
  LoginRequestData loginRequestData =
      LoginRequestData(type: 'user', pass: 'pass', userName: 'userName');

  setUp(() {
    mockAdminRepository = MockAdminRepository();

    when(mockAdminRepository.login(
            loginRequestData: anyNamed('loginRequestData')))
        .thenAnswer(
            (realInvocation) async => CoreHandle(response: loginResponseData));

    useCase = LoginUseCase(adminRepository: mockAdminRepository);
  });

  test('ensure call admin repository with correct params', () async {
    //Arrange
    //Act
    await useCase(param: loginRequestData);
    //Assert
    verify(mockAdminRepository.login(loginRequestData: loginRequestData))
        .called(1);
  });
  test('ensure return failure if param of use case is null', () async {
    //Arrange
    //Act
    final result = await useCase();
    //Assert
    verifyNever(mockAdminRepository.login(
        loginRequestData: captureAnyNamed('loginRequestData')));
    expect(result.hasFailure, true);
  });
}
