import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Home"),
      ),
      drawer: new Drawer(
          child: new ListView(children: <Widget>[
        new UserAccountsDrawerHeader(
            accountName: new Text('Shehana Iqbal'),
            accountEmail: new Text('iqbalshehana@gmail.com')),
        new ListTile(
          title: new Text("Home"),
          trailing: new Icon(Icons.arrow_forward_ios),
        ),
            new ListTile(
              title: new Text("Search History"),
              trailing: new Icon(Icons.arrow_forward_ios),
            ),
        new ListTile(
          title: new Text("Instructions"),
          trailing: new Icon(Icons.arrow_forward_ios),
        ),
        new ListTile(
          title: new Text("Settings"),
          trailing: new Icon(Icons.settings),
        ),
        new Divider(),
        new ListTile(
          title: new Text('Share'),
          trailing: new Icon(Icons.share),
        ),
        new ListTile(
          title: new Text('More about developers'),
          trailing: new Icon(Icons.more),
        )
      ])),

      
      body: new Center(
        child: new Text("Welcome to the Home Page",
            style: new TextStyle(fontSize: 24)),
            
      ),
    );
  }


}
