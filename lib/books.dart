import 'package:flutter/material.dart';
import 'booksearch.dart';

final List<String> _listViewData = [
  "A List View with many Text - Here's one!",
  "A List View with many Text - Here's another!",
  "A List View with many Text - Here's more!",
  "A List View with many Text - Here's more!",
  "A List View with many Text - Here's more!",
  "A List View with many Text - Here's more!",
];
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
class bookSearch extends StatefulWidget {

  bookSearchState createState(){
    return new bookSearchState();
  }
}

class bookSearchState extends State<bookSearch> {
  Widget build(BuildContext) {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.all(20.0),
            child: Text(
              'Search by category',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(10.0),
            children: _listViewData.reversed.map((data) {
              return ListTile(
                title: Text(data),
                //onTap: Animation(),
                onTap: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new BookSearchScreen()),
                ),
              );
            }).toList(),
          ),
          )
          ]
    );
  }
}

/*TextField(
  onChanged: (text) {
    print("Enter book title: $text");
  },
);

crossAxisCount: 4,
        children: new List<Widget>.generate(16, (index) {
          return new GridTile(
            child: new Card(
              color: Colors.blue.shade200,
              child: new Center(
                child: new Text('tile $index')
 */