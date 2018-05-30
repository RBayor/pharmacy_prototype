import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_prototype/screens/reuseable.dart';

class DisplayPharmacies extends StatefulWidget {
  final String drug;
  DisplayPharmacies(this.drug);

  @override
  _DisplayPharmaciesState createState() => new _DisplayPharmaciesState();
}

class _DisplayPharmaciesState extends State<DisplayPharmacies> {
  int drugcount = 0;
  List<DocumentSnapshot> d = [];
  List<int> numbers = [];
  int i = 0;
  @override
  void initState() {
    CollectionReference ds = Firestore.instance.collection("/PharmacyDetails");
    ds.getDocuments().then((doc) {
      doc.documents.forEach((f) {
        d.add(f);
      });
      d.forEach((e) {
        if (e.data['Stock']['StockName'] == widget.drug) {
          drugcount++;
          numbers.add(i);
        }
        i++;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new MyAppBar(
        title: new Text("Pharmacies"),
      ),
      body: new Container(
        child: new StreamBuilder(
          stream: Firestore.instance.collection('PharmacyDetails').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Center(
                child: new CircularProgressIndicator(),
              );
            } else {
              return new ListView.builder(
                itemCount: drugcount,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[numbers[index]];
                  return new Container(
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.all(20.0),
                          child: getpharm(ds),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget getpharm(DocumentSnapshot d) {
    if ("${d['Stock']['StockName']}" == "${widget.drug}") {
      return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text("Pharmacy Name: ${d['Name']}"),
          new Container(
            margin: EdgeInsets.only(top: 15.0),
            decoration: new BoxDecoration(color: Colors.blue),
            width: 200.0,
            height: 2.0,
          ),
        ],
      );
    } else {
      return new Center(
        child: new Text("Nothing To Display Here"),
      );
    }
  }
}
