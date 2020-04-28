import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

class UploadImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MyAppState();
}

class _MyAppState extends State<UploadImage> {
  File _image;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  void _uploadFile(filePath) async {
    // Get base file name
    String fileName = basename(filePath.path);
    print("File base name: $fileName");

    try {
      FormData formData = FormData.fromMap({
  "file":
      await MultipartFile.fromFile(filePath, filename:fileName),
 });
      Response response =
          await Dio().post("http://192.168.8.100/saveFile.php", data: formData);
      print("File upload response: $response");

      // Show the incoming message in snakbar
      //showSnakBarMsg(response.data['message']);
    } catch (e) {
      print("Exception Caught: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Image Picker',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Image Picker'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              UserAccountsDrawerHeader(
                  accountName: Text('Shehana Iqbal'),
                  accountEmail: Text('iqbalshehana@gmail.com')),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('Recent History'),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: getImage,
          tooltip: 'Pick Image',
          child: new Icon(Icons.camera),
        ),
      ),
    );
  }
}
