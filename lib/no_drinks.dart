import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

Widget noDrinks(BuildContext context) {
  return Scaffold(
    body: Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Text(
                "Ta cartographie alcoolique est vide",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              height: MediaQuery.of(context).size.width * 0.60,
              image:
                  'https://trixiatrx.files.wordpress.com/2018/09/spaceman.gif',
            ),
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Text(
                  "Clique sur la bière si tu veux commencer",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ),
  );
}
