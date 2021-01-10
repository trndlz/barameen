import 'package:barameen/sign_in.dart';
import 'package:barameen/tab_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

final databaseReference = FirebaseFirestore.instance;

class _LoginPageState extends State<LoginPage> {

  bool _isLoggedIn = false;

  void initializeFlutterFire() async {
    FirebaseAuth.instance.authStateChanges()
        .listen((User user) {
          print("OOOOOOOO");
          print(user);
      if (user == null) {
        setState(() {
          _isLoggedIn = false;
        });
      } else {
        setState(() {
          _isLoggedIn = true;
        });
      }
    });
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _signInButton() {
      return OutlineButton(
        splashColor: Colors.grey,
        onPressed: () {
          signInWithGoogle().then((user) {
            if (user != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return TabPage(user: user);
                  },
                ),
              );
            }
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: AssetImage("assets/images/google_logo.png"),
                  height: 35.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Connection avec Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    if (_isLoggedIn) {
      return new TabPage();
    }
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: AssetImage("assets/images/beer.png"),
                  height: MediaQuery.of(context).size.width * 0.90),
              Text("Bara Meen", style: Theme.of(context).textTheme.subtitle1),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("Qu'est-ce que tu as bu aujourd'hui ?",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1)),
              SizedBox(height: 50),
              _signInButton()
            ],
          ),
        ),
      ),
    );
  }
}
