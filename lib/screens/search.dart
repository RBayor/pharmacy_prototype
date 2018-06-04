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
      backgroundColor: Colors.cyan[100],
      appBar: new MyAppBar(
        title: new Text("Medication"),
        icon: Icon(Icons.refresh),
      ),
      body: new StreamBuilder(
        stream: Firestore.instance.collection('Drugs').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          } else {
            return new ListView.builder(
              itemCount: snapshot.data.documents[0]['Drugs'].length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[0];
                return new Card(
                  elevation: 10.0,
                  margin: EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                    top: 10.0,
                    bottom: 5.0
                    ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(
                          left: 30.0,
                          right: 10.0,
                          top: 10.0,
                          bottom: 10.0
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: new Icon(Icons.local_pharmacy),
                            radius: 30.0,
                            backgroundColor: Colors.cyan[100],
                          ),
                          title: Text(
                            "${ds['Drugs'][index]}",
                            textScaleFactor: 1.2,
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          subtitle: Text(
                              'We can add a short description here... from firebase ofcus.'),
                          onTap: () {
                            drugname = "${ds['Drugs'][index]}";
                            Navigator.of(context).pushNamed("/Pharmacies");
                          },
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
