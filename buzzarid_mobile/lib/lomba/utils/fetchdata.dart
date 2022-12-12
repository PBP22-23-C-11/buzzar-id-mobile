import 'package:http/http.dart' as http;
import 'package:buzzarid_mobile/lomba/model/lomba_data.dart';
import 'dart:convert';

Future<List<Lomba>> fetchLomba() async {
  var url = Uri.parse('https://buzzar-id.up.railway.app/lomba/all/data/json');
  var response = await http.get(
    url,
    headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object Lomba
  List<Lomba> listLomba = [];
  for (var d in data) {
    if (d != null) {
        listLomba.add(Lomba.fromJson(d));
    }
  }

  return listLomba;
}