import 'package:flutter/material.dart';

class ThemeService with ChangeNotifier {
  bool isColorChange = false;
  void changeTheme() {
    isColorChange = !isColorChange;
    notifyListeners();
  }
}
