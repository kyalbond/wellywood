import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wellywood/pages/home/home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => new _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email, _password, _username;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Column(children: <Widget>[
          Container(
            child: Image.asset('assets/logo.png'),
            padding: EdgeInsets.all(40),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Please provide an email';
                    }
                    return null;
                  },
                  onSaved: (input) => _email = input,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Please provide a username';
                    }
                    return null;
                  },
                  onSaved: (input) => _username = input,
                  decoration: InputDecoration(labelText: 'Display Name'),
                ),
                TextFormField(
                  validator: (input) {
                    if (input.length < 8) {
                      return 'Your password needs to be atleast 8 characters';
                    }
                    return null;
                  },
                  onSaved: (input) => _password = input,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                RaisedButton(
                  onPressed: signUp,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                  child: Text('Submit'),
                  color: Color.fromRGBO(254, 218, 0, 1),
                )
              ],
            ),
          )
        ]));
  }

  Future<void> signUp() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      final FirebaseUser user =
          (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      ))
              .user;

      UserUpdateInfo update = new UserUpdateInfo();
      update.displayName = _username;

      user.updateProfile(update);
    }
  }
}
