import 'dart:convert';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  Products({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
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
    required this.umkmName,
    required this.productName,
    required this.price,
    required this.description,
    required this.owner,
  });

  String umkmName;
  String productName;
  int price;
  String description;
  int owner;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        umkmName: json["UMKM_name"],
        productName: json["product_name"],
        price: json["price"],
        description: json["description"],
        owner: json["owner"],
      );

  Map<String, dynamic> toJson() => {
        "UMKM_name": umkmName,
        "product_name": productName,
        "price": price,
        "description": description,
        "owner": owner,
      };
}
