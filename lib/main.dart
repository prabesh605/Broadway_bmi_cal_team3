// import 'package:broadway_bmi_cal/bmi_screen.dart';
// import 'package:broadway_bmi_cal/bmi_calculator/bmi_screen.dart';
import 'package:broadway_bmi_cal/animation/animation_screen.dart';
import 'package:broadway_bmi_cal/animation/first_screen.dart';
import 'package:broadway_bmi_cal/bloc/bloc_services/counter_bloc.dart';
import 'package:broadway_bmi_cal/bloc/counter_screen_with_bloc.dart';
import 'package:broadway_bmi_cal/firebase/firebase_login_screen.dart';
import 'package:broadway_bmi_cal/firebase/firebase_screen.dart';
import 'package:broadway_bmi_cal/offline/offline_screen.dart';
import 'package:broadway_bmi_cal/restful-api/api_test_screen.dart';
import 'package:broadway_bmi_cal/state_example/cart_service.dart';
import 'package:broadway_bmi_cal/state_example/counter_screen.dart';
import 'package:broadway_bmi_cal/state_example/counter_screen_withProvider.dart';
import 'package:broadway_bmi_cal/state_example/counter_service.dart';
import 'package:broadway_bmi_cal/state_example/ecommerce_screen.dart';
import 'package:broadway_bmi_cal/state_example/theme_service.dart';
import 'package:broadway_bmi_cal/weather/api_service_with_provider.dart';
import 'package:broadway_bmi_cal/firebase/firebase_create_user_screen.dart';
import 'package:broadway_bmi_cal/weather/weather_screen.dart';
import 'package:broadway_bmi_cal/weather/weather_screen_with_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => CounterBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: EcommerceScreen(),
        home: ApiTestScreen(),
        // BmiScreen()
      ),
    );
  }
}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => CounterService()),
//         ChangeNotifierProvider(create: (_) => CartService()),
//         ChangeNotifierProvider(create: (_) => ThemeService()),
//         ChangeNotifierProvider(create: (_) => ApiServiceWithProvider()),
//       ],
//       child: Consumer<ThemeService>(
//         builder: (context, themeService, child) {
//           return MaterialApp(
//             theme: themeService.isColorChange
//                 ? ThemeData.dark()
//                 : ThemeData.light(),

//             // theme: ThemeData.light(),
//             debugShowCheckedModeBanner: false,
//             // home: EcommerceScreen(),
//             home: CounterScreenWithBloc(),
//             // BmiScreen()
//           );
//         },
//       ),
//     );
//   }
// }
