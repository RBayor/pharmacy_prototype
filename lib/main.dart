import 'package:flutter/material.dart';
import 'package:pharmacy_prototype/screens/DisplayPharmacies.dart';
import 'package:pharmacy_prototype/screens/splash.dart';
import 'screens/home.dart';
import 'screens/search.dart';

//emulator -avd Nexus_5_API_27

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Navigation',
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => new Home(),
        '/Search': (BuildContext context) => new MedicationSearch(),
        '/Pharmacies': (BuildContext context)=> new DisplayPharmacies(drugname),
      },
      home: new Splash(),
    );
  }
}
