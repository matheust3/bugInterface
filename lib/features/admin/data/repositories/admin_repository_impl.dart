import 'package:assist_agro/core/core/admin_data.dart';
import 'package:assist_agro/core/errors/failures.dart';
import 'package:assist_agro/features/admin/data/datasources/login_datasource.dart';
import 'package:assist_agro/features/admin/domain/models/login_response_data.dart';
import 'package:assist_agro/features/admin/domain/models/login_request_data.dart';
import 'package:assist_agro/core/core/core_handler.dart';
import 'package:assist_agro/features/admin/domain/repositories/admin_repository.dart';

class AdminRepositoryImpl implements AdminRepository {
  final LoginDatasource loginDatasource;
  final AdminData adminData;

  AdminRepositoryImpl({required this.loginDatasource, required this.adminData});

  @override
  Future<CoreHandle<LoginResponseData>> login(
      {required LoginRequestData loginRequestData}) async {
    try {
      final result =
          await this.loginDatasource.login(requestData: loginRequestData);
      await adminData.setLoginToken(result.token);
      return CoreHandle(response: result);
    } catch (e) {
      return CoreHandle(failure: GenericFailure(message: e.toString()));
    }
  }
}
