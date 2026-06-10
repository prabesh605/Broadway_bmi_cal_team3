import 'dart:convert';

import 'package:broadway_bmi_cal/restful-api/api_test_model.dart';
import 'package:http/http.dart' as http;

class ApiTestServices {
  String baseURl = "https://api.restful-api.dev/collections/products/objects";

  Future<List<TestApiResponse>> getAllData() async {
    http.Response response = await http.get(
      Uri.parse(baseURl),
      headers: {"x-api-key": "1b954e26-4980-463c-8f9f-89a7e3a56ab1"},
    );
    final List<dynamic> jsonData = jsonDecode(response.body);

    List<TestApiResponse> data = jsonData
        .map((item) => TestApiResponse.fromJson(item))
        .toList();
    print(data);
    return data;
  }

  //create update api
  //create save api
  Future<void> deleteData(String id) async {
    http.Response response = await http.delete(
      Uri.parse("$baseURl/$id"),
      headers: {
        "x-api-key": "1b954e26-4980-463c-8f9f-89a7e3a56ab1",
        "Content-Type": "application/json",
      },
    );
    print(response.body);
  }
}
