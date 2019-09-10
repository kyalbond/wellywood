import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellywood/models/user.dart';

class Database {
  
  User getUser(uid) {
    try {
      Firestore.instance
          .collection("users")
          .document(uid)
          .get()
          .then((DocumentSnapshot ds) {
        return new User(ds.data['username'], ds.data['userIcon']);
      });
    } catch (e) {
      print('Failed to get user: ' + e);
    }
    return null;
  }

}

class GetPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('posts').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['user']),
                  subtitle: new Text(document['likes']),
                );
              }).toList(),
            );
        }
      },
    );
  }
}