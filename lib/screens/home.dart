import 'package:flutter/material.dart';
import 'package:pharmacy_prototype/customWidget/Grid.dart';
import 'reuseable.dart';


 // This is the home screen of the app.
 // User will see a list of regions from which he can select.
 // Selecting a region will call on the search.dart class.


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
      drawer: new MyDrawer(
        context: context,
      ),
      body: new Container(
        child: new GridView.count(
          childAspectRatio: 1.6,
          crossAxisCount: 2,
          children: <Widget>[
            //Grid Class can be found at lib/customWidget/Grid.dart
            new Grid("Ashanti"),
            new Grid("Greater Accra"),
            new Grid("Northern"),
            new Grid("Central"),
            new Grid("Eastern"),
            new Grid("Western"),
            new Grid("Brong Ahafo"),
            new Grid("Upper East"),
            new Grid("Upper West"),
            new Grid("Volta"),
          ],
        ),
      ),
    );
  }
}
