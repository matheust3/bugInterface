// Mocks generated by Mockito 5.0.2 from annotations
// in assist_agro/test/features/admin/domain/usecases/login_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:assist_agro/core/core/core_handler.dart' as _i2;
import 'package:assist_agro/features/admin/domain/models/login_request_data.dart'
    as _i6;
import 'package:assist_agro/features/admin/domain/models/login_response_data.dart'
    as _i5;
import 'package:assist_agro/features/admin/domain/repositories/admin_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeCoreHandle<Type> extends _i1.Fake implements _i2.CoreHandle<Type> {}

/// A class which mocks [AdminRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdminRepository extends _i1.Mock implements _i3.AdminRepository {
  MockAdminRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.CoreHandle<_i5.LoginResponseData>> login(
          {_i6.LoginRequestData? loginRequestData}) =>
      (super.noSuchMethod(
          Invocation.method(#login, [], {#loginRequestData: loginRequestData}),
          returnValue:
              Future.value(_FakeCoreHandle<_i5.LoginResponseData>())) as _i4
          .Future<_i2.CoreHandle<_i5.LoginResponseData>>);
}
