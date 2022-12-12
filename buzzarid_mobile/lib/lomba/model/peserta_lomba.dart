// To parse this JSON data, do
//
//     final pesertaLomba = pesertaLombaFromJson(jsonString);

import 'dart:convert';

List<PesertaLomba> pesertaLombaFromJson(String str) => List<PesertaLomba>.from(json.decode(str).map((x) => PesertaLomba.fromJson(x)));

String pesertaLombaToJson(List<PesertaLomba> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PesertaLomba {
    PesertaLomba({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory PesertaLomba.fromJson(Map<String, dynamic> json) => PesertaLomba(
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
        required this.lomba,
        required this.peserta,
        required this.namaKarya,
        required this.detailKeterangan,
        required this.situsKarya,
        required this.jumlahVote,
    });

    int lomba;
    int peserta;
    String namaKarya;
    String detailKeterangan;
    String situsKarya;
    int jumlahVote;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        lomba: json["lomba"],
        peserta: json["peserta"],
        namaKarya: json["namaKarya"],
        detailKeterangan: json["detailKeterangan"],
        situsKarya: json["situsKarya"],
        jumlahVote: json["jumlahVote"],
    );

    Map<String, dynamic> toJson() => {
        "lomba": lomba,
        "peserta": peserta,
        "namaKarya": namaKarya,
        "detailKeterangan": detailKeterangan,
        "situsKarya": situsKarya,
        "jumlahVote": jumlahVote,
    };
}
