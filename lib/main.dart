import 'dart:ui';

import 'package:barameen/sign_in.dart';
import 'package:barameen/tab_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bara Meen',
      theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.red[600],
          fontFamily: 'Roboto',
          textTheme: TextTheme(
            bodyText2: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: "Bodoni",
            ),
            subtitle1: TextStyle(fontSize: 72.0, fontFamily: 'Hanalei'),
            subtitle2: TextStyle(
                fontSize: 45.0, fontFamily: 'Hanalei', color: Colors.white),
            bodyText1: TextStyle(
                fontSize: 27.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Yusei"),
            headline1: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          )),
      home: _auth.currentUser != null ? TabPage() : LoginPage(),
    );
  }
}
