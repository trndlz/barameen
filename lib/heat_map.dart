import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';

class HeatMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dateUtility = DateUtil();

    int numberOfDaysInMonth(int year, int month) {
      return dateUtility.daysInMonth(month, year);
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

    SliverPadding monthlyHeatMap(int days) {
      return SliverPadding(
        padding: const EdgeInsets.all(10),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 50.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.0,
          ),
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                child: Text('${index + 1}'),
                decoration: BoxDecoration(
                    color: Colors.red[100 * (index % 10)],
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(2)),
              );
            },
            childCount: days,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          monthContainer("février 2020"),
          monthlyHeatMap(28),
          monthContainer("mars 2020"),
          monthlyHeatMap(30),
          monthContainer("avril 2020"),
          monthlyHeatMap(31)
        ],
      ),

      // children: [
      //   Text("Février 2020"),
      //   Expanded(
      //     child: Container(
      //       child: GridView.count(
      //         primary: false,
      //         padding: const EdgeInsets.all(20),
      //         crossAxisSpacing: 10,
      //         mainAxisSpacing: 10,
      //         crossAxisCount: 7,
      //         children: list,
      //       ),
      //     ),
      //   ),
      //   Text("Mars 2020"),
      //   Expanded(
      //     child: Container(
      //       child: GridView.count(
      //         primary: false,
      //         padding: const EdgeInsets.all(20),
      //         crossAxisSpacing: 10,
      //         mainAxisSpacing: 10,
      //         crossAxisCount: 7,
      //         children: list,
      //       ),
      //     ),
      //   ),
      //   Text("Mars 2020"),
      //   Expanded(
      //     child: Container(
      //       child: GridView.count(
      //         primary: false,
      //         padding: const EdgeInsets.all(20),
      //         crossAxisSpacing: 10,
      //         mainAxisSpacing: 10,
      //         crossAxisCount: 7,
      //         children: list,
      //       ),
      //     ),
      //   ),
      //   Text("Mars 2020"),
      //   Expanded(
      //     child: Container(
      //       child: GridView.count(
      //         primary: false,
      //         padding: const EdgeInsets.all(20),
      //         crossAxisSpacing: 10,
      //         mainAxisSpacing: 10,
      //         crossAxisCount: 7,
      //         children: list,
      //       ),
      //     ),
      //   ),
      // ],
    );
  }
}
