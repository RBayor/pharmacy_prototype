import 'package:flutter/material.dart';

class Grid extends StatefulWidget{
  @override
  State createState()=> new _Grid();
  final String city;
  Grid(this.city);
}

class _Grid extends State<Grid>{
  @override
  Widget build(BuildContext context) {
      // These Are Icon Buttons so We cant do onpressed from here
      return new Container(
            margin: const EdgeInsets.all(10.0),
            child: new Card(
              color: Colors.lime[50],
              elevation: 4.0,
            child: new Container(
            margin: const EdgeInsets.all(40.0),
            child: new Column(
              children: <Widget>[
                new IconButton(
            onPressed: (){},
            iconSize: 50.0,
            icon: new Icon(Icons.location_city),
          ),
          new Container(
            margin: const EdgeInsets.only(
              top: 10.0
            ),
            child: new Text("${widget.city}",textScaleFactor: 1.0,),
          )
              ],
            ),
          ),
          ),
          );
    }
}