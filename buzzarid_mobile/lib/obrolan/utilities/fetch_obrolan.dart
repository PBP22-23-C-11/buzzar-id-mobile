// ignore_for_file: depend_on_referenced_packages
import 'package:buzzarid_mobile/obrolan/model/obrolan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Obrolan>> fetchObrolan() async {
  var url = Uri.parse('https://buzzar-id.up.railway.app/obrolan/json/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  var data = jsonDecode(utf8.decode(response.bodyBytes));

  List<Obrolan> list = [];
  for (var d in data) {
    if (d != null) {
      list.add(Obrolan.fromJson(d));
    }
  }

  return list;
}
