import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wellywood/models/user.dart';

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
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                unselectedLabelColor: Colors.black45,
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                getPosts('date'),
                getPosts('likes'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: takePhoto, //goToCamera,
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  Widget getPosts(sortBy) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('posts')
          .orderBy(sortBy, descending: true)
          .snapshots(),
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
                    onDoubleTap: () {
                      Firestore.instance
                          .collection('posts')
                          .document(document.documentID)
                          .updateData({'likes': document['likes'] + 1});
                    },
                    onLongPress: () {
                      goToMaps(document['location']);
                    },
                  ),
                  ListTile(
                    title: Text('Likes: ' + document['likes'].toString()),
                    subtitle: Text((document['date'] as Timestamp)
                        .toDate()
                        .toString()
                        .split('.')[0]),
                    trailing: CircleAvatar(
                        child: Text(document['user'].toString()[0], textScaleFactor: 1.5),
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.black,
                  
                  )
                  )]);
              }).toList(),
            );
        }
      },
    );
  }

  goToMaps(location) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Maps(location: location)));
  }

  File _image;

  Future<void> takePhoto() async {
    _image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );

    String imageURL = 'posts/' + DateTime.now().toString();

    StorageReference storageReference = FirebaseStorage().ref().child(imageURL);
    StorageUploadTask uploadTask = storageReference.putFile(_image);

    final StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) {
      print('EVENT ${event.type}');
    });

    await uploadTask.onComplete;

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var url = await storageReference.getDownloadURL() as String;

    Firestore.instance.collection('posts').document().setData({
      'date': Timestamp.now(),
      'image': url,
      'likes': 0,
      'user': user.displayName,
      'userID': user.uid,
      'location': GeoPoint(position.latitude, position.longitude),
    });

    streamSubscription.cancel();
  }
}
