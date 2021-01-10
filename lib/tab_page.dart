import 'package:barameen/add_drink.dart';
import 'package:barameen/heat_map/heat_map.dart';
import 'package:barameen/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void openSettingsPage(BuildContext context, User user) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
            title: Text('Paramètres',
                style: Theme.of(context).textTheme.bodyText2)),
        body: SettingsPage(user: user),
      );
    },
  ));
}

void openAddDrinksPage(BuildContext context, User user) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
            title: Text('Ajouter un verre',
                style: Theme.of(context).textTheme.bodyText2)),
        body: AddDrink(user: user),
      );
    },
  ));
}

class TabPage extends StatelessWidget {

  TabPage({Key key, this.user}) : super(key: key);
  final User user;

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
                    openSettingsPage(context, user);
                  },
                ),
              ],
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              centerTitle: true,
              title: Text('BARA MEEN',
                  style: Theme.of(context).textTheme.subtitle2)),
          body: TabBarView(
            children: [HeatMap(user: user), AddDrink(user: user), SettingsPage(user: user)],
          ),
          floatingActionButton: Container(
            width: 70.0,
            height: 70.0,
            child: FloatingActionButton(
              onPressed: () {
                openAddDrinksPage(context, user);
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
