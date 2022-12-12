import 'package:http/http.dart' as http;
import 'dart:convert';

void sendLomba(String nama, String keteranganLomba) {
  var map = new Map<String, dynamic>();
  map['namaLomba'] = nama;
  map['keterangan'] = keteranganLomba;

  final response = http.post(
    Uri.parse('https://buzzar-id.up.railway.app/lomba/buat/'),
    body: map,
  );
}