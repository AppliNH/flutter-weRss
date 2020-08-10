class NewsFeed {
  final int id;
  final String channelName;
  final String rssURL;

  NewsFeed(this.id, this.channelName, this.rssURL);

  Map<String, dynamic> toJson() =>
      {'id': id, 'channelName': channelName, 'rssURL': rssURL};

  NewsFeed.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        channelName = json['channelName'],
        rssURL = json['rssURL'];
}
