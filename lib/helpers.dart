import 'package:flutter/material.dart';

Color colorGradient(num ratio) {
  if (ratio == 0.0) {
    return Colors.black;
  } else if (ratio < 0.1) {
    return Colors.red[100];
  } else if (ratio < 0.2) {
    return Colors.red[200];
  } else if (ratio < 0.3) {
    return Colors.red[300];
  } else if (ratio < 0.4) {
    return Colors.red[400];
  } else if (ratio < 0.5) {
    return Colors.red[500];
  } else if (ratio < 0.6) {
    return Colors.red[600];
  } else if (ratio < 0.7) {
    return Colors.red[700];
  } else if (ratio < 0.8) {
    return Colors.red[800];
  } else if (ratio < 0.9) {
    return Colors.red[900];
  } else {
    return Colors.purpleAccent;
  }
}
