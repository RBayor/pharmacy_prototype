import 'package:flutter/material.dart';
import 'reuseable.dart';

class Home extends StatefulWidget {
  _State createState() => new _State();
}

class _State extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new MyAppBar(
        title: Text('Regions'),
      ),
    drawer: new MyDrawer(context: context,),
    );
  }
}
