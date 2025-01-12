import 'package:info_sphere/utils/imports.dart';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));
String articleToJson(Article data) => json.encode(data.toJson());

List<Article> articleListFromJson(List list) =>
    List<Article>.from(list.map((x) => Article.fromJson(x)));
String articleListToJson(List<Article> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Article {
  Source? source;
  dynamic author;
  String? title;
  String? description;
  String? url;
  dynamic urlToImage;
  DateTime? publishedAt;
  String? content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: json["publishedAt"] == null
            ? null
            : DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source?.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt?.toIso8601String(),
        "content": content,
      };
}
