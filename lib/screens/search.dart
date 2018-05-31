import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_prototype/screens/reuseable.dart';
import 'package:flutter/animation.dart';

int postnum;
String name;
String drugname;

class MedicationSearch extends StatefulWidget {
  _State createState() => new _State();
}

class _State extends State<MedicationSearch>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    controller = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
    animation =
        new CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    controller.addListener(() {
      this.setState(() {});
    });
    controller.repeat();
    
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MyAppBar(
        title: new Text("Medication"),
      ),
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
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                return new Container(
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.all(20.0),
                        //we'll put drug picture here
                        child: new CircleAvatar(
                          child: new Icon(Icons.local_pharmacy),
                          radius: 30.0,
                        ),
                      ),
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text("${ds['Stock']['StockName']}"),
                          new Text("Price: Ghs ${ds['Stock']['StockPrice']}"),
                          checkAvail(ds),
                          new Container(
                            margin: EdgeInsets.only(
                              top: 5.0
                            ),
                        decoration: new BoxDecoration(
                          color: Colors.blue
                        ),
                        width: 200.0,
                        height: 2.0,
                      ),
                        ],
                      ),
                      new Container(
                        margin: const EdgeInsets.only(left: 50.0),
                        child: new Column(
                          children: <Widget>[
                            new IconButton(
                              icon: new Icon(Icons.arrow_forward_ios),
                              iconSize: (3 + animation.value) * 9,
                              onPressed: () {
                                drugname = "${ds['Stock']['StockName']}";
                                Navigator.of(context).pushNamed("/Pharmacies");
                                },
                              color: Colors.blue,
                            ),
                            new Text(
                              "Stock",
                              textScaleFactor: 0.9,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

//Check if Stock is Available
  Widget checkAvail(DocumentSnapshot d) {
    if (d['Stock']['Available'])
      return new Text("Quantity: ${d['Stock']['Quantity']}");
    else {
      return new Text("Finished");
    }
  }
}
