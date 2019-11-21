import 'package:flutter/material.dart';
import 'dart:async';
import 'newChannel.dart';
import 'package:animator/animator.dart';

const myWhite = const Color(0xFFFAFAFA);

class FloatingAddButton extends StatefulWidget {
  bool buttonVisible;

  FloatingAddButton(bool buttonVisible) {
    this.buttonVisible = buttonVisible;
  }
  @override
  _FloatingAddButton createState() => new _FloatingAddButton();
}

class _FloatingAddButton extends State<FloatingAddButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
          curve: Curves.bounceInOut,
          duration:Duration(milliseconds: 500),
          height: widget.buttonVisible ? 50 :0,
          width: widget.buttonVisible ? 50 :0,
          child: new FloatingActionButton(
                  onPressed: navigateToNewChannel,
                  
                  elevation: 5,
                  child: new Icon(Icons.add, color: myWhite,)
                )
              
    );
  }
  void snack(text) {
    SnackBar snacki = new SnackBar(
      content: Text(text),
      duration: new Duration(seconds :1),
    );
    Scaffold.of(context).showSnackBar(snacki);
  }

  Future<Null> dialog() async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder:(BuildContext context) {
        return new SimpleDialog(
          title: Text("Add an Rss feed"),
          elevation: 2.0,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.all(10),
              child:
              new Column(mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[

                new Row(mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
                    new Icon(Icons.title, color:Colors.black),
                    new Flexible(child:
                      new TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter a name for your channel',
                        ),
                      ),
                    )
                  ]),

                  new Row(mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
                    new Icon(Icons.link, color:Colors.black),
                    new Flexible(child:
                      new TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Past your RSS uri here',
                        ),
                      ),
                    )
                  ]),
                new Container(
                  margin: EdgeInsets.only(top:15),
                  child:
                  new FlatButton(
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      Navigator.pop(context);
                      snack("adding...");
                    },
                    
                    child: Text('Add'),)
                )

              ])
            )
          ]
          

        );
      }
    );
  }

void navigateToNewChannel() {
  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
      return new NewChannel();
    }) );
}


}
