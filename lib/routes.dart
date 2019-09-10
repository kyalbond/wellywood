import 'package:flutter/material.dart';
import 'package:wellywood/help/help.dart';
import 'package:wellywood/login/login.dart';
import 'settings/settings.dart';
import 'home/home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/' :
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/settings':
        return MaterialPageRoute(builder: (_) => Settings());
      case '/help':
        return MaterialPageRoute(builder: (_) => Help());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }

}