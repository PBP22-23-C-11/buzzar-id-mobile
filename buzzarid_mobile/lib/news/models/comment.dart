import 'dart:convert';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));
String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  Comment({
    required this.user,
    required this.id,
    required this.body,
    required this.createdAt,
  });

  CommentUser user;
  int id;
  String body;
  DateTime createdAt;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        user: CommentUser.fromJson(json["user"]),
        id: json["id"],
        body: json["body"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "id": id,
        "body": body,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}

class CommentUser {
  CommentUser({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory CommentUser.fromJson(Map<String, dynamic> json) => CommentUser(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
