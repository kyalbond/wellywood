import 'package:flutter/material.dart';
import 'package:wellywood/routes.dart';

void main() => runApp(Wellywood());
//(254, 218, 0, 1)
class Wellywood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wellywood',
      initialRoute: '/',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(254, 218, 0, 1),
        backgroundColor: Color.fromRGBO(71, 71, 71, 1),
        ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
