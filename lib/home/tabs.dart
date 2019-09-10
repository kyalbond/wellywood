import 'package:flutter/material.dart';
import 'package:wellywood/home/dashboard.dart';

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: Container(
            child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.trending_up)),
              ],
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Dashboard(),
              Icon(Icons.trending_up),
            ],
          ),
        ),
      ),
    );
  }
}
