import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  MyAppBar({Key key, Widget title})
      : super(
            key: key,
            title: title,
            centerTitle: true,
            backgroundColor: Colors.green,
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ]);
}

class MyDrawer extends Drawer {
  final appBarLogo = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 50.0,
      child: Image.asset('images/appbar_icon.png'),
    ),
  );

  MyDrawer({Key key, Widget child, BuildContext context})
      : super(
          key: key,
          child: ListView(
            //addRepaintBoundaries: true,
            children: <Widget>[
              Container(
                /**
                 * 
                 * 
                 * 
                 * 
                 * Bandoh delete this and work with the color here
                 * 
                 * 
                 * 
                 * 
                 * 
                 */
                color: Colors.green,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
                    UserAccountsDrawerHeader(
                      accountEmail: null,
                      accountName: null,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('images/appbar_icon.png'))),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/Home');
                },
              ),
              ListTile(
                title: Text('Health Tips'),
                leading: Icon(Icons.help),
              ),
              ListTile(title: Text('Maps'), leading: Icon(Icons.map)),
              ListTile(
                title: Text('Pharmacies'),
                leading: Icon(Icons.local_pharmacy),
              ),
              Divider(
                height: 20.0,
              ),
              ListTile(
                  title: Text('Terms of Service'), leading: Icon(Icons.info)),
              ListTile(
                  title: Text('About Us'), leading: Icon(Icons.local_pharmacy)),
              ListTile(title: Text('Settings'), leading: Icon(Icons.settings)),
              Divider(
                height: 10.0,
              ),
              ListTile(
                  title: Text('Donate'), leading: Icon(Icons.monetization_on)),
            ],
          ),
        );
}
