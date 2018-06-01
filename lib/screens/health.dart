import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Health extends StatefulWidget {
  @override
  _HealthState createState() => new _HealthState();
}

class _HealthState extends State<Health> {
  var _isLoading = true;
  var users;

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  _fetchData() async {
    print("fetching data from network");

    final String url = "https://api.github.com/users/1";
    final result = await http.get(url);

    if (result.statusCode == 200) {
      final map = json.decode(result.body);

      final userJson = map;
      //print(user['id']);

      setState(() {
        _isLoading = false;
        this.users = userJson;
      });
    }
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
        child: _isLoading
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount:
                    1, //this.users.length != null ? this.users.length : 0,
                itemBuilder: (context, i) {
                  return Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Image.network("${this.users['avatar_url']}"),
                            Container(
                              height: 10.0,
                            ),
                            Text("name: ${this.users['name']}"),
                            Text("location: ${this.users['location']}"),
                            Text("followers: ${this.users['followers']}"),
                            Text("Join GitHub: ${this.users['created_at']}"),
                            Divider(
                              color: Colors.lightBlue,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
