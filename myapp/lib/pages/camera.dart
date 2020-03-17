import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  void _showSnakBarMsg(String msg) {
    _scaffoldstate.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Image Picker',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Image Picker'),
        ),
        body: new Center(
          child: _image == null
              ? new Text('No image selected')
              : new Image.file(_image),
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
