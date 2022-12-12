import 'package:buzzarid_mobile/products/model/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Products>> fetchProducts() async {
  var url = Uri.parse('https://buzzar-id.up.railway.app/products/json/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // Decode response to json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // Convert json data to object
  List<Products> products = [];
  for (var d in data) {
    if (d != null) {
      products.add(Products.fromJson(d));
    }
  }

  return products;
}
