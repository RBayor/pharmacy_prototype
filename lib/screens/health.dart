import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Health extends StatefulWidget {
  @override
  _HealthState createState() => new _HealthState();
}

class _HealthState extends State<Health> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  List data;
  final String url = "https://api.github.com/users";

  _fetchData() async {
    print("fetching data from network");

    http.Response response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var holder = json.decode(response.body);
    setState(() {
      _isLoading = false;
      data = holder;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Daily Health Tips"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                print('Refreshing...');
                setState(() {
                  _isLoading = true;
                });
                _fetchData();
              },
            )
          ],
        ),
        body: Center(
            child: _isLoading == true
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: data.length != null ? data.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 5.0,
                        margin: EdgeInsets.only(
                            left: 12.0, right: 12.0, top: 10.0, bottom: 5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.network(data[index]['avatar_url']),
                            Text('Name: ${data[index]['login']}'),
                            Text('Acc Type: ${data[index]['type']}')
                          ],
                        ),
                      );
                    })));
  }
}
