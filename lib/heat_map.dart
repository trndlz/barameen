import 'package:barameen/helpers.dart';
import 'package:barameen/no_drinks.dart';
import 'package:barameen/sign_in.dart';
import 'package:barameen/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HeatMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference drinks =
        FirebaseFirestore.instance.collection('drinks');

    initializeDateFormatting('fr_FR', null);
    var formatter = new DateFormat("MMMM yyyy", 'fr');
    var dateUtility = DateUtil();

    int numberOfDaysInMonth(int year, int month) {
      return dateUtility.daysInMonth(month, year);
    }

    int blankDays(int year, int month) {
      var firstDayOfMonth = DateTime(year, month, 1);
      var weekDay = firstDayOfMonth.weekday;
      return (weekDay - 1);
    }

    SliverList monthContainer(int month, int year) {
      return SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(
              height: 50.0,
              child: Center(
                child: Text(
                  formatter.format(new DateTime(year, month)),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2,
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

    Container filledContainer(
        int day, int month, int year, Map<DateTime, num> data, num maxPower) {
      var dateTime = DateTime(year, month, day + 1);
      var idx = data.containsKey(dateTime) ? data[dateTime] / maxPower : 0;
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
                : Border.all(color: Colors.transparent),
          ));
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
          if (snapshot.data.docs.length == 0) {
            return noDrinks(context);
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
                list.add(monthContainer(m, y));
                list.add(monthlyHeatMap(y, m, data, maxPower));
              }
            }
            return list;
          }

          return Scaffold(
            backgroundColor: Colors.black,
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
