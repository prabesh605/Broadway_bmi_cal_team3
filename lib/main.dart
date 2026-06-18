// import 'package:broadway_bmi_cal/bmi_screen.dart';
// import 'package:broadway_bmi_cal/bmi_calculator/bmi_screen.dart';
import 'package:broadway_bmi_cal/animation/animation_screen.dart';
import 'package:broadway_bmi_cal/animation/first_screen.dart';
import 'package:broadway_bmi_cal/offline/offline_screen.dart';
import 'package:broadway_bmi_cal/restful-api/api_test_screen.dart';
import 'package:broadway_bmi_cal/state_example/cart_service.dart';
import 'package:broadway_bmi_cal/state_example/counter_screen.dart';
import 'package:broadway_bmi_cal/state_example/counter_screen_withProvider.dart';
import 'package:broadway_bmi_cal/state_example/counter_service.dart';
import 'package:broadway_bmi_cal/state_example/ecommerce_screen.dart';
import 'package:broadway_bmi_cal/state_example/theme_service.dart';
import 'package:broadway_bmi_cal/weather/login_screen.dart';
import 'package:broadway_bmi_cal/weather/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterService()),
        ChangeNotifierProvider(create: (_) => CartService()),
        ChangeNotifierProvider(create: (_) => ThemeService()),
      ],
      child: MaterialApp(
        // themeMode: context.watch<ThemeService>().isColorChange
        //     ? ThemeMode.dark
        //     : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: EcommerceScreen(),
        //  WeatherScreen(),
        // BmiScreen()
      ),
    );
  }
}
