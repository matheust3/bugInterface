import 'package:assist_agro/core/adapters/web_adapter.dart';
import 'package:assist_agro/core/errors/errors.dart';
import 'package:assist_agro/features/admin/domain/models/login_request_data.dart';
import 'package:assist_agro/features/admin/domain/models/login_response_data.dart';

abstract class LoginDatasource {
  Future<LoginResponseData> login({required LoginRequestData requestData});
}

class LoginDatasourceImpl implements LoginDatasource {
  final WebAdapter webAdapter;

  LoginDatasourceImpl({required this.webAdapter});

  @override
  Future<LoginResponseData> login(
      {required LoginRequestData requestData}) async {
    final result = await webAdapter.get(
        url: '/api/admin/login', queryParams: {'data': requestData.toJson()});
    if (!result.hasFailure) {
      return LoginResponseData.fromJson(
          result.response as Map<String, dynamic>);
    } else {
      throw WebAdapterError('on admin login');
    }
  }
}
