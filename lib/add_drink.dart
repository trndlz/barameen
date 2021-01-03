import 'package:barameen/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDrink extends StatefulWidget {
  AddDrink({Key key}) : super(key: key);

  @override
  _AddDrink createState() => _AddDrink();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference drinks = FirebaseFirestore.instance.collection('drinks');

void addDrinkEvent(int drinksQty, num drinksVolume, num alcoholRate) {

    drinks.add({
      "user_id": userId,
      "date": new DateTime.now(),
      "drinkPower": drinksVolume * drinksQty * alcoholRate * 0.8,
    });

}

/// This is the private State class that goes with MyStatefulWidget.
class _AddDrink extends State<AddDrink> {
  int drinksQty = 1;
  num drinksVolume = 25;
  num alcoholRate = 5.0;

  @override
  Widget build(BuildContext context) {
    var alcohols = {"Bière": 5.0, "Vin": 12, "Cocktail": 12};

    print(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Aujourd'hui, j'ai bu",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              DropdownButton<int>(
                value: drinksQty,
                icon: Icon(Icons.arrow_downward),
                iconSize: 32,
                elevation: 24,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (int newValue) {
                  setState(() {
                    drinksQty = newValue;
                  });
                },
                items: <int>[1, 2, 3, 4, 5]
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
              Text(
                "verre(s) de",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              DropdownButton<num>(
                value: drinksVolume,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (num newValue) {
                  setState(() {
                    drinksVolume = newValue;
                  });
                },
                items: <num>[12.5, 25, 33, 50]
                    .map<DropdownMenuItem<num>>((num value) {
                  return DropdownMenuItem<num>(
                    value: value,
                    child: Text(value.toString() + 'cl'),
                  );
                }).toList(),
              ),
              Text("de", style: Theme.of(context).textTheme.bodyText1),
              DropdownButton<num>(
                value: alcoholRate,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (num newValue) {
                  setState(() {
                    alcoholRate = newValue;
                  });
                },
                items: alcohols.keys
                    .toList()
                    .map<DropdownMenuItem<num>>((String key) {
                  return DropdownMenuItem<num>(
                      value: alcohols[key], child: Text(key));
                }).toList(),
              ),
              OutlineButton(
                splashColor: Colors.grey,
                onPressed: () {
                  addDrinkEvent(drinksQty, drinksVolume, alcoholRate);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                borderSide: BorderSide(color: Colors.grey),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text('Valider',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
