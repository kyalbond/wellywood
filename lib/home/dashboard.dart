import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard();

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Icon(
        Icons.star,
        color: Colors.red[500],
      ),
    );
  }
}
