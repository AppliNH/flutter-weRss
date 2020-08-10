import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myflutterapp/classes/NewsFeed.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedsProvider with ChangeNotifier {
  List<NewsFeed> _items = [];
  //  NewsFeed(
  //       0, "👨‍💻 Tech News", "https://medium.com/feed/better-programming"),
  //   NewsFeed(1, "🌍 International",
  //       "https://feeds.bbci.co.uk/news/rss.xml?edition=uk#")
  List<NewsFeed> get items {
    return _items;
  }

  deleteNewsFeed(int id) async {
    _items.removeWhere((element) => element.id == id);
    await _writeToStorage();
    notifyListeners();
  }

  addNewsFeed(NewsFeed newsFeed) async {
    _items.add(newsFeed);
    await _writeToStorage();
    notifyListeners();
  }

  _writeToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> newsFeed;
    newsFeed = _items.map((e) => json.encode(e.toJson())).toList();

    await prefs.setStringList('newsFeed', newsFeed);
  }

  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('newsFeed')) {
      return;
    }
    List<NewsFeed> newsFeed;
    var newsFeedStr = prefs.get('newsFeed') as List<dynamic>;

    newsFeed = newsFeedStr
        .map((e) => NewsFeed.fromJson(json.decode(e) as Map<String, dynamic>))
        .toList();
    _items = newsFeed;
    return;
  }
}
