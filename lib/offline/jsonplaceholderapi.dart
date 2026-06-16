import 'dart:convert';

import 'package:http/http.dart' as http;

class Jsonplaceholderapi {
  Future<dynamic> getData() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );
    dynamic json = jsonDecode(response.body);

    return json;
  }
}
