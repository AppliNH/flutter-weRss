import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myflutterapp/main.dart';
import 'package:myflutterapp/providers/scrollControl.dart';
import 'package:myflutterapp/screens/addNewChannel.dart';
import 'dart:async';
import 'package:animator/animator.dart';
import 'package:provider/provider.dart';

class FloatingAddButton extends StatefulWidget {
  
  bool isVisible = true;

  FloatingAddButton({ bool isVisible});
  @override
  _FloatingAddButton createState() => new _FloatingAddButton();
}

class _FloatingAddButton extends State<FloatingAddButton> {
  @override
  void initState() {
    //widget.scrollControl.addListener(_scrollListener);
    //_scrollListener();
    super.initState();
  }

  void snack(text) {
    SnackBar snacki = new SnackBar(
      content: Text(text),
      duration: new Duration(seconds: 1),
    );
    Scaffold.of(context).showSnackBar(snacki);
  }

  void navigateToNewChannel() {
    Navigator.pushNamed(context, NewChannelScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScrollControl>(
      builder: (ctx, data, ch) =>
       AnimatedContainer(
          curve: Curves.easeOut,
          duration: Duration(milliseconds: 300),
          height: data.isFABvisible ? 50 : 0,
          width: data.isFABvisible ? 50 : 0,
          child: new FloatingActionButton(
              onPressed: navigateToNewChannel,
              elevation: 5,
              child: AnimatedContainer(
                  curve: Curves.easeOut,
                  duration: Duration(milliseconds: 300),
                  child: new Icon(
                    Icons.add,
                    color: myWhite,
                    size: data.isFABvisible ? 25 : 0,
                  ))))
    );
  }

  
}
