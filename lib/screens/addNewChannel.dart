import 'package:flutter/material.dart';
import 'package:myflutterapp/classes/NewsFeed.dart';
import 'package:myflutterapp/main.dart';
import 'package:myflutterapp/providers/Feeds.dart';
import 'package:provider/provider.dart';

class NewChannelScreen extends StatelessWidget {
  static const routeName = "/-channel";

  final emoji = TextEditingController();
  final channelName = TextEditingController();
  final rssURL = TextEditingController();

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   emoji.dispose();
  //   channelName.dispose();
  //   rssURL.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    void createNewChannel() {
      var fullChannelName = emoji.text + ' ' + channelName.text;
      var id =
          Provider.of<FeedsProvider>(context, listen: false).items.length + 1;
      var newsFeed = NewsFeed(id, fullChannelName, rssURL.text);

      Provider.of<FeedsProvider>(context, listen: false).addNewsFeed(newsFeed);
      Navigator.pop(context);
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: myDarkness,
          title: Text(' Channel'),
          actions: [
            FlatButton(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.save,
                    color: myWhite,
                  ),
                  Text(
                    "Save",
                    style: TextStyle(color: myWhite),
                  ),
                ],
              ),
              onPressed: createNewChannel,
            )
          ],
        ),
        backgroundColor: myDarkness,
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                //padding: EdgeInsets.only(left:10,right:10),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                          textBaseline: TextBaseline.ideographic,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                child: Flexible(
                              flex: 1,
                              child: TextField(
                                controller: emoji,
                                style: TextStyle(
                                  fontSize: 28,
                                ),
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.white54),
                                  hintText: '👋',
                                ),
                              ),
                            )),
                            Flexible(
                              flex: 5,
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 30,
                                    color: myWhite,
                                    fontWeight: FontWeight.w700),
                                controller: channelName,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: Colors.white54,
                                  ),
                                  hintText: 'Channel Name',
                                ),
                              ),
                            )
                          ]),
                    ),
                    Card(
                      color: myDarkness,
                      margin: EdgeInsets.only(top: 80),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: TextField(
                                style: TextStyle(fontSize: 25, color: myWhite),
                                controller: rssURL,
                                maxLines: 4,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.white54),
                                  hintText: 'Paste your RSS uri here',
                                ),
                              ),
                            )
                          ]),
                    ),
                  ],
                ))));
  }
}
