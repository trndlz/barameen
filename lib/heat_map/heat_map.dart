import 'package:barameen/heat_map/calendar.dart';
import 'package:barameen/heat_map/caption.dart';
import 'package:barameen/heat_map/statistics.dart';
import 'package:barameen/no_drinks.dart';
import 'package:barameen/sign_in.dart';
import 'package:barameen/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HeatMap extends StatelessWidget {

  HeatMap({Key key, this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    CollectionReference drinks =
    FirebaseFirestore.instance.collection('drinks');

    initializeDateFormatting('fr_FR', null);
    var formatter = new DateFormat("MMMM yyyy", 'fr');

    SliverList sliverHeadline(String content) {
      return SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(
              height: 50.0,
              child: Center(
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (user == null) {
      return loadingWidget(context);
    }

    return StreamBuilder<QuerySnapshot>(
      stream: drinks
          .orderBy('date', descending: false)
          .where("user_id", isEqualTo: user.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget(context);
        }

        Map<DateTime, num> data = {};
        if (snapshot.data.docs.length == 0) {
          return noDrinks(context);
        }

        num maxPower = 0;
        num sumPower = 0;
        DateTime maxDate = new DateTime(1000, 0, 0);

        snapshot.data.docs.forEach((element) {
          DateTime date = element.data()['date'].toDate();
          num power = element.data()['drinkPower'];
          if (data.containsKey(date)) {
            data[date] = data[date] + power;
          } else {
            data[date] = power;
          }
          sumPower += power;
          if (power > maxPower) {
            maxPower = power;
            maxDate = date;
          }
        });

        List<Widget> buildSliverList(Map<DateTime, num> data, num sumPower,
            num maxPower) {
          var firstDate = data.keys.first;
          var firstMonth = firstDate.month;
          var firstYear = firstDate.year;
          var lastDate = data.keys.last;
          var lastMonth = lastDate.month;
          var lastYear = lastDate.year;

          int numberOfDays = lastDate
              .difference(firstDate)
              .inDays + 1;

          List<Widget> list = [];
          for (var y = lastYear; y >= firstYear; y--) {
            for (var m = lastMonth; m >= firstMonth; m--) {
              list.add(sliverHeadline(formatter.format(new DateTime(y, m))));
              list.add(monthlyHeatMap(y, m, data));
            }
          }
          list.add(sliverHeadline("statistiques"));
          list.add(buildStatistics(sumPower, maxDate, numberOfDays));
          list.add(sliverHeadline("légende"));
          list.add(buildCaption());
          return list;
        }

        return Scaffold(
          backgroundColor: Colors.black,
          body: CustomScrollView(
            slivers: buildSliverList(data, sumPower, maxPower),
          ),
        );
      },
    );
  }
}
