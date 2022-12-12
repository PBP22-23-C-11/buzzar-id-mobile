import 'package:http/http.dart' as http;
import 'dart:convert';

void updateLomba(String id) async {
  var url = Uri.parse('https://buzzar-id.up.railway.app/lomba/all/selesai/' + id);
  var response = await http.get(
    url,
    headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
    },
  );
}