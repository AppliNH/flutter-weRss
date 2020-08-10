
import 'package:flutter/material.dart';
import 'package:myflutterapp/classes/Article.dart';
import 'package:myflutterapp/main.dart';

class ArticleChannelCard extends StatelessWidget {

  const ArticleChannelCard({
    Key key,
    @required this.article
  }) : super(key: key);

 final Article article;


  @override
  Widget build(BuildContext context) {
    return new Card(
      child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(4.0),
            color: myDarkness,
            image: DecorationImage(
              image: NetworkImage(article.photo),
              fit: BoxFit.cover
              
            )
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: 
                Container(
                  margin:EdgeInsets.only(bottom: 10),
                  color: opaq,
                  child: new Text(
                    article.title,
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: myWhite,fontWeight: FontWeight.w700,fontSize: 16,),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  
                  ),
                ),
              ),
              
              ],
          )),
    );
  }
}