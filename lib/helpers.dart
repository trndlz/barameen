import 'package:flutter/material.dart';

Color colorGradient(num alcoholUnit) {
  if (alcoholUnit == 0.0) {
    return Colors.black;
  } else if (alcoholUnit <= 1) {
    return Colors.red[100];
  } else if (alcoholUnit <= 2) {
    return Colors.red[200];
  } else if (alcoholUnit <= 3) {
    return Colors.red[300];
  } else if (alcoholUnit <= 4) {
    return Colors.red[400];
  } else if (alcoholUnit <= 5) {
    return Colors.red[500];
  } else if (alcoholUnit <= 6) {
    return Colors.red[600];
  } else if (alcoholUnit <= 7) {
    return Colors.red[700];
  } else if (alcoholUnit <= 8) {
    return Colors.red[800];
  } else if (alcoholUnit < 9) {
    return Colors.red[900];
  } else {
    return Colors.purpleAccent;
  }
}
