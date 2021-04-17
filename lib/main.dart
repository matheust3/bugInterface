import 'package:assist_agro/core/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'features/admin/presentation/pages/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
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
      home: LoginPage(),
    );
  }
}
