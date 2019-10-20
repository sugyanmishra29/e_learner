import 'books.dart';
import 'package:flutter/material.dart';
import 'videos.dart';
import 'package:e_learner/services/authentication.dart';

class OptionScreen extends StatefulWidget {
    OptionScreen({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

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
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.ondemand_video)),
                Tab(icon: Icon(Icons.book)),
              ],
            ),
            title: Text('E_Learner IITG'),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Logout',
                style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: signOut)
            ],
          ),
          body: TabBarView(
            children: [
              videoSearch(),
              bookSearch(),
            ],
          ),
        ),
      ),
    );
  }

    signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

}