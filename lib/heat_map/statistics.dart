import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

SliverList buildStatistics(num sumPower, DateTime maxDate, num numberOfDays) {
  var numberOfWeeks = numberOfDays < 7 ? 1 : (numberOfDays / 7).ceil();
  num pintPerWeek = sumPower / (2 * numberOfWeeks);
  var formatter = new DateFormat("d MMMM yyyy", 'fr');
  return SliverList(
    delegate: SliverChildListDelegate(
      [
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(Icons.timeline, color: Colors.white, size: 25),
                            SizedBox(width: 10),
                            Text(
                                "Tu bois environ ${pintPerWeek.toStringAsFixed(1)} pintes / semaine",
                                style: TextStyle(
                                    fontSize: 17, fontFamily: "Roboto"))
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.local_fire_department,
                                color: Colors.white, size: 25),
                            SizedBox(width: 10),
                            Text(
                                "Ta plus grosse cuite: le ${formatter.format(maxDate)}",
                                style: TextStyle(
                                    fontSize: 17, fontFamily: "Roboto"))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
      ],
    ),
  );
}
