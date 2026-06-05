import 'dart:convert';

import 'package:broadway_bmi_cal/weather/weather_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<WeatherModel> getWeatherData(double lat, double lon) async {
    String apiKey = "0b10461d5a30e6612ce19d84c97ef651";
    var response = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey",
      ),
    );
    var json = jsonDecode(response.body);
    //
    WeatherModel weather = WeatherModel.fromJson(json);
  
    //
    return weather;
  }
}
