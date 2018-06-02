import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class Splash extends StatefulWidget{
  @override
  State createState() => new _Splash();
}

class _Splash extends State<Splash> with SingleTickerProviderStateMixin{

Animation _animation;
Animation _animationcolor;
AnimationController _controller;

@override
void initState() {
    super.initState();
    _controller = new AnimationController(duration: new Duration(milliseconds: 2000),vsync: this);
    _animation = new CurvedAnimation(parent: _controller,curve: Curves.bounceOut);
    _animationcolor = new ColorTween(begin: Colors.transparent, end: Colors.white).animate(_controller);
    _controller.addListener((){
      this.setState((){

      });
    });
    _controller.forward();
  }

  @override
  void dispose() {
      _controller.dispose();
      super.dispose();
    }


  @override
  Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        backgroundColor: Colors.cyan,
        body: new Center(
          child: new Container(
          margin: EdgeInsets.only(
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(
                  top: _animation.value*80
                ),
                child: new Text("Virtual Pharm",textScaleFactor: 2.5,style: new TextStyle(
                  color: _animationcolor.value
                ),),
              ),
              new Container(
                child: new Container(
                  height: 5.0,
                  width: _animation.value*150,
                  decoration: new BoxDecoration(
                    color: _animationcolor.value
                  ),
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(
                  top: 5.0
                ),
                child: new Container(
                  height: 5.0,
                  width: _animation.value*90,
                  decoration: new BoxDecoration(
                    color: _animationcolor.value
                  ),
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(
                  top: 5.0
                ),
                child: new Container(
                  height: 5.0,
                  width: _animation.value*50,
                  decoration: new BoxDecoration(
                    color: _animationcolor.value
                  ),
                ),
              ),
              new Container(
                margin:  const EdgeInsets.only(
                  top: 50.0
                ),
                child: new FlatButton(
                child: new Text("Next",textScaleFactor: 2.0,style: new TextStyle(
                  color: _animationcolor.value
                ),),
                onPressed: (){Navigator.of(context).pushNamedAndRemoveUntil('/Home',(Route<dynamic>route)=>false);},
              ),
              )
            ],
          ),

        ),
        )
      );
    }
}