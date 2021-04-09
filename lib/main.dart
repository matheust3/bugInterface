import 'package:assist_agro/core/navigator/navigator_service.dart';
import 'package:assist_agro/core/navigator/route_generator.dart';
import 'package:assist_agro/core/util/app_colors.dart';
import 'package:assist_agro/features/admin/presentation/pages/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await init();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AssistAgro',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          hintColor: AppColors.hintColor,
          unselectedWidgetColor: AppColors.labelText),
      initialRoute: AdminPage.route,
      navigatorKey: sl<NavigatorService>().navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
