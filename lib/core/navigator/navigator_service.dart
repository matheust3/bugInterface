import 'package:flutter/material.dart';

abstract class NavigatorService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateToAndRemoveUtil(String routeName, {Object arguments});

  Future<dynamic> navigateTo(String routeName, {Object arguments});

  void popUntil(String routeName);

  bool canPop();

  bool pop();
}

class NavigatorServiceImpl implements NavigatorService {
  @override
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  @override
  Future<dynamic> navigateToAndRemoveUtil(String routeName,
      {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, ModalRoute.withName("/"),
        arguments: arguments);
  }

  @override
  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  @override
  void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  @override
  bool pop() {
    navigatorKey.currentState!.pop();
    return true;
  }

  @override
  bool canPop() {
    return navigatorKey.currentState!.canPop();
  }
}
