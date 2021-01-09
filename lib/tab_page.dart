import 'package:barameen/add_drink.dart';
import 'package:barameen/heat_map.dart';
import 'package:barameen/settings_page.dart';
import 'package:flutter/material.dart';

class TabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.sports_bar)),
                  Tab(icon: Icon(Icons.add)),
                  Tab(icon: Icon(Icons.settings)),
                ],
                indicatorColor: Colors.red,
              ),
              backgroundColor: Colors.black,
              centerTitle: true,
              title: Text('BARA MEEN',
                  style: Theme.of(context).textTheme.subtitle2)),
          body: TabBarView(
            children: [
              HeatMap(),
              AddDrink(),
              SettingsPage()
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
