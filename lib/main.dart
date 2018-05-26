import 'package:flutter/material.dart';
import 'screens/home.dart';


//emulator -avd Nexus_5_API_27

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Navigation',
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => new Home(),
      },
      home: new Home(),
    );
  }
}