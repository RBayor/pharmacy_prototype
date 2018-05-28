import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_prototype/screens/reuseable.dart';
import 'package:flutter/animation.dart';

int postnum;
String name;

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
        duration: new Duration(milliseconds: 800), vsync: this);
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
      appBar: new MyAppBar(title: new Text("Pharmacies"),),
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
                        child: new CircleAvatar(
                          child: new Icon(Icons.person_add),
                          radius: 30.0,
                        ),
                      ),
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text("Name: ${ds['Name']}"),
                          new Text("Email: ${ds['E-mail']}"),
                          new Text("Phone Number: ${ds['PhoneNumber']}"),
                          new Text("Location: ${ds['Location']}"),
                        ],
                      ),
                      new Container(
                        margin: const EdgeInsets.only(left: 50.0),
                        child: new Column(
                          children: <Widget>[
                            new IconButton(
                              icon: new Icon(Icons.arrow_forward),
                              iconSize: (3 + animation.value) * 9,
                              onPressed: () {
                                postnum = index;
                                name = ds['Name'];
                                Navigator.of(context).pushNamed("/stock");
                              },
                              color: Colors.red,
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
}
