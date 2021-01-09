import 'package:barameen/add_drink.dart';
import 'package:barameen/heat_map.dart';
import 'package:barameen/settings_page.dart';
import 'package:flutter/material.dart';

void openSettingsPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
            title: Text('Paramètres',
                style: Theme.of(context).textTheme.bodyText2)),
        body: SettingsPage(),
      );
    },
  ));
}

void openAddDrinksPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
            title: Text('Ajouter un verre',
                style: Theme.of(context).textTheme.bodyText2)),
        body: AddDrink(),
      );
    },
  ));
}

class TabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  tooltip: 'Paramètres',
                  onPressed: () {
                    openSettingsPage(context);
                  },
                ),
              ],
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              centerTitle: true,
              title: Text('BARA MEEN',
                  style: Theme.of(context).textTheme.subtitle2)),
          body: TabBarView(
            children: [HeatMap(), AddDrink(), SettingsPage()],
          ),
          floatingActionButton: Container(
            width: 70.0,
            height: 70.0,
            child: FloatingActionButton(
              onPressed: () {
                openAddDrinksPage(context);
              },
              child: Icon(Icons.sports_bar, color: Colors.black, size: 30),
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
