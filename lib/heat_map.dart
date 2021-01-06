import 'package:barameen/sign_in.dart';
import 'package:barameen/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';

class HeatMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference drinks =
        FirebaseFirestore.instance.collection('drinks');

    var dateUtility = DateUtil();

    int numberOfDaysInMonth(int year, int month) {
      return dateUtility.daysInMonth(month, year);
    }

    int blankDays(int year, int month) {
      var firstDayOfMonth = DateTime(year, month, 1);
      var weekDay = firstDayOfMonth.weekday;
      return (weekDay - 1);
    }

    SliverList monthContainer(String month) {
      return SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(
              height: 50.0,
              child: Center(
                child: Text(
                  month,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Container blankContainer() {
      return Container();
    }

    Color getColor(num ratio) {
      if (ratio == 0.0) {
        return Colors.white;
      } else if (ratio < 0.1) {
        return Colors.yellow[100];
      } else if (ratio < 0.2) {
        return Colors.yellow[200];
      } else if (ratio < 0.3) {
        return Colors.yellow[300];
      } else if (ratio < 0.4) {
        return Colors.yellow[400];
      } else if (ratio < 0.5) {
        return Colors.yellow[500];
      } else if (ratio < 0.6) {
        return Colors.yellow[600];
      } else if (ratio < 0.7) {
        return Colors.yellow[700];
      } else if (ratio < 0.8) {
        return Colors.yellow[800];
      } else if (ratio < 0.9) {
        return Colors.yellow[900];
      } else if (ratio < 1) {
        return Colors.red;
      } else {
        return Colors.purpleAccent;
      }
    }

    Container filledContainer(
        int day, int month, int year, Map<DateTime, num> data, num maxPower) {
      var dateTime = DateTime(year, month, day + 1);
      var idx = data.containsKey(dateTime) ? data[dateTime] / maxPower : 0;
      return Container(
        alignment: Alignment.center,
        child: Text('${day + 1}'),
        decoration: BoxDecoration(
            color: getColor(idx),
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(10)),
      );
    }

    SliverPadding monthlyHeatMap(
        int year, int month, Map<DateTime, num> data, num maxPower) {
      var blankBeginning = blankDays(year, month);
      var days = numberOfDaysInMonth(year, month);
      return SliverPadding(
        padding: const EdgeInsets.all(25),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index < blankBeginning) {
                return blankContainer();
              } else {
                return filledContainer(
                    index - blankBeginning, month, year, data, maxPower);
              }
            },
            childCount: days + blankBeginning,
          ),
        ),
      );
    }

    return FutureBuilder<QuerySnapshot>(
      future: drinks
          .orderBy('date', descending: false)
          .where("user_id", isEqualTo: userId)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          num maxPower = 0;

          Map<DateTime, num> data = {};



          if (snapshot.data.docs.isEmpty) {
            return Scaffold(
              backgroundColor: Colors.green,
              body: Text("TU BOIS OU QUOI !?"),
            );
          }

          snapshot.data.docs.forEach((element) {
            DateTime date = element.data()['date'].toDate();
            num power = element.data()['drinkPower'];
            if (data.containsKey(date)) {
              data[date] = data[date] + power;
            } else {
              data[date] = power;
            }
            maxPower = data[date] > maxPower ? data[date] : maxPower;
          });


          var firstDate = data.keys.first;
          var firstMonth = firstDate.month;
          var firstYear = firstDate.year;
          var lastDate = data.keys.last;
          var lastMonth = lastDate.month;
          var lastYear = lastDate.year;

          List<Widget> buildSliverList(
              int firstMonth,
              int firstYear,
              int lastMonth,
              int lastYear,
              Map<DateTime, num> data,
              num maxPower) {
            List<Widget> list = [];
            for (var y = lastYear; y >= firstYear; y--) {
              for (var m = lastMonth; m >= firstMonth; m--) {
                list.add(monthContainer("$m / $y"));
                list.add(monthlyHeatMap(y, m, data, maxPower));
              }
            }
            return list;
          }



          return Scaffold(
            body: CustomScrollView(
              slivers: buildSliverList(
                  firstMonth, firstYear, lastMonth, lastYear, data, maxPower),
            ),
          );
        };

        return loadingWidget(context);
      },
    );
  }
}
