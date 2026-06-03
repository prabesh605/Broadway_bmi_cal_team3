// import 'package:broadway_bmi_cal/bmi_screen.dart';
// import 'package:broadway_bmi_cal/bmi_calculator/bmi_screen.dart';
import 'package:broadway_bmi_cal/weather/weather_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
      // BmiScreen()
    );
  }
}
