import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final dbRef = FirebaseDatabase.instance.reference();

class BookSearchScreen extends StatefulWidget{

  BookSearchScreenState createState(){
    return new BookSearchScreenState();
  }
}

class BookSearchScreenState extends State<BookSearchScreen> {
  Widget build(BuildContext context) {}

}