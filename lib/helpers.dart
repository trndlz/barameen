import 'package:flutter/material.dart';

Color colorGradient(num UANb) {
  if (UANb == 0.0) {
    return Colors.black;
  } else if (UANb <= 1) {
    return Colors.red[100];
  } else if (UANb <= 2) {
    return Colors.red[200];
  } else if (UANb <= 3) {
    return Colors.red[300];
  } else if (UANb <= 4) {
    return Colors.red[400];
  } else if (UANb <= 5) {
    return Colors.red[500];
  } else if (UANb <= 6) {
    return Colors.red[600];
  } else if (UANb <= 7) {
    return Colors.red[700];
  } else if (UANb <= 8) {
    return Colors.red[800];
  } else if (UANb < 9) {
    return Colors.red[900];
  } else {
    return Colors.purpleAccent;
  }
}
