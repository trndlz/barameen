import 'package:barameen/helpers.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';

var dateUtility = DateUtil();

int numberOfDaysInMonth(int year, int month) {
  return dateUtility.daysInMonth(month, year);
}

int blankDays(int year, int month) {
  var firstDayOfMonth = DateTime(year, month, 1);
  var weekDay = firstDayOfMonth.weekday;
  return (weekDay - 1);
}

Container blankContainer() {
  return Container();
}


Container filledContainer(
    int day, int month, int year, Map<DateTime, num> data) {
  var dateTime = DateTime(year, month, day + 1);
  var idx = data.containsKey(dateTime) ? data[dateTime] : 0;
  return Container(
      alignment: Alignment.center,
      child: Text(
        '${day + 1}',
        style: TextStyle(fontSize: 17, fontFamily: "Roboto"),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorGradient(idx),
        border: idx != 0
            ? Border.all(color: Colors.black12)
            : Border.all(color: Colors.grey),
      ));
}

SliverPadding monthlyHeatMap(int year, int month, Map<DateTime, num> data) {
  var blankBeginning = blankDays(year, month);
  var days = numberOfDaysInMonth(year, month);
  return SliverPadding(
    padding: const EdgeInsets.all(25),
    sliver: SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          if (index < blankBeginning) {
            return blankContainer();
          } else {
            return filledContainer(
                index - blankBeginning, month, year, data);
          }
        },
        childCount: days + blankBeginning,
      ),
    ),
  );
}