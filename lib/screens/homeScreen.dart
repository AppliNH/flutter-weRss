import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:myflutterapp/screens/articleView.dart';
import 'package:myflutterapp/widgets/channel.dart';
import 'package:myflutterapp/classes/NewsFeed.dart';
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
  ScrollController _scrollControl;

  bool refreshChannelsTrigger = false;
  bool buttonVisible = true;

  @override
  void initState() {
    _scrollControl = ScrollController();
    _scrollControl.addListener(_scrollListener);
    super.initState();
  }

  void refreshChannels() {
    setState(() {
      refreshChannelsTrigger = true;
    });
  }

  void deleteChannel(NewsFeed newsFeed) {
    Provider.of<FeedsProvider>(context, listen: false)
        .deleteNewsFeed(newsFeed.id);
    setState(() {
      buttonVisible = true;
    });
  }

  _scrollListener() {
    if (_scrollControl.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        buttonVisible = false;
      });
      if (_scrollControl.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          buttonVisible = true;
        });
      }
    }
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

        //leading:  Icon (Icons.rss_feed),
        actions: <Widget>[
          GestureDetector(
              onTap: refreshChannels,
              child: Container(
                  margin: EdgeInsets.only(right: 10), child: Icon(Icons.sync)))
        ],
      ),
      body: Container(
          color: myDarkness,
          padding: EdgeInsets.only(top: 10, left: 5),
          child: 
              Consumer<FeedsProvider>(
                  builder: (ctx, listOfFeeds, ch) => 
                  FutureBuilder(
                    future: listOfFeeds.loadFromStorage(),
                    builder: (ctx, result) =>
                    result.connectionState == ConnectionState.waiting ?
                      CircularProgressIndicator()
                    :
                    listOfFeeds.items.length == 0 ?
                      Center(child: Text("Add some NewsFeed RSS using the '+' button !", style: TextStyle(color: myWhite)))
                    :
                        ListView.builder(
                            //controller: _scrollControl,
                            itemCount: listOfFeeds.items.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Container(
                                  key: ValueKey(listOfFeeds.items[index].id.toString()),
                                  child: ChannelList(listOfFeeds.items[index],
                                      deleteChannel, refreshChannelsTrigger));
                            },
                          )
                      

                  )
                    
              )
       
          ),
      floatingActionButton: FloatingAddButton(true),
    );
  }
}
