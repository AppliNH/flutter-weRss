import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:myflutterapp/providers/scrollControl.dart';
import 'package:myflutterapp/screens/articleView.dart';
import 'package:myflutterapp/widgets/channel.dart';
import 'package:myflutterapp/classes/NewsFeed.dart';
import 'package:myflutterapp/widgets/channelsList.dart';
import 'package:myflutterapp/widgets/floatingAddButton.dart';
import 'package:myflutterapp/main.dart';
import 'package:myflutterapp/providers/Feeds.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool refreshChannelsTrigger = false;
  bool buttonVisible = true;

  void refreshChannels() {
    Provider.of<ScrollControl>(context, listen:false).controlButtonVisib(true);
    setState(() {
      refreshChannelsTrigger = true;
    });
  }

  void deleteChannel(NewsFeed newsFeed) {
    Provider.of<FeedsProvider>(context, listen: false)
        .deleteNewsFeed(newsFeed.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: myDarkness,
        title: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.rss_feed),
            Text("weRss", style: TextStyle(fontSize: 42)),
          ],
        )),

        actions: <Widget>[
          GestureDetector(
              onTap: refreshChannels,
              child: Container(
                  margin: EdgeInsets.only(right: 10), child: Icon(Icons.sync)))
        ],
      ),
      body: ChannelsList(
          deleteChannel: deleteChannel,
          refreshChannelsTrigger: refreshChannelsTrigger),
      floatingActionButton: FloatingAddButton(isVisible: buttonVisible),
    );
  }
}


