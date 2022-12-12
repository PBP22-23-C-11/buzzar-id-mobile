import 'package:http/http.dart' as http;
import 'package:buzzarid_mobile/lomba/model/peserta_lomba.dart';
import 'dart:convert';

Future<List<PesertaLomba>> fetchPeserta(id) async {
  var url = Uri.parse('https://buzzar-id.up.railway.app/lomba/all/peserta/json/' + id);
  var response = await http.get(
    url,
    headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object PesertaLomba
  List<PesertaLomba> listPeserta = [];
  for (var d in data) {
    if (d != null) {
        listPeserta.add(PesertaLomba.fromJson(d));
    }
  }

  return listPeserta;
}