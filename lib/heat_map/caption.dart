import 'package:barameen/helpers.dart';
import 'package:flutter/material.dart';

Map<String, int> captionData = {
  "~ 1 demi": 1,
  "~ 1 quart de vin": 3,
  "~ 4 pastis": 4,
  "~ 4 verres de vin": 5,
  "~ 3 pintes et un shot": 7,
  "~ 1 bouteille de vin": 8,
  "> 5 pintes": 9
};

List<Widget> buildCaptionWidgets = captionData.entries.map((entry) {
  return Padding(
    padding: const EdgeInsets.only(left: 20.0),
    child: Row(
      children: [
        Container(
          width: 15.0,
          height: 15.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorGradient(entry.value),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            entry.key,
            style: TextStyle(fontSize: 17, fontFamily: "Roboto"),
          ),
        )
      ],
    ),
  );
}).toList();

SliverList buildCaption() {
  return SliverList(
    delegate: SliverChildListDelegate(
      [
        Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: buildCaptionWidgets,
              ),
            )),
        SizedBox(height: 40),
      ],
    ),
  );
}
