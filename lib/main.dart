import 'package:flutter/material.dart';
import 'package:pharmacy_prototype/screens/DisplayPharmacies.dart';
import 'package:pharmacy_prototype/screens/splash.dart';
import 'screens/home.dart';
import 'screens/search.dart';
import 'screens/health.dart';

//emulator -avd Nexus_5_API_27

void main() {
  runApp(new MyApp());
}


class MyApp extends StatefulWidget {
  
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp>{
   @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Splash(),
      title: 'Navigation',
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => new Home(),
        '/Search': (BuildContext context) => new MedicationSearch(),
        '/Pharmacies': (BuildContext context)=> new DisplayPharmacies(drugname),
        '/Health' : (BuildContext context) => new Health(),
      },
      
    );
  }
}
