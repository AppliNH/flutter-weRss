import 'package:flutter/material.dart';
import 'package:myflutterapp/classes/NewsFeed.dart';
import 'articleView.dart';
import 'classes/Article.dart';
import 'articleChannelCard.dart';
import 'package:myflutterapp/main.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

typedef DeleteCallback = void Function(NewsFeed newsFeed);
class ChannelList extends StatefulWidget {

  NewsFeed newsFeed;
  DeleteCallback deleteChannel;
  bool refreshChannelTrigger;

  ChannelList(NewsFeed newsFeed,DeleteCallback deleteChannel, bool refreshChannelTrigger) {
    this.newsFeed = newsFeed;
    this.deleteChannel = deleteChannel;
    this. refreshChannelTrigger = refreshChannelTrigger;
  }

  @override
  _ChannelListState createState() => _ChannelListState();
}

class _ChannelListState extends State<ChannelList> {

  final client = http.Client();

  final GlobalKey _menuKey = new GlobalKey();

  var articles = new List<Article>();

  rssStream(){
    client.get(widget.newsFeed.rssURL).then((response) {
      return response.body;
    }).then((bodyString) {
      var channel = new RssFeed.parse(bodyString);
      
      if (articles.length <10) {
        for (var i = 0; i < 10; i++) {
          setState(() {
            var newArticle;
            var content = channel.items[i].content;

            if(content !=null)
            {
              if(channel.items[i].content.images != null) {
                newArticle = new Article(channel.items[i].title, channel.items[i].content.images.first, channel.items[i].link);
              }
              else {
                newArticle = new Article(channel.items[i].title, realOwlImage, channel.items[i].link);
                
              }
            }

            else {
              newArticle = new Article(channel.items[i].title, realOwlImage, channel.items[i].link);
            }
            
            articles.add(newArticle);
          });
        }
      }

      
    });
}


  @override
  Widget build(BuildContext context) {
    rssStream();

    if (widget.refreshChannelTrigger) {
      articles.clear();
      rssStream();
      widget.refreshChannelTrigger = false;
    }

    void goToArticle(Article article) {
      print(article.sourceURL);
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return new ArticleScaffold(article.sourceURL);
      }));
    }

    return new Container(
        height: MediaQuery.of(context).size.height / 3,
        child: new Column(
          children: <Widget>[
            new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin:EdgeInsets.only(left:10),
                    child: new Text(widget.newsFeed.channelName,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          color: myWhite,
                        )),
                  ),
                  new PopupMenuButton(
                    icon: Icon(Icons.more_horiz, color:myWhite),
                    key:_menuKey,
                    
                    itemBuilder: (_) => <PopupMenuItem<String>>[
                          new PopupMenuItem<String>(
                              value: "delete",
                              child: 
                                  Row(
                                      children: <Widget>[
                                        Icon(Icons.delete,color:Colors.redAccent),
                                        Text('Delete'),
                                      ],
                                  ),
                                
                              ),
                        ],
                    onSelected: (String value) {
                      switch (value) {
                        case 'delete':
                          widget.deleteChannel(widget.newsFeed);
                          break;
                        default:
                      }
                    }
                  )
                ]),

            new Container(
                height: MediaQuery.of(context).size.height / 3.8,
                child: ListView.builder(
                  itemCount: articles.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                        key: Key(articles[index].sourceURL),
                        child: GestureDetector(
                          onTap:() {goToArticle(articles[index]);},
                          child: new ArticleChannelCard(article: articles[index]),
                        ));
                  },
                )
            )
          ],
        ));

    
  }
}


