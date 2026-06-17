import 'package:broadway_bmi_cal/state_example/product_model.dart';
import 'package:flutter/material.dart';

class CartService with ChangeNotifier {
  List<Product> cartItem = [];

  ///
  void addToCart(Product product) {
    cartItem.add(product);
    notifyListeners();
  }
}
