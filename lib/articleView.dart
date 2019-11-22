import 'package:flutter/material.dart';
import 'package:myflutterapp/main.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import  'package:flutter_spinkit/flutter_spinkit.dart';

const myDarkness = const Color(0xFF212121);

class ArticleScaffold extends StatefulWidget {

  String sourceUrl;

  ArticleScaffold(String sourceUrl) {
    this.sourceUrl = sourceUrl;
  }

  @override
  _ArticleScaffoldState createState() => _ArticleScaffoldState();
}

class _ArticleScaffoldState extends State<ArticleScaffold> {
  bool isLoading = true;
  num _stackToView = 1;
  @override
  Widget build(BuildContext context) {

      void _handleLoad(String value) {
        setState(() {
          _stackToView = 0;
        });
      }
    
    void _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }}


    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.5,
        backgroundColor: myDarkness,
 
      ),
      backgroundColor: myDarkness,
      body: new Center(
        
        child: IndexedStack(
          index: _stackToView,
          children: <Widget>[
            WebView(
              onPageFinished: _handleLoad,
              initialUrl: widget.sourceUrl,
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (NavigationRequest request)
                {
                  if (!request.url.startsWith('https://'))
                  {
                    print('blocking navigation to $request}');
                    _launchURL(request.url);
                    return NavigationDecision.prevent;
                  }

                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SpinKitWave(color: myWhite, type: SpinKitWaveType.start),

                  Container(
                    margin: EdgeInsets.only(top:10),
                    child: 
                      Text("Loading...",style:new TextStyle(color: myWhite,fontWeight: FontWeight.w700)))
                      
                ],
              )),
          ],
        )
      )
    );
  }
}