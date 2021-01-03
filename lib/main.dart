import 'dart:ui';

import 'package:flutter/material.dart';

import 'login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bara Meen',
      theme: ThemeData(
          primaryColor: Colors.red[200],
          accentColor: Colors.red[600],
          fontFamily: 'Roboto',
          textTheme: TextTheme(
            subtitle1: TextStyle(fontSize: 72.0, fontFamily: 'Hanalei'),
            subtitle2: TextStyle(fontSize: 45.0, fontFamily: 'Hanalei', color: Colors.red[600]),
            bodyText1: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
            headline1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          )),
      home: LoginPage(),
    );
  }
}
