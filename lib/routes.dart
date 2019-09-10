import 'package:flutter/material.dart';
import 'package:wellywood/pages/help/help.dart';
import 'package:wellywood/pages/login/login.dart';
import 'package:wellywood/pages/settings/settings.dart';
import 'package:wellywood/pages/home/home.dart';

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