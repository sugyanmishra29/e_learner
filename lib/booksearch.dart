import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final dbRef = FirebaseDatabase.instance.reference();

class BookSearchScreen extends StatefulWidget{

  BookSearchScreenState createState(){
    return new BookSearchScreenState();
  }
}

class BookSearchScreenState extends State<BookSearchScreen>{

  Map <dynamic, dynamic> values;
  List<String> keys=["M","N"];

  func() {
    var data = dbRef.child("Books").child(mydata);
    data.once().then((DataSnapshot snapshot) {
      values = snapshot.value;

    setState(() {
      keys = values.keys;

    });

    Widget build(BuildContext){
      return Column{
        children:<Widget>[
          Padding(padding: EdgeInsets.all(20.0)
        ]
      }



  }
  }}



}