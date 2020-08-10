import 'package:flutter/material.dart';
import 'package:myflutterapp/main.dart';
import 'package:myflutterapp/screens/addNewChannel.dart';
import 'dart:async';
import 'package:animator/animator.dart';

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
          curve: Curves.easeOut,
          duration:Duration(milliseconds: 300),
          height: widget.buttonVisible ? 50 :0,
          width: widget.buttonVisible ? 50 :0,
          child: new FloatingActionButton(
                  onPressed: navigateToNewChannel,
                  
                  elevation: 5,
                  child: 
                    AnimatedContainer(
                      curve: Curves.easeOut,
                      duration:Duration(milliseconds: 300),
                      child: 
                        new Icon(Icons.add, color: myWhite,size: widget.buttonVisible ? 25:0,))
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

void navigateToNewChannel() {
  Navigator.pushNamed(context, NewChannelScreen.routeName);
}


}
