import 'package:assist_agro/features/admin/presentation/pages/admin_page.dart';
import 'package:assist_agro/features/admin/presentation/pages/login_page.dart';

import '../../features/home/pages/home_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case HomePage.route:
        return MaterialPageRoute(
            builder: (_) => HomePage(), settings: settings);
      case LoginPage.route:
        return MaterialPageRoute(
            builder: (_) => LoginPage(), settings: settings);
      case AdminPage.route:
        return MaterialPageRoute(
            builder: (_) => AdminPage(), settings: settings);
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Container(),
      );
    });
  }
}
