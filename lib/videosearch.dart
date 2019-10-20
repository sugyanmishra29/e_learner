import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:video_player/video_player.dart';

import 'package:e_learner/chewie_list_item.dart';

final dbRef = FirebaseDatabase.instance.reference();

class VideoSearchScreen extends StatefulWidget {
  final String categorySelected;
  VideoSearchScreen({Key key, this.categorySelected}) : super(key: key);

  VideoSearchScreenState createState() {
    return new VideoSearchScreenState();
  }
}

class VideoSearchScreenState extends State<VideoSearchScreen> {
  TextEditingController editingController = TextEditingController();

  var items = List<String>();

  Map<dynamic, dynamic> values;
  
  @override
  void initState() {
//    items.addAll(duplicateItems);
    super.initState();
  }

  myFunc() {
    var data = dbRef.child("Videos").child(widget.categorySelected.toString());
    print("Data is " + data.toString());
    data.once().then((DataSnapshot snapshot) {
      values = snapshot.value;
    });
    setState(() {
      items.clear();
      for (var k in values.keys)   items.add(k.toString());
    });
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
//    dummySearchList.addAll(items);
    for (var k in values.keys) dummySearchList.add(k.toString());
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        for (var k in values.keys)   items.add(k.toString());
      });
    }
  }

  void _settingModalBottomSheet(item) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 240,
            child: new Column(
              children: <Widget>[
                Image.asset(
                  'images/IIT_Guwahati_Logo.png',
                  height: 130,
                  width: 130,
                ),
                Text(item),
                Text("Year: " + (values[item])['Year'].toString()),
                IconButton(
                  icon: Icon(Icons.file_download),
                  tooltip: 'Download PDF.',
                  onPressed: () {
                    print('Download button clicked');
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Search for Video"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            RaisedButton(
              child: Text("See suggestions"),
              onPressed: myFunc,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Text('${items[index]}',
                      style: TextStyle(color: Colors.black, fontSize: 20,fontStyle: FontStyle.italic),),
                      //onTap: (){ _settingModalBottomSheet('${items[index]}');
                      ChewieListItem(
                        videoPlayerController: VideoPlayerController.network(
                         values['${items[index]}'].toString(),
                        ),
                        looping: true,
                      ),
                    ],
                  );
                }
              ),
              // child: ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: items.length,
              //   itemBuilder: (context, index) {
              //     return ListTile(
              //       leading: Image.asset(
              //         'images/IIT_Guwahati_Logo.png',
              //         height: 40,
              //         width: 40,
              //       ),
              //       title: Text('${items[index]}'),
              //       subtitle: Text("Something"),
              //       onTap: (){ _settingModalBottomSheet('${items[index]}');},

              //     );
              //   },
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
