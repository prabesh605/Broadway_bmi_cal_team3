import 'dart:convert';

import 'package:broadway_bmi_cal/restful-api/api_test_model.dart';
import 'package:http/http.dart' as http;

//200
//400
//500

class ApiTestServices {
  String baseURl = "https://api.restful-api.dev/collections/products/objects";

  Future<List<TestApiResponse>> getAllData() async {
    http.Response response = await http.get(
      Uri.parse(baseURl),
      headers: {"x-api-key": "1b954e26-4980-463c-8f9f-89a7e3a56ab1"},
    );

    final List<dynamic> jsonData = jsonDecode(response.body);
    // jsonData[0]['name'];

    List<TestApiResponse> data = jsonData
        .map((item) => TestApiResponse.fromJson(item))
        .toList();
    print(data);
    // data[0].name;
    return data;
  }

  Future<bool> addData(
    String name,
    int year,
    double price,
    String cpuModel,
    String hardDiskSize,
  ) async {
    try {
      var data = {
        "name": name,
        "data": {
          "year": year,
          "price": price,
          "CPU model": cpuModel,
          "Hard disk size": hardDiskSize,
        },
      };

      http.Response response = await http.post(
        Uri.parse(baseURl),
        headers: {
          "x-api-key": "1b954e26-4980-463c-8f9f-89a7e3a56ab1",
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        print(response.body);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // print(e.toString());
      throw e.toString();
    }
  }

  Future<bool> updateDataApi(
    String id,
    String name,
    int year,
    double price,
    String cpuModel,
    String hardDiskSize,
  ) async {
    try {
      var data = {
        "name": name,
        "data": {
          "year": year,
          "price": price,
          "CPU model": cpuModel,
          "Hard disk size": hardDiskSize,
        },
      };

      http.Response response = await http.put(
        Uri.parse("$baseURl/$id"),
        headers: {
          "x-api-key": "1b954e26-4980-463c-8f9f-89a7e3a56ab1",
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        print(response.body);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
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
