import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';


class Grid extends StatefulWidget {
  @override
  State createState() => new _Grid();
  final String city;
  Grid(this.city);
}

class _Grid extends State<Grid> with SingleTickerProviderStateMixin {
  Animation coloranimation;
  Animation iconanim;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
    coloranimation = new ColorTween(begin: Colors.white, end: Colors.lime[50])
        .animate(_controller);
    iconanim =
        new CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    _controller.addListener(() {
      this.setState(() {});
    });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // These Are Icon Buttons so We can do onpressed from here
    return new Container(
      margin: const EdgeInsets.all(10.0),
      child: new Card(
        color: coloranimation.value,
        elevation: 3.0,
        child: new Container(
          child: new Column(
            children: <Widget>[
              new IconButton(
                // Working on a way to link the regions to the search page passing 
                // the context
                onPressed: () {Navigator.of(context).pushNamed("/Search");},
                iconSize: iconanim.value * 50.0,
                icon: new Icon(Icons.location_city),
              ),
              new Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: new Text(
                  "${widget.city}",
                  textScaleFactor: 1.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
