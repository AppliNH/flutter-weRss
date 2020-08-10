import 'package:flutter/material.dart';
import 'package:myflutterapp/providers/Feeds.dart';
import 'package:myflutterapp/providers/scrollControl.dart';
import 'package:myflutterapp/screens/addNewChannel.dart';
import 'package:myflutterapp/screens/homeScreen.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(new MyApp());
}

const myWhite = const Color(0xFFFAFAFA);
const myDarkness = const Color(0xFF212121);
const opaq = const Color.fromRGBO(0, 0, 0, 0.5);
const realOwlImage =
    "https://images2.minutemediacdn.com/image/upload/c_fill,g_auto,h_1248,w_2220/f_auto,q_auto,w_1100/v1555388152/shape/mentalfloss/istock_000023765401_small.jpg";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FeedsProvider>(
          create: (ctx) => FeedsProvider()
        ),
        ChangeNotifierProvider<ScrollControl>(
          create: (ctx) => ScrollControl()
        ),
      ],
      child: MaterialApp(
            title: "My Application",
            theme: new ThemeData(primarySwatch: Colors.blueGrey),
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
            routes: {
              HomeScreen.routeName: (ctx) => HomeScreen(),
              NewChannelScreen.routeName: (ctx) => NewChannelScreen()
              }
          )
    );
    
  }
}
