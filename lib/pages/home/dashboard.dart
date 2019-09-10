import 'package:flutter/material.dart';
import 'package:wellywood/services/database.dart';

class Dashboard extends StatefulWidget {
  final String sort;

  Dashboard(this.sort);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return GetPosts();
  }
}