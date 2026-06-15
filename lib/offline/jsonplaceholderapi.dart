import 'dart:convert';

import 'package:http/http.dart' as http;

class Jsonplaceholderapi {
  Future<List<Map<String, dynamic>>> getData() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );
    List<Map<String, dynamic>> json = jsonDecode(response.body);
    return json;
  }
}
