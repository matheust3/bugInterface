import 'package:assist_agro/core/core/core_handler.dart';
import 'package:assist_agro/core/errors/failures.dart';
import 'package:assist_agro/core/models/usecase.dart';
import 'package:assist_agro/features/admin/domain/models/login_request_data.dart';
import 'package:assist_agro/features/admin/domain/models/login_response_data.dart';
import 'package:assist_agro/features/admin/domain/repositories/admin_repository.dart';

class LoginUseCase implements UseCase<LoginResponseData, LoginRequestData> {
  final AdminRepository adminRepository;

  LoginUseCase({required this.adminRepository});

  @override
  Future<CoreHandle<LoginResponseData>> call({LoginRequestData? param}) async {
    if (param != null) {
      return this.adminRepository.login(loginRequestData: param);
    } else {
      return CoreHandle(failure: NullArgumentFailure());
    }
  }
}
