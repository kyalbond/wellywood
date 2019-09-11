import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wellywood/pages/home/home.dart';
import 'package:wellywood/pages/login/signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Wellywood'),
        ),
        body: Column(
          children: <Widget>[
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
                      if (input.length < 7) {
                        return 'Your password needs to be atleast 8 characters';
                      }
                      return null;
                    },
                    onSaved: (input) => _password = input,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  RaisedButton(
                    onPressed: signIn,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0)),
                    child: Text('Login'),
                    color: Color.fromRGBO(254, 218, 0, 1),
                  ),
                  RaisedButton(
                    onPressed: signUp,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      side: BorderSide(
                          color: Color.fromRGBO(254, 218, 0, 1), width: 3),
                    ),
                    color: Colors.white,
                    child: Text('Sign Up'),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } catch (e) {
        print(e.message);
      }
    }
  }

  void signUp() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }
}
