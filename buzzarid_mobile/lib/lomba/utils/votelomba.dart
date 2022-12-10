import 'package:http/http.dart' as http;
import 'dart:convert';

void voteLomba(String username, String id) async {
  var map = new Map<String, dynamic>();
  map['customer'] = username;

  final response = await http.post(
    Uri.parse('https://buzzar-id.up.railway.app/lomba/flutter/vote/' + id),
    body: map,
  );

  print(response.body);
}