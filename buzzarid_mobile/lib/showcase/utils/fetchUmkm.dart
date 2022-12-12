import 'dart:convert';
import 'package:buzzarid_mobile/showcase/models/umkm.dart';
import 'package:http/http.dart' as http;

Future<List<UMKM>> fetchUMKM() async {
  var url = Uri.parse("https://buzzar-id.up.railway.app/showcase/json/");
  var response = await http.get(
    url,
    headers: {
      "Content-Type": "applicaation/json",
    },
  );

  var data = jsonDecode(utf8.decode(response.bodyBytes));

  List<UMKM> listUMKM = [];
  for (var d in data) {
    if (d != null) {
      listUMKM.add(UMKM.fromJson(d));
    }
  }

  return listUMKM;
}