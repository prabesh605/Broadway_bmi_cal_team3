// import 'package:broadway_bmi_cal/bmi_screen.dart';
// import 'package:broadway_bmi_cal/bmi_calculator/bmi_screen.dart';
import 'package:broadway_bmi_cal/restful-api/api_test_screen.dart';
import 'package:broadway_bmi_cal/weather/login_screen.dart';
import 'package:broadway_bmi_cal/weather/weather_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext gitcontext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ApiTestScreen(),
      //  WeatherScreen(),
      // BmiScreen()
    );
  }
}
