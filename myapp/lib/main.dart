import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MyAppState();
    
  }
  
class _MyAppState extends State<MyApp> {
  File _image;
  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image= image;
      
    });


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
