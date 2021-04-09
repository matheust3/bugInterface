import 'package:assist_agro/core/core/core_handler.dart';
import 'package:assist_agro/features/admin/domain/models/login_request_data.dart';
import 'package:assist_agro/features/admin/domain/models/login_response_data.dart';

abstract class AdminRepository {
  ///
  /// Faz o login de um usuário administrador
  ///
  Future<CoreHandle<LoginResponseData>> login(
      {required LoginRequestData loginRequestData});
}
