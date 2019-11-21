import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
  @override
  Widget build(BuildContext context) {
    
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
      body: new Center(
        
        child: WebView(
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
        )
      )
    );
  }
}