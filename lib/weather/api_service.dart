import 'dart:convert';

import 'package:broadway_bmi_cal/weather/weather_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String apiKey = "0b10461d5a30e6612ce19d84c97ef651";

  Future<WeatherModel> getWeatherData(double lat, double lon) async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey";

    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    WeatherModel weather = WeatherModel.fromJson(json);
    return weather;
  }

  Future<WeatherModel> getWeatherByCountry(String country) async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$country&appid=$apiKey";
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    WeatherModel weather = WeatherModel.fromJson(json);
    return weather;
  }

  Future<Position> getCurrentLocation() async {
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
}
