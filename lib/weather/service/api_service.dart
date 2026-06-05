import 'dart:convert';

import 'package:broadway_bmi_cal/weather/const/api_constant.dart';
import 'package:broadway_bmi_cal/weather/models/weather_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location Not enabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<WeatherModel> getWeatherData() async {
    try {
      final Position position = await _getLocation();
      print("${position.latitude}, ${position.longitude}");
      final res = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=${ApiConstant.apiKey}",
        ),
      );

      if (res.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(res.body);
        return WeatherModel.fromJson(data);
      } else {
        throw Exception("Failed to fetch weather: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
