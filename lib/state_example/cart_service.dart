import 'package:broadway_bmi_cal/state_example/product_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class CartService with ChangeNotifier {
  List<Product> cartItem = [];
  bool isLoading = false;
  List data = [];

  ///
  void addToCart(Product product) {
    cartItem.add(product);
    notifyListeners();
  }

  Future<void> loadData() async {
    isLoading = true;
    notifyListeners();
    // await Future.delayed(Duration(seconds: 5));
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );
    var json = jsonDecode(response.body);
    data = json;
    isLoading = false;
    notifyListeners();
    // return json;
  }
}
