import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './home.dart';
import 'dart:async';

void main() => runApp(new Login());

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new Camera()
      },
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';

  Future<List> _login() async {
    print(user.text);
    print(pass.text);
    final response =
        await http.post("http://192.168.8.101/avlogin/login.php", body: {
      "username": user.text,
      "password": pass.text,
    });
    
    print(response.body);

    var datauser = json.decode(response.body);
  
  

    if (datauser.length == 0) {
      setState(() {
        msg = "Login Fail";
      });
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.amber,
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text('Vehicle Numberplate',
                        style: TextStyle(
                            fontSize: 35.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30.0, 155.0, 0.0, 0.0),
                    child: Text('Detection System',
                        style: TextStyle(
                            fontSize: 35.0, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: user,
                      decoration: InputDecoration(
                          labelText: 'USERNAME',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: pass,
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                      obscureText: true,
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                    ),
                    SizedBox(height: 40.0),
                    
                    
                    // Container(
                    //   height: 40.0,
                    //   child: Material(
                    //     borderRadius: BorderRadius.circular(20.0),
                    //     shadowColor: Colors.black,
                    //     color: Colors.black,
                    //     elevation: 7.0,
                    //     child: GestureDetector(
                    //       onTap: () {
                    //         _login();
                    //       },
                    //       child: Center(
                    //         child: Text(
                    //           'LOGIN',
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontWeight: FontWeight.bold,
                    //               fontFamily: 'Montserrat'),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 20.0),
                  ],
                )),
            SizedBox(height: 15.0),

            RaisedButton(
              child: Text("Login"),
              onPressed: () {
                _login();
              },
            ),
            Text(
              msg,
              style: TextStyle(fontSize: 20.0, color: Colors.red),
            )
          ],
        ));
  }
}
