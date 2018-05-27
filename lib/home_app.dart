import 'package:flutter/material.dart';

import 'constants.dart';

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Glyph Practise',
      home: new HomePage(),
//      routes: <String, WidgetBuilder>{
//        NAV_BASE: (BuildContext context) => new HomePage(),
//      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  createState() => new HomePageSate();
}

typedef void NavItemClicked(String itemName);

class HomePageSate extends State<HomePage> {
  final NavItemClicked itemClicked;

  HomePageSate({this.itemClicked});

  _notifyNavItemClicked(String itemName) {}

  _buildDrawer() {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: const Text('Glyph Practise'),
            accountEmail: const Text('1234567890'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.yellow,
            ),
          ),
          new ListTile(
              leading: new Icon(Icons.account_box),
              title: new Text(NAV_BASE),
              onTap: null),
          new ListTile(
              leading: new Icon(Icons.map),
              title: new Text(NAV_REMEMBER),
              onTap: null),
          new ListTile(
              leading: new Icon(Icons.adb),
              title: new Text(NAV_PRACTISE),
              onTap: null),
          new Divider(color: Colors.blueGrey),
          new ListTile(
              leading: new Icon(Icons.share),
              title: new Text(NAV_SHARE),
              onTap: null),
          new ListTile(
              leading: new Icon(Icons.feedback),
              title: new Text(NAV_FEEDBACK),
              onTap: null),
          new Divider(color: Colors.blueGrey),
          new ListTile(
              leading: new Icon(Icons.assignment_late),
              title: new Text(NAV_ABOUT),
              onTap: null)
        ],
      ),
    );
  }

  _buildBody() {
    return new Container();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Glyph Practise'),
      ),
      drawer: _buildDrawer(),
      body: _buildBody(),
    );
  }
}
