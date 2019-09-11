import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wellywood/models/user.dart';

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

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

