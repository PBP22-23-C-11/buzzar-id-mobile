// To parse this JSON data, do
//
//     final lomba = lombaFromJson(jsonString);

import 'dart:convert';

List<Lomba> lombaFromJson(String str) => List<Lomba>.from(json.decode(str).map((x) => Lomba.fromJson(x)));

String lombaToJson(List<Lomba> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Lomba {
    Lomba({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory Lomba.fromJson(Map<String, dynamic> json) => Lomba(
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
        required this.namaLomba,
        required this.keterangan,
        required this.tanggal,
        required this.berjalan,
    });

    String namaLomba;
    String keterangan;
    DateTime tanggal;
    bool berjalan;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        namaLomba: json["namaLomba"],
        keterangan: json["keterangan"],
        tanggal: DateTime.parse(json["tanggal"]),
        berjalan: json["berjalan"],
    );

    Map<String, dynamic> toJson() => {
        "namaLomba": namaLomba,
        "keterangan": keterangan,
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "berjalan": berjalan,
    };
}