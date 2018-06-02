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
            }
            if (numbers.length == 0) {
              return new Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(
                      Icons.mood_bad,
                      size: 70.0,
                    ),
                    new Text("Nothing To Show Here Yet")
                  ],
                ),
              );
            } else {
              return new ListView.builder(
                itemCount: drugcount,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[numbers[index]];
                  return new Card(
                    elevation: 10.0,
                    margin: EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 10.0, bottom: 5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(
                            left: 30.0,
                            right: 10.0,
                            top: 10.0,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: new Icon(Icons.local_pharmacy),
                              radius: 40.0,
                              backgroundColor: Colors.cyan[100],
                            ),
                            title: getpharm(ds),
                            subtitle:
                                Text('distance to the pharmacy could go here'),
                          ),
                        ),
                        ButtonTheme.bar(
                          child: ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                child: const Text('Locate in Map'),
                                onPressed: () {},
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
      ),
    );
  }

  Widget getpharm(DocumentSnapshot d) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          "${d['Name']}",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        new Text("Price Here: Ghs ${d['Stock']['StockPrice']}"),
      ],
    );
  }
}
