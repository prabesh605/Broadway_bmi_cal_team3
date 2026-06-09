import 'dart:convert';

import 'package:broadway_bmi_cal/restful-api/api_test_model.dart';
import 'package:http/http.dart' as http;

class ApiTestServices {
  String baseURl = "https://api.restful-api.dev/objects";

  Future<List<TestApiResponse>> getAllData() async {
    http.Response response = await http.get(Uri.parse(baseURl));
    var jsonData = jsonDecode(response.body);
    var data = jsonData.map((item) => TestApiResponse.fromJson(item)).toList();
    return data;
  }
}
