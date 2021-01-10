import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ThemeData theme = ThemeData(
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
            color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
      ));

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong", textDirection: TextDirection.ltr);
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Bara Meen',
            theme: theme,
            home: LoginPage(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Text("Something went wrong", textDirection: TextDirection.ltr);
      },
    );
  }
}
