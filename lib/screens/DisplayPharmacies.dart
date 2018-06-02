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

  getcount() async {
    CollectionReference ds = Firestore.instance.collection("/PharmacyDetails");
    await ds.getDocuments().then((doc) {
      doc.documents.forEach((f) {
        d.add(f);
      });
      setState(() {
        d.forEach((e) {
          if (e.data['Stock']['StockName'] == widget.drug) {
            drugcount++;
            numbers.add(i);
          }
          i++;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getcount();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: new MyAppBar(
        title: new Text(widget.drug),
      ),
      body: new Container(
        child: new StreamBuilder(
          stream: Firestore.instance.collection('PharmacyDetails').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Center(
                child: new CircularProgressIndicator(),
              );
            }if(numbers.length==0){
              return new Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(Icons.mood_bad,size: 70.0,),
                    new Text("Nothing To Show Here Yet")
                  ],
                ),
              );
            } 
            else {
              return new ListView.builder(
                itemCount: drugcount,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[numbers[index]];
                  return new Card(
                    child: new Container(
                      child: new Row(
                        children: <Widget>[
                          new Container(
                            margin: EdgeInsets.all(20.0),
                            child: getpharm(ds),
                          ),
                        ],
                      ),
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
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text("Pharmacy Name: ${d['Name']}"),
        new Text("Quantity:${d['Stock']['Quantity']}"),
      ],
    );
  }
}
