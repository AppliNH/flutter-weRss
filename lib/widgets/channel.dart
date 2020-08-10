import 'package:flutter/material.dart';
import 'package:myflutterapp/classes/NewsFeed.dart';
import '../screens/articleView.dart';
import '../classes/Article.dart';
import 'articleChannelCard.dart';
import 'package:myflutterapp/main.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

typedef DeleteCallback = void Function(NewsFeed newsFeed);

class Channel extends StatelessWidget {
  NewsFeed newsFeed;
  DeleteCallback deleteChannel;
  bool refreshChannelTrigger;

  Channel(NewsFeed newsFeed, DeleteCallback deleteChannel,
      bool refreshChannelTrigger) {
    this.newsFeed = newsFeed;
    this.deleteChannel = deleteChannel;
    this.refreshChannelTrigger = refreshChannelTrigger;
  }

  final client = http.Client();

  final GlobalKey _menuKey = new GlobalKey();

  Future<List<Article>> rssStream() async {
    var bodyString = await client.get(newsFeed.rssURL);
    var channel = new RssFeed.parse(bodyString.body);
    var articles = new List<Article>();

    if (articles.length < 10) {
      for (var i = 0; i < 10; i++) {
        var newArticle;
        var content = channel.items[i].content;
        var desc = channel.items[i].description;
        var enclosure = channel.items[i].enclosure;


        if (channel.items[i].description != null && desc.contains("<img")) {
          var articleImage = getImgFromDesc(channel.items[i].description);
          newArticle = new Article(
              channel.items[i].title, articleImage, channel.items[i].link);
        } else if (content != null) {
          if (channel.items[i].content.images != null) {
            newArticle = new Article(channel.items[i].title,
                channel.items[i].content.images.first, channel.items[i].link);
          } else {
            newArticle = new Article(
                channel.items[i].title, realOwlImage, channel.items[i].link);
          }
        } else if (enclosure != null) {
          newArticle = new Article(channel.items[i].title,
              channel.items[i].enclosure.url, channel.items[i].link);
        } else if (channel.image.url != null) {
          newArticle = new Article(
              channel.items[i].title, channel.image.url, channel.items[i].link);
        }

        articles.add(newArticle);
      }
    }
    
    return articles;
  }

  getImgFromDesc(String desc) {
    var descri = desc.replaceAll('"', '\\"');
    RegExp exp = new RegExp(r'<img src=\\"([\w\W]+?)\\"');
    var matches = exp.allMatches(descri);
    var match = matches.elementAt(0);
    return ("${match.group(1)}");
  }

  @override
  Widget build(BuildContext context) {

    void goToArticle(Article article) {
      print(article.sourceURL);
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return new ArticleWebView(article.sourceURL);
      }));
    }

    return FutureBuilder(
        future: rssStream(),
        builder: (ctx, articles) =>
        articles.connectionState == ConnectionState.waiting ? 
        CircularProgressIndicator()
        :
        Container(
                child: new Column(
              children: <Widget>[
                new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: new Text(newsFeed.channelName,
                            textAlign: TextAlign.left,
                            style: new TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 28,
                              color: myWhite,
                            )),
                      ),
                      new PopupMenuButton(
                          icon: Icon(Icons.more_horiz, color: myWhite),
                          key: _menuKey,
                          itemBuilder: (_) => <PopupMenuItem<String>>[
                                new PopupMenuItem<String>(
                                  value: "delete",
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.delete,
                                          color: Colors.redAccent),
                                      Text('Delete'),
                                    ],
                                  ),
                                ),
                              ],
                          onSelected: (String value) {
                            switch (value) {
                              case 'delete':
                                deleteChannel(newsFeed);
                                break;
                              default:
                            }
                          })
                    ]),
                
                new Container(
                    height: MediaQuery.of(context).size.height / 3.8,
                    child: ListView.builder(
                      itemCount: articles.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                            key: Key(articles.data[index].sourceURL),
                            child: GestureDetector(
                              onTap: () {
                                goToArticle(articles.data[index]);
                              },
                              child: new ArticleChannelCard(
                                  article: articles.data[index]),
                            ));
                      },
                    ))
              ],
            )));
  }
}
