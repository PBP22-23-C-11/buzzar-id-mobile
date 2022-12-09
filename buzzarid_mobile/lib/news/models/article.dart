import 'dart:convert';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));
String articleToJson(Article data) => json.encode(data.toJson());

class Article {
  Article({
    required this.id,
    required this.author,
    required this.title,
    required this.body,
    required this.image,
    required this.createdAt,
    required this.likes,
  });

  int id;
  Author author;
  String title;
  String body;
  String image;
  String createdAt;
  int likes;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json["id"],
        author: Author.fromJson(json["author"]),
        title: json["title"],
        body: json["body"],
        image: json["image"],
        createdAt: json["created_at"],
        likes: json["likes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author.toJson(),
        "title": title,
        "body": body,
        "image": image,
        "created_at": createdAt,
        "likes": likes,
      };
}

class Author {
  Author({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
