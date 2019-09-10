import 'package:flutter/material.dart';
import 'package:wellywood/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wellywood',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        accentColor: Colors.yellowAccent 
        ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
