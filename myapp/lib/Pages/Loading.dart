import 'dart:async';
import 'package:flutter/material.dart';
import './UploadImage.dart';

class Loading extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<Loading> {

  @override
  void initState(){
    super.initState();
    Timer(
        Duration(seconds:5),
            (){navigateToHome(context);}
    );
  }

  Future navigateToHome(context) async{
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context)=>UploadImage()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.indigo),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50.0,
                          child: Icon(
                            Icons.home,
                            color: Colors.blueGrey,
                            size: 70.0,
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 18.0),
                      ),
                      Text("Number Plate Detector",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.normal))
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Center(
                      child: Text(
                        "Instant Results \n At Your Finger Tips \n STRICTLY FOR THE USE OF POLICE ONLY",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
