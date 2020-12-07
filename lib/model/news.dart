import 'dart:convert';

News newsItemFromJson(String str) => News.fromJson(json.decode(str));

String newsItemToJson(News data) => json.encode(data.toJson());

class News {
  List<NewsItem> news;

  News({this.news});

  factory News.fromJson(Map<String, dynamic> json) => News(
      news: List<NewsItem>.from(json["articles"].map((x) => NewsItem.fromJson(x)))
  );
  Map<String, dynamic> toJson() => {
    "news": List<dynamic>.from(news.map((x) => x.toJson()))
  };
}

class NewsItem {
  String source;
  int totalResult;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  NewsItem({this.source, this.totalResult, this.author, this.title, this.description,
    this.url, this.urlToImage, this.publishedAt, this.content});

  factory NewsItem.fromJson(Map<String, dynamic> json) => NewsItem(
      source: json["source"]["name"],
      totalResult: json["totalResult"],
      author: json["author"],
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      publishedAt: json["publishedAt"],
      content: json["content"]
  );

  Map<String, dynamic> toJson() => {
    "source": source,
    "totalResult": totalResult,
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt,
    "content": content
  };
}