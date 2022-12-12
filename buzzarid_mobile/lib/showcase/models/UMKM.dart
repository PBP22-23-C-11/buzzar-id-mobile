// To parse this JSON data, do
//
//     final umkm = umkmFromJson(jsonString);

import 'dart:convert';

List<UMKM> umkmFromJson(String str) => List<UMKM>.from(json.decode(str).map((x) => UMKM.fromJson(x)));

String umkmToJson(List<UMKM> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UMKM {
  UMKM({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory UMKM.fromJson(Map<String, dynamic> json) => UMKM(
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
    required this.owner,
    required this.shopName,
    required this.category,
    required this.description,
    required this.umkmUrl,
    required this.number,
    required this.image,
    required this.ratingTotal,
    required this.ratingCount,
  });

  int owner;
  String shopName;
  String category;
  String description;
  String umkmUrl;
  String number;
  String image;
  int ratingTotal;
  int ratingCount;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    owner: json["owner"],
    shopName: json["shop_name"],
    category: json["category"],
    description: json["description"],
    umkmUrl: json["umkm_url"],
    number: json["number"],
    image: json["image"],
    ratingTotal: json["rating_total"],
    ratingCount: json["rating_count"],
  );

  Map<String, dynamic> toJson() => {
    "owner": owner,
    "shop_name": shopName,
    "category": category,
    "description": description,
    "umkm_url": umkmUrl,
    "number": number,
    "image": image,
    "rating_total": ratingTotal,
    "rating_count": ratingCount,
  };
}
