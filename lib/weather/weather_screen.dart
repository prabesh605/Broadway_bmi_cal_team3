import 'package:broadway_bmi_cal/weather/api_service.dart';
import 'package:broadway_bmi_cal/weather/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String apiKey = '0b10461d5a30e6612ce19d84c97ef651';
  ApiService apiService = ApiService();
  //
  Future<Position> getLocation() async {
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

  WeatherModel? data;
  double? temp;
  double? speed;
  String? country;
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather Screen")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Position position = await getLocation();
          //step 1 get locaion
          // step 2 we get lat and lon from current location

          print(position);
          double lat = position.latitude;
          double lon = position.longitude;
          //

          data = await apiService.getWeatherData(lat, lon);
          setState(() {});

          // if (data != null) {
          //   temp = data!.temp;
          //   name = data!.name;
          //   speed = data!.speed;
          // }

          // print(data['coord']);
        },
        child: Icon(Icons.my_location),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // data != null ? Text('${data["coord"]}') : Container(),
            Text(
              "Temperature is ${data?.main.temp ?? 0.0}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            Text(
              "Sunrise = ${data?.sys.sunrise ?? ''}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            Text(
              "Speed is ${speed ?? 0.0}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     // dynamic data = await apiService.getWeatherData();
            //     // print(data['coord']);
            //   },
            //   child: Text("Location"),
            // ),
          ],
        ),
      ),
    );
  }
}
