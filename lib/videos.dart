import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final dbRef = FirebaseDatabase.instance.reference();

class videoSearch extends StatefulWidget {

  videoSearchState createState(){
    return new videoSearchState();
  }
}

class videoSearchState extends State<videoSearch> {

String res = "videos";

myFunc() {
var data= dbRef.child("Books");
res += "videos";
data.once().then((DataSnapshot snapshot) {
  var values = snapshot.value;
  print (values["Mathematics"]);
  var keys = [];
  for (var k in values) keys.add(k);
  setState(() {
    res += "videos";
    for (var k in keys) res += k;
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
          onPressed: () { myFunc();
          },
        ),
      ],
    );
  }

}