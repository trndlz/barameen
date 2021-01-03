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
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
            subtitle1: TextStyle(fontSize: 72.0, fontFamily: 'Hanalei'),
            bodyText1: TextStyle(fontSize: 27.0)
        )
      ),
      home: LoginPage(),
    );
  }
}