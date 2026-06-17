import 'package:flutter/material.dart';

class CounterService with ChangeNotifier {
  int count = 0;
  void increment() {
    count++;

    notifyListeners();
  }

  void decrement() {
    count--;
    notifyListeners();
  }

  void reset() {
    count = 0;
    notifyListeners();
  }
}
