import 'package:assist_agro/core/core/admin_data.dart';
import 'package:assist_agro/core/errors/errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/admin/data/repositories/admin_repository_impl_test.mocks.dart';

@GenerateMocks([SharedPreferences])
main() {
  late MockSharedPreferences mockSharedPreferences;
  late AdminData adminData;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    when(mockSharedPreferences.setString(any, any))
        .thenAnswer((realInvocation) async => true);
    when(mockSharedPreferences.getString(any))
        .thenAnswer((realInvocation) => 'token');
    adminData = AdminData(mockSharedPreferences);
  });

  test('ensure call setString on set token', () async {
    //Arrange
    //Act
    await adminData.setLoginToken('token');
    //Assert
    final captured =
        verify(mockSharedPreferences.setString(captureAny, captureAny));
    expect(captured.captured[0], 'admin-data-token');
    expect(captured.captured[1], 'token');
  });

  test('ensure call getString and return the token', () async {
    //Arrange
    //Act
    final result = adminData.getLoginToken;
    //Assert
    final captured = verify(mockSharedPreferences.getString(captureAny));
    expect(captured.captured[0], 'admin-data-token');
    expect(result, 'token');
  });

  test('ensure throws if setString return false', () async {
    //Arrange
    when(mockSharedPreferences.setString(any, any))
        .thenAnswer((realInvocation) async => false);
    //Act
    //Assert
    await expectLater(() => adminData.setLoginToken('token'),
        throwsA(isInstanceOf<SetDataError>()));
  });
}
