import 'package:flutter/material.dart';
import 'floatingAddButton.dart';
import 'articleView.dart';
import 'channel.dart';
import 'classes/NewsFeed.dart';

void main(){
  runApp(new MyApp());
}

const myWhite = const Color(0xFFFAFAFA);
const myDarkness = const Color(0xFF212121);
const opaq = const Color.fromRGBO(0,0,0,0.2);
const realOwlImage = "https://images2.minutemediacdn.com/image/upload/c_fill,g_auto,h_1248,w_2220/f_auto,q_auto,w_1100/v1555388152/shape/mentalfloss/istock_000023765401_small.jpg";

var techFeed = new NewsFeed(0,"👨‍💻 Tech News", "https://medium.com/feed/better-programming");
var intFeed = new NewsFeed(1,"🌍 International", "https://feeds.bbci.co.uk/news/rss.xml?edition=uk#");

var listOfFeeds = List.of([techFeed,intFeed]);


class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  //Initialiseur de l'app


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title:"My Application",
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      debugShowCheckedModeBanner: false,
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  _HomePage createState() => new _HomePage();
  
}



class _HomePage extends State<HomePage> {

  ScrollController _scrollControl;

  @override
  void initState() {
    _scrollControl = ScrollController();
    _scrollControl.addListener(_scrollListener);
    super.initState();
  }

  bool refreshChannelsTrigger = false;
  bool buttonVisible = true;
  
  void refreshChannels() {
    setState(() {
      refreshChannelsTrigger = true;
    });
  }  

  void deleteChannel(NewsFeed newsFeed) {

    listOfFeeds.removeWhere( (feed) => feed.id == newsFeed.id );
    setState(() { });
  }
  
  _scrollListener() {
    if (_scrollControl.offset >= _scrollControl.position.maxScrollExtent &&
        !_scrollControl.position.outOfRange) {
      setState(() {
        buttonVisible = false;
      });
    }
    else {
      setState(() {
        buttonVisible = true;
      });

    }


  }

  @override 
  Widget build(BuildContext context) {
    //double currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: myWhite,
      appBar: new AppBar(
        elevation: 0.5,
        backgroundColor: myDarkness,
        title:Container(
          margin:EdgeInsets.only(left:20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            new Icon (Icons.rss_feed),
              new Text("weRss",style: new TextStyle(fontSize: 42)),
            ],
          )
        ),
        
        //leading: new Icon (Icons.rss_feed),
        actions: <Widget>[
          GestureDetector(
            onTap:refreshChannels,
            child: Container(margin:EdgeInsets.only(right:10),child: new Icon(Icons.sync))
            )
        ],
      ),
      body: new Container(
        color: myDarkness,
        padding: EdgeInsets.only(top:10,left:5),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            new Expanded(
                //height: MediaQuery.of(context).size.height /1.15,
                child: 
                  ListView.builder(
                    controller:_scrollControl,
                    itemCount: listOfFeeds.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context,index){

                      return Container(
                        key:ValueKey(listOfFeeds[index].id.toString()),
                        child: new ChannelList(listOfFeeds[index],deleteChannel,refreshChannelsTrigger)
                      );
                    },
                  )
              )

        ],
      )
        
      ),
      floatingActionButton: new FloatingAddButton(buttonVisible),

    );
  }

}



