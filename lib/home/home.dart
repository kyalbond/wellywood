import 'package:flutter/material.dart';
import 'package:wellywood/home/sidemenu.dart';
import 'package:wellywood/home/tabs.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: SideMenu(),
      body: Tabs(),
    );
  }
}
