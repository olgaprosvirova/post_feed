import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

Future<List> getDataFromAPI(String url) async {
  final response = await get(url);
  if (response.statusCode==200) {
    return json.decode(response.body);
  }
  else {
    throw Exception ("Failed to load data");
  }
}