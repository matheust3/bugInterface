import 'package:assist_agro/core/adapters/web_adapter.dart';
import 'package:assist_agro/core/core/admin_data.dart';
import 'package:assist_agro/features/admin/data/datasources/login_datasource.dart';
import 'package:assist_agro/features/admin/data/repositories/admin_repository_impl.dart';
import 'package:assist_agro/features/admin/domain/repositories/admin_repository.dart';
import 'package:assist_agro/features/admin/domain/usecases/login.dart';
import 'package:assist_agro/features/admin/presentation/cubits/login_page/login_page_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/navigator/navigator_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<AdminData>(() => AdminData(sharedPreferences));
  sl.registerLazySingleton<NavigatorService>(() => NavigatorServiceImpl());
  sl.registerLazySingleton<WebAdapter>(() => WebAdapterImpl(adminData: sl()));
  //! Features
  await admin();
}

Future<void> admin() async {
  //! datasources
  sl.registerLazySingleton<LoginDatasource>(
      () => LoginDatasourceImpl(webAdapter: sl()));
  //! repositories
  sl.registerLazySingleton<AdminRepository>(
      () => AdminRepositoryImpl(loginDatasource: sl(), adminData: sl()));
  //! useCases
  sl.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(adminRepository: sl()));
  //! cubits
  sl.registerFactory(
      () => LoginPageCubit(loginUseCase: sl(), navigatorService: sl()));
}
