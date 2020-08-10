import 'package:myflutterapp/main.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp/providers/Feeds.dart';
import 'package:myflutterapp/providers/scrollControl.dart';
import 'package:myflutterapp/widgets/channel.dart';
import 'package:provider/provider.dart';

class ChannelsList extends StatefulWidget {
  const ChannelsList({
    Key key,
    @required this.refreshChannelsTrigger,
    @required this.deleteChannel,
  }) : super(key: key);

  final bool refreshChannelsTrigger;
  final Function deleteChannel;

  @override
  _ChannelsListState createState() => _ChannelsListState();
}

class _ChannelsListState extends State<ChannelsList> {
  ScrollController _scrollControl;
  @override
  void initState() {
    _scrollControl = ScrollController();
    _scrollListener();
    super.initState();
  }

  _scrollListener() {
    _scrollControl.addListener(() {
      if (_scrollControl.offset >= _scrollControl.position.maxScrollExtent &&
          !_scrollControl.position.outOfRange) {
        Provider.of<ScrollControl>(context, listen: false)
            .controlButtonVisib(false);
      } else {
        Provider.of<ScrollControl>(context, listen: false)
            .controlButtonVisib(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: myDarkness,
        padding: EdgeInsets.only(top: 10, left: 5),
        child: Consumer<FeedsProvider>(
            builder: (ctx, listOfFeeds, ch) => FutureBuilder(
                future: listOfFeeds.loadFromStorage(),
                builder: (ctx, result) => result.connectionState ==
                        ConnectionState.waiting
                    ? CircularProgressIndicator()
                    : listOfFeeds.items.length == 0
                        ? Center(
                            child: Text(
                                "Add some NewsFeed RSS using the '+' button !",
                                style: TextStyle(color: myWhite)))
                        : ListView.builder(
                            controller: _scrollControl,
                            itemCount: listOfFeeds.items.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Container(
                                  key: ValueKey(
                                      listOfFeeds.items[index].id.toString()),
                                  child: Channel(
                                      listOfFeeds.items[index],
                                      widget.deleteChannel,
                                      widget.refreshChannelsTrigger));
                            },
                          ))));
  }
}