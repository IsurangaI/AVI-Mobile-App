import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/pages/History.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import './History.dart';

void main() => runApp(Camera());

class Camera extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _uploadFile(image);

    setState(() {
      _image = image;
    });
  }

  // Methode for file upload
  void _uploadFile(filePath) async {
    // Get base file name
    String fileName = basename(filePath.path);
    print("File base name: $fileName");

    try {
      FormData formData =
          new FormData.from({"file": new UploadFileInfo(filePath, fileName)});

      Response response =
          await Dio().post("http://192.168.0.101/saveFile.php", data: formData);
      print("File upload response: $response");

      // Show the incoming message in snakbar
      _showSnakBarMsg(response.data['message']);
    } catch (e) {
      print("Exception Caught: $e");
    }
  }

  // Method for showing snak bar message
  void _showSnakBarMsg(String msg) {
    _scaffoldstate.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.amber,
      key: _scaffoldstate,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title), backgroundColor: Color(0xff000000),
      ),

      drawer: new Drawer(
          child: new ListView(children: <Widget>[
        new UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: const Color(0xFF000000),
            ),
            accountName: new Text('Ajith Rohana'),
            accountEmail: new Text('ajithrohana@gmail.com')),
        new ListTile(
          title: new Text("Home"),
          trailing: new Icon(Icons.arrow_forward_ios),
        ),
        new ListTile(
          title: new Text("Search History"),
          onTap:  () {
            //Use`Navigator` widget to push the second screen to out stack of screens
            Navigator.of(context)
                .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
              return new History();
            }));
          },
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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        //  child: _image == null ? Text('Choose.') : Image.file(_image),

        child: new Column(
            // mainAxisAlignment: MainAxisAlignment.spaceArou,
            children: <Widget>[
              SizedBox(height: 220.0),
              new RaisedButton(
                color: Colors.black,
                child: Text(
                  'Check Plate',
                  style: TextStyle(
                      fontSize:35 ,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                onPressed: getImage,
              ),
              SizedBox(height: 20.0),
              new RaisedButton(
                color: Colors.black,
                child: Text(
                  'Blacklist Plate',
                  style: TextStyle(
                    fontSize:35 ,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                onPressed: getImage,
              )
            ]),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.camera),
      ),
    );
  }
}
