import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/home.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  String googleAppId;
  String apiKey;
  String databaseURL;

  new File('json/config.json')
      .readAsString()
      .then((fileContents) => json.decode(fileContents))
      .then((jsonData) {
    googleAppId = jsonData['googleAppId'];
    apiKey = jsonData['apiKey'];
    databaseURL = jsonData['databaseURL'];
  });

  final FirebaseApp app = await FirebaseApp.configure(
      name: 'db2',
      options: FirebaseOptions(
          googleAppID: googleAppId, apiKey: apiKey, databaseURL: databaseURL));

  runApp(new MaterialApp(
    home: new Splash(),
    routes: <String, WidgetBuilder>{
      '/Home': (BuildContext context) => new Home(app: app)
    },
  ));
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Home');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Splash!'),
      ),
    );
  }
}
