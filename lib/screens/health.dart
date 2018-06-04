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

  var data;
  final String url =
      "https://newsapi.org/v2/top-headlines?sources=medical-news-today&apiKey=afd62a89063d49509471031e7f44c047";

  _fetchData() async {
    print("fetching data from network");

    http.Response response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      _isLoading = false;
      this.data = json.decode(response.body);
      //print(data['articles'][2]['author']);
    });
  }

  List<bool> fav = [];
  _favnewcount(int id) {
    for (int i = 0; i <= id; i++) {
      fav.add(false);
    }
  }

  favchange(int i) {
    setState(() {
      if (fav[i]) {
        fav[i] = false;
      } else {
        fav[i] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Your Daily Health"),
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
                    itemCount: data['articles'].length != null
                        ? data['articles'].length
                        : 0,
                    itemBuilder: (BuildContext context, int index) {
                      _favnewcount(data['articles'].length);
                      return Card(
                        elevation: 5.0,
                        margin: EdgeInsets.only(
                            left: 12.0, right: 12.0, top: 10.0, bottom: 5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image
                                .network(data['articles'][index]['urlToImage']),
                            new Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0,
                                  right: 10.0,
                                  top: 2.0,
                                  bottom: 5.0),
                              child: ListTile(
                                  //Image.network(data['articles'][index]['urlToImage']),
                                  title: Text(
                                    '${data['articles'][index]['title']}',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                      '${data['articles'][index]['description']}'),
                                  onTap:
                                      () {}, // We will open the full article here for reading,
                                  onLongPress: () {
                                    favchange(index);
                                  } // This add article to favorites,
                                  ),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                new IconButton(
                                    icon: new Icon(
                                      Icons.share,
                                      color: Colors.cyan,
                                    ),
                                    onPressed: () {}),
                                new IconButton(
                                  icon: (fav[index])
                                      ? new Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : new Icon(
                                          Icons.favorite_border,
                                          color: Colors.red,
                                        ),
                                  onPressed: () {
                                    favchange(index);
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    })));
  }
}
