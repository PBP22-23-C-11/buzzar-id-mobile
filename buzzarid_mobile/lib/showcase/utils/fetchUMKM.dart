import 'dart:convert';
import 'package:buzzarid_mobile/showcase/models/UMKM.dart';
import 'package:http/http.dart' as http;

Future<List<UMKM>> fetchUMKM(String category) async {
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
      UMKM temp = UMKM.fromJson(d);
      if (category == "All" || category == temp.fields.category) {
        listUMKM.add(temp);
      }
    }
  }

  return listUMKM;
}

