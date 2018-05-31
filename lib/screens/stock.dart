import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_prototype/screens/reuseable.dart';

class Stock extends StatefulWidget {

  @override
  _StockState createState() => new _StockState();

  final int postid;
  final pharmname;
  Stock(this.postid,this.pharmname);
}

class _StockState extends State<Stock> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new MyAppBar(title: new Text("${widget.pharmname}"),),
      drawer: new MyDrawer(),
      body: new StreamBuilder(
        stream: Firestore.instance.collection('PharmacyDetails').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          } else {
            return new ListView.builder(
              itemCount: snapshot.data.documents[widget.postid]['Stock'].length,
              itemBuilder: (context, index) {
                return new Container(
                  margin: const EdgeInsets.only(
                    top: 40.0,
                    left: 30.0,
                  ),
                  child: new Text(
                    "${index+1}.  ${snapshot.data.documents[widget.postid]['Stock'][index]}",
                    textScaleFactor: 1.3,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
