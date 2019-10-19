import 'books.dart';
import 'package:flutter/material.dart';
import 'videos.dart';

class OptionScreen extends StatefulWidget {
  @override
  OptionScreenState createState() {
    return new OptionScreenState();
  }
}

class OptionScreenState extends State<OptionScreen> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              videoSearch(),
              bookSearch(),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}