import 'package:flutter/material.dart';

class History extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent History'),
      ),
      body: ListView.builder(itemBuilder: (context,index){
        return Card(
          child:Padding(
            padding: const EdgeInsets.only(top: 30.0,left: 13.0,right: 22.0,bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Title'),
              Text('content is here'),
            ],
          ),
          ),
        );
      }),
    );
  }
}