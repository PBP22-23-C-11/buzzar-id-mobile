// To parse this JSON data, do
//
//     final obrolan = obrolanFromJson(jsonString);

import 'dart:convert';

List<Obrolan> obrolanFromJson(String str) =>
    List<Obrolan>.from(json.decode(str).map((x) => Obrolan.fromJson(x)));

String obrolanToJson(List<Obrolan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Obrolan {
  Obrolan({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Obrolan.fromJson(Map<String, dynamic> json) => Obrolan(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Fields({
    required this.user,
    required this.username,
    required this.date,
    required this.title,
    required this.toWho,
    required this.message,
  });

  int user;
  String username;
  DateTime date;
  String title;
  String toWho;
  String message;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        username: json["username"],
        date: DateTime.parse(json["date"]),
        title: json["title"],
        toWho: json["toWho"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "username": username,
        "date": date.toIso8601String(),
        "title": title,
        "toWho": toWho,
        "message": message,
      };
}
