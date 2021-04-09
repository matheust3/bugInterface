import 'package:assist_agro/core/errors/errors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminData {
  final SharedPreferences _sharedPreferences;
  final _tokenKey = 'admin-data-token';
  String get getLoginToken =>
      (this._sharedPreferences.getString(_tokenKey) ?? '');

  Future<void> setLoginToken(String token) async {
    if (!(await this._sharedPreferences.setString(this._tokenKey, token))) {
      throw SetDataError('in admin setLoginToken');
    }
  }

  AdminData(this._sharedPreferences);
}
