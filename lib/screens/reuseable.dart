import 'package:flutter/material.dart';
import 'package:pharmacy_prototype/screens/health.dart';

// reuseable.dart contains classes that will be repeated throught the program.

// Provides the appbar
class MyAppBar extends AppBar {
  MyAppBar({Key key, Widget title, Icon icon, Function refreshTask})
      : super(
            key: key,
            title: title,
            centerTitle: true,
            backgroundColor: Colors.lightBlueAccent,
            actions: <Widget>[
              new IconButton(
                icon: icon,
                onPressed: () {refreshTask;},
              ),
            ]);
}

// Provides the drawer for the app.
class MyDrawer extends Drawer {
  MyDrawer({Key key, Widget child, BuildContext context})
      : super(
          key: key,
          child: ListView(
            //addRepaintBoundaries: true,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(14.0),
                color: Colors.black87,
                child: Column(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountEmail: null,
                      accountName: null,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('images/appbar_iconT.png'))),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('Home'),
                      leading: Icon(Icons.home),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/Home');
                      },
                    ),
                    ListTile(title: Text('Maps'), leading: Icon(Icons.map)),
                    ListTile(
                      title: Text('Favourites'),
                      leading: Icon(Icons.favorite),
                    ),
                    ListTile(
                      title: Text('Health'),
                      leading: Icon(Icons.help),
                      onTap: () {
                        Navigator.of(context).pop();
                        //Navigator.of(context).pushNamed('/Health');
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (BuildContext context) => new Health(),
                            ));
                      },
                    ),
                    Divider(
                      color: Colors.lightBlue[100],
                    ),
                    ListTile(
                        title: Text('Settings'), leading: Icon(Icons.settings)),
                    ListTile(
                        title: Text('About Us'),
                        leading: Icon(Icons.info)),
                    ListTile(
                        title: Text('Terms of Service'),
                        leading: Icon(Icons.info)),
                    Divider(
                      color: Colors.lightBlue[100],
                    ),
                    ListTile(
                        title: Text('Donate'),
                        leading: Icon(Icons.monetization_on)),
                  ],
                ),
              ),
            ],
          ),
        );
}
