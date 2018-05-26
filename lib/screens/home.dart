import 'package:flutter/material.dart';


class Home extends StatefulWidget {

  _State createState() =>  new _State();
}


class _State extends State<Home>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Regions'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.more_vert),
            onPressed: (){},
          ),
        ],
      ),
    );
  }

}