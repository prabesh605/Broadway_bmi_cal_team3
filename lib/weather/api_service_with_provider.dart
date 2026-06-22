import 'dart:convert';

import 'package:broadway_bmi_cal/weather/weather_model.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ApiServiceWithProvider with ChangeNotifier {
  String apiKey = "0b10461d5a30e6612ce19d84c97ef651";
  bool isLoading = false;

  WeatherModel? weather;
  Position? position;
  String weatherImage = '☁︎';
  Future<WeatherModel?> getWeatherData(double lat, double lon) async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey";

    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    weather = WeatherModel.fromJson(json);
    notifyListeners();
    return WeatherModel.fromJson(json);
  }

  Future<WeatherModel?> getWeatherByCountry(String country) async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$country&appid=$apiKey";
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    weather = WeatherModel.fromJson(json);
    notifyListeners();
    return weather;
  }

  Future<String> login(String email, String password) async {
    String url = "https://api.restful-api.dev/login";
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        "x-api-key": "1b954e26-4980-463c-8f9f-89a7e3a56ab1",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"email": "$email", "password": "$password"}),
    );
    var json = jsonDecode(response.body);
    print(json['token']);
    return json['token'] ?? "";
  }

  Future<Position?> getCurrentLocation() async {
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
    position = await Geolocator.getCurrentPosition();
    notifyListeners();
    return position;
  }

  String checkWeather(int weatherCode) {
    if (weatherCode >= 200 && weatherCode < 300) {
      return '⛈️'; // Thunderstorm
    } else if (weatherCode >= 300 && weatherCode < 400) {
      return '🌦️'; // Drizzle
    } else if (weatherCode >= 500 && weatherCode < 600) {
      return '🌧️'; // Rain
    } else if (weatherCode >= 600 && weatherCode < 700) {
      return '❄️'; // Snow
    } else if (weatherCode >= 700 && weatherCode < 800) {
      return '🌫️'; // Fog, Mist, Haze
    } else if (weatherCode == 800) {
      return '☀️'; // Clear Sky
    } else if (weatherCode > 800 && weatherCode <= 804) {
      return '☁️'; // Clouds
    } else {
      return '🤷'; // Unknown weather
    }
  }

  int getRainPercentage(int humidity, int clouds) {
    int rainChance = ((humidity * 0.6) + (clouds * 0.4)).round();
    return rainChance;
  }

  void getLocationData() async {
    isLoading = true;
    notifyListeners();
    Position? position = await getCurrentLocation();
    double lat = position?.latitude ?? 0.0;
    double lon = position?.longitude ?? 0.0;
    //

    weather = await getWeatherData(lat, lon);

    weatherImage = checkWeather(weather?.cod ?? 200);
    isLoading = false;
    notifyListeners();
  }

  Future<void> getLocationDataWithSearch(String country) async {
    weather = await getWeatherByCountry(country);

    weatherImage = checkWeather(weather?.cod ?? 200);
    notifyListeners();
  }
}
