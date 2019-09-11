import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'maps.dart';
import 'sidemenu.dart';

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
      body: MaterialApp(
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
                getPosts(),
                getPosts(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.camera_alt),
      ),
    );
  }

    Widget getPosts() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('posts').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Column(children: <Widget>[
                  InkWell(
                    child: Image.network(document['image']),
                    onTap: () {
                      goToMaps(document['location']);                 }),
                  ListTile(
                    title: Text(document['user']),
                    subtitle: Text(
                        (document['date'] as Timestamp).toDate().toString()),
                    trailing: (document['user'].toString().length == 0)
                        ? (CircleAvatar(
                            //child: Image.network(),
                            ))
                        : (CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Text(document['user'].toString()[0]),
                          )),
                  ),
                ]);
              }).toList(),
            );
        }
      },
    );
  }
  
  goToMaps(location) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Maps(location: location)));
  }
}
