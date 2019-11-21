import 'package:flutter/material.dart';
import 'package:myflutterapp/classes/NewsFeed.dart';
import 'package:myflutterapp/main.dart';


class NewChannel extends StatefulWidget {
  @override
  _NewChannel createState() => _NewChannel();
}

class _NewChannel extends State<NewChannel> {

  final emoji = TextEditingController();
  final channelName = TextEditingController();
  final rssURL = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emoji.dispose();
    channelName.dispose();
    rssURL.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {


    void createNewChannel() {
      var fullChannelName = emoji.text + ' ' + channelName.text;
      var id = listOfFeeds.length + 1;
      var newsFeed = NewsFeed(id,fullChannelName,rssURL.text);
      
      listOfFeeds.add(newsFeed);
      Navigator.pop(context);
    }




    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.5,
        backgroundColor: myDarkness,
        title:Text('New Channel')
   
      ),
      body: new Container(
              color: myDarkness,
              padding: EdgeInsets.only(top:20,left:10,right:10),
              //padding: EdgeInsets.only(left:10,right:10),
              child:
                new Column(
                  children: <Widget>[
                    
                    new Container(
                      
                      child:
                        new Row(
                          textBaseline: TextBaseline.ideographic,
                          
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                          new Container(
                          
                            child: 
                            new Flexible(
                              flex: 1,
                              child:
                                new TextField(
                                  controller: emoji,
                                  style: new TextStyle(fontSize: 28,),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintStyle: new TextStyle(color:Colors.white54),
                                    hintText: '👋',
                                  ),
                                ),
                            )

                          ),
                          new Flexible(
                            flex:5,
                            child:
                            new TextField(
                              style: new TextStyle(fontSize: 30,color:myWhite,fontWeight: FontWeight.w700),
                              controller: channelName,
                              decoration: InputDecoration(
                                hintStyle: new TextStyle(color:Colors.white54,),
                                hintText: 'Channel Name',
                              ),
                            ),
                          )
                        ]),
                    ),
                    new Card(
                      color:myDarkness,
                      margin:EdgeInsets.only(top:80),
                      child:
                        new Row(mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
                          new Flexible(child:
                            new TextField(
                              style: new TextStyle(fontSize: 25,color:myWhite),
                              controller: rssURL,
                              maxLines: 4,
                              textAlign: TextAlign.center,
      
                              decoration: InputDecoration(
                                hintStyle: new TextStyle(color:Colors.white54),
                                hintText: 'Paste your RSS uri here',
                              ),
                            ),
                          )
                        ]),
                    ),
                    new Container(
                      margin:EdgeInsets.only(top:20),
                      child:
                        new FlatButton(
                          
                          onPressed: createNewChannel,
                          child: 
                            new Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                              new Icon(Icons.add, color: myWhite,),
                              new Text('Add',style: new TextStyle(color:myWhite,fontWeight: FontWeight.w700),)
                            ],
                          ),
                        )
                    )
                    
                  ],
                
              )
          )
    );
  }

}
