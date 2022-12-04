import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.username,
    required this.name,
    required this.type,
    this.isGuest = false,
  });

  String username;
  String name;
  String type;
  bool isGuest;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "type": type,
      };
}
