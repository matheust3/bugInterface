// Mocks generated by Mockito 5.0.2 from annotations
// in assist_agro/test/features/admin/cubits/login_page/login_page_cubit_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:assist_agro/core/core/core_handler.dart' as _i3;
import 'package:assist_agro/core/navigator/navigator_service.dart' as _i9;
import 'package:assist_agro/features/admin/domain/models/login_request_data.dart'
    as _i8;
import 'package:assist_agro/features/admin/domain/models/login_response_data.dart'
    as _i7;
import 'package:assist_agro/features/admin/domain/repositories/admin_repository.dart'
    as _i2;
import 'package:assist_agro/features/admin/domain/usecases/login.dart' as _i5;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart' as _i4;
import 'package:flutter/src/widgets/navigator.dart' as _i10;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeAdminRepository extends _i1.Fake implements _i2.AdminRepository {}

class _FakeCoreHandle<Type> extends _i1.Fake implements _i3.CoreHandle<Type> {}

class _FakeGlobalKey<T extends State<StatefulWidget>> extends _i1.Fake
    implements _i4.GlobalKey<T> {}

/// A class which mocks [LoginUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginUseCase extends _i1.Mock implements _i5.LoginUseCase {
  MockLoginUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AdminRepository get adminRepository =>
      (super.noSuchMethod(Invocation.getter(#adminRepository),
          returnValue: _FakeAdminRepository()) as _i2.AdminRepository);
  @override
  _i6.Future<_i3.CoreHandle<_i7.LoginResponseData>> call(
          {_i8.LoginRequestData? param}) =>
      (super.noSuchMethod(Invocation.method(#call, [], {#param: param}),
              returnValue:
                  Future.value(_FakeCoreHandle<_i7.LoginResponseData>()))
          as _i6.Future<_i3.CoreHandle<_i7.LoginResponseData>>);
}

/// A class which mocks [NavigatorService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigatorService extends _i1.Mock implements _i9.NavigatorService {
  MockNavigatorService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.GlobalKey<_i10.NavigatorState> get navigatorKey =>
      (super.noSuchMethod(Invocation.getter(#navigatorKey),
              returnValue: _FakeGlobalKey<_i10.NavigatorState>())
          as _i4.GlobalKey<_i10.NavigatorState>);
  @override
  _i6.Future<dynamic> navigateToAndRemoveUtil(String? routeName,
          {Object? arguments}) =>
      (super.noSuchMethod(
          Invocation.method(
              #navigateToAndRemoveUtil, [routeName], {#arguments: arguments}),
          returnValue: Future.value(null)) as _i6.Future<dynamic>);
  @override
  _i6.Future<dynamic> navigateTo(String? routeName, {Object? arguments}) =>
      (super.noSuchMethod(
          Invocation.method(#navigateTo, [routeName], {#arguments: arguments}),
          returnValue: Future.value(null)) as _i6.Future<dynamic>);
  @override
  void popUntil(String? routeName) =>
      super.noSuchMethod(Invocation.method(#popUntil, [routeName]),
          returnValueForMissingStub: null);
  @override
  bool canPop() =>
      (super.noSuchMethod(Invocation.method(#canPop, []), returnValue: false)
          as bool);
  @override
  bool pop() =>
      (super.noSuchMethod(Invocation.method(#pop, []), returnValue: false)
          as bool);
}
