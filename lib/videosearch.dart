import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:video_player/video_player.dart';
import 'package:e_learner/uploadVideo.dart';
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
        actions: <Widget>[
          new FlatButton(
            child: new Text('Upload',
            style: new TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new UploadScreen(widget.categorySelected)),
            );
          },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Load"),
              onPressed: myFunc,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Text('${items[index]}'),
                      ChewieListItem(
                        videoPlayerController: VideoPlayerController.network(
                         //"https://firebasestorage.googleapis.com/v0/b/maximal-relic-220420.appspot.com/o/Videos%2FMathematics%2Fbbb-360p.mp4?alt=media&token=82872377-4806-49e7-9585-d15936247003",
                         values['${items[index]}'].toString(),
                        ),
                        looping: true,
                      ),
                    ],
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
