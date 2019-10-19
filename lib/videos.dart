import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final dbRef = FirebaseDatabase.instance.reference();

class videoSearch extends StatefulWidget {

  videoSearchState createState(){
    return new videoSearchState();
  }
}

class videoSearchState extends State<videoSearch> {
  Map <dynamic, dynamic> values;
  String res = "videos";

myFunc() {
var data= dbRef.child("Books");
data.once().then((DataSnapshot snapshot) {
  values = snapshot.value;
  var keys = values.keys;
  setState(() {
    for (var k in keys) res += " " + k.toString();
  });
});
}
  Widget build(BuildContext) {
    return Column(
      children: <Widget>[
        Text(res),
        RaisedButton(
          animationDuration: Duration(milliseconds: 300),
          color: Colors.blue,
          padding: const EdgeInsets.all(15),
          child: Text('Reload',
              style: TextStyle(fontSize: 15, color: Colors.white)),
          onPressed: myFunc,
        ),
      ],
    );
  }

}