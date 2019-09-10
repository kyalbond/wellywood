import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
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
                return new ListTile(
                    title: Text(document['user']),
                    subtitle: Text((document['date'] as Timestamp).toDate().toString()),
                    trailing: (true == false) 
                        ? (CircleAvatar(
                            //TODO: UTILISE USER ICON
                          ))
                        : (CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Text(document['user'].toString()[0]),
                          ))
                    );
              }).toList(),
            );
        }
      },
    );
  }
}
