import 'package:flutter/material.dart';

Widget loadingWidget (BuildContext context){
  return Scaffold(
    body: Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    ),
  );
}