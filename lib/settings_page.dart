import 'package:barameen/login_page.dart';
import 'package:barameen/sign_in.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 40),
              Text(
                'NAME',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 20),
              Text(
                'EMAIL',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                email,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 40),
              CheckboxListTile(
                  value: true,
                  secondary: const Icon(Icons.notifications),
                  title: Text("Activation des notifications",
                      style: Theme.of(context).textTheme.headline1),
                  onChanged: null),
              RaisedButton(
                onPressed: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }), ModalRoute.withName('/'));
                },
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Se déconnecter',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
