import 'package:assist_agro/core/core/core_handler.dart';
import 'package:assist_agro/core/errors/failures.dart';
import 'package:assist_agro/core/navigator/navigator_service.dart';
import 'package:assist_agro/features/admin/domain/models/login_request_data.dart';
import 'package:assist_agro/features/admin/domain/models/login_response_data.dart';
import 'package:assist_agro/features/admin/domain/usecases/login.dart';
import 'package:assist_agro/features/admin/presentation/cubits/login_page/login_page_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_page_cubit_test.mocks.dart';

@GenerateMocks([LoginUseCase, NavigatorService])
main() {
  late LoginPageCubit cubit;
  late MockLoginUseCase loginUseCase;
  late MockNavigatorService mockNavigatorService;
  final loginResponseData = LoginResponseData(token: 'token');
  setUp(() {
    loginUseCase = MockLoginUseCase();
    mockNavigatorService = MockNavigatorService();

    when(loginUseCase.call(param: anyNamed('param'))).thenAnswer(
        (realInvocation) async => CoreHandle(response: loginResponseData));
    when(mockNavigatorService.navigateTo(any))
        .thenAnswer((realInvocation) async => true);

    cubit = LoginPageCubit(
        loginUseCase: loginUseCase, navigatorService: mockNavigatorService);
    cubit.pass = 'any pass';
    cubit.userName = 'any';
  });

  group('onUserName', () {
    test('ensure save userName in a var', () async {
      //Arrange
      //Act
      cubit.onUserName('data');
      //Assert
      expect(cubit.userName, 'data');
      await expectLater(cubit.userNameError, emits(null));
    });
  });
  group('onPass', () {
    test('ensure save pass in a var', () async {
      //Arrange
      expectLater(cubit.passError, emits(null));
      //Act
      cubit.onPass('data');
      //Assert
      expect(cubit.pass, 'data');
    });
  });
  group('onShowPass', () {
    test('ensure insure show pass if is hidden', () async {
      //Arrange
      //Act
      cubit.onShowPass();
      //Assert
      expectLater(cubit.showPass, emits(true));
    });

    test('ensure insure emits true, false', () async {
      //Arrange
      //Act
      cubit.onShowPass();
      cubit.onShowPass();
      //Assert
      expectLater(cubit.showPass, emitsInOrder([true, false]));
    });
  });
  group('login', () {
    test('ensure emits a message if userName is empty', () async {
      //Arrange
      cubit.pass = '';
      cubit.userName = '';
      //Act
      await cubit.login();
      //Assert
      await expectLater(cubit.userNameError,
          emitsInOrder(["O campo 'Usuário' é obrigatório"]));
      verifyNever(loginUseCase.call(param: captureAnyNamed('param')));
    });
    test('ensure emits a message if pass is empty', () async {
      //Arrange
      cubit.pass = '';
      cubit.userName = 'any';
      expectLater(
          cubit.passError, emitsInOrder(["O campo 'Senha' é obrigatório"]));
      //Act
      await cubit.login();
      //Assert
      verifyNever(loginUseCase.call(param: captureAnyNamed('param')));
    });
    test('ensure call login use case with correct params', () async {
      //Arrange
      final loginRequestData =
          LoginRequestData(type: 'admin', pass: 'pass', userName: 'userName');
      cubit.pass = 'pass';
      cubit.userName = 'userName';
      //Act
      await cubit.login();
      //Assert
      final captured = verify(loginUseCase(param: captureAnyNamed('param')));
      expect(captured.captured[0], loginRequestData);
      expectLater(cubit.loading, emitsInOrder([true, false]));
    });
    test('ensure emits a message if not legged', () async {
      //Arrange
      when(loginUseCase.call(param: anyNamed('param'))).thenAnswer(
          (realInvocation) async =>
              CoreHandle(response: LoginResponseData(token: '')));
      //Act
      await cubit.login();
      //Assert
      await expectLater(cubit.loading, emitsInOrder([true, false]));
      await expectLater(
          cubit.snackMessage, emitsInOrder(['Usuário ou senha inválidos']));
    });
    test('ensure emits a message if not failure to login', () async {
      //Arrange
      when(loginUseCase.call(param: anyNamed('param'))).thenAnswer(
          (realInvocation) async =>
              CoreHandle(failure: GenericFailure(message: 'test failure')));
      //Act
      await cubit.login();
      //Assert
      await expectLater(cubit.loading, emitsInOrder([true, false]));
      await expectLater(
          cubit.snackMessage,
          emitsInOrder([
            'Erro interno, se persistir contate o administrador do sistema'
          ]));
    });

    test('ensure navigate to admin page if login has complete', () async {
      //Arrange
      //Act
      await cubit.login();
      //Assert
      verify(mockNavigatorService.navigateTo('/admin')).called(1);
    });
  });
}
