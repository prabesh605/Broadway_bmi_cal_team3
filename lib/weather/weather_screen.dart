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
  ApiService apiService = ApiService();
  TextEditingController controller = TextEditingController();

  WeatherModel? data;
  double? temp;
  double? speed;
  String? country;
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff080b30),
      appBar: AppBar(
        backgroundColor: Color(0xff080b30),
        title: Text("Weather Screen", style: TextStyle(color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Position position = await apiService.getCurrentLocation();
          double lat = position.latitude;
          double lon = position.longitude;
          //
          data = await apiService.getWeatherData(lat, lon);
          setState(() {});
        },
        child: Icon(Icons.my_location),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: controller,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () async {
                      String country = controller.text;
                      data = await apiService.getWeatherByCountry(country);
                      setState(() {});
                    },
                    icon: Icon(Icons.search, color: Colors.white),
                  ),
                ],
              ),
              // data != null ? Text('${data["coord"]}') : Container(),
              Text("☁︎", style: TextStyle(color: Colors.white, fontSize: 180)),

              Text("Wednesday 25 Dec", style: TextStyle(color: Colors.white)),
              SizedBox(height: 20),
              Text(
                "${data?.main.temp ?? 0.0}°",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 120),
              Row(
                children: [
                  Expanded(
                    child: CutomWidget(name: 'Rain', value: '90%', image: '☁︎'),
                  ),
                  Expanded(
                    child: CutomWidget(
                      name: 'Wind',
                      value: '7 km/h',
                      image: '☁︎',
                    ),
                  ),

                  Expanded(
                    child: CutomWidget(
                      name: 'Humidity',
                      value: '${data?.main.humidity ?? 0.0}%',
                      image: '☁︎',
                    ),
                  ),
                ],
              ),

              // Text(
              //   "Sunrise = ${data?.sys.sunrise ?? ''}",
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 26,
              //     color: Colors.white,
              //   ),
              // ),
              // Text(
              //   "Speed is ${speed ?? 0.0}",
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 26,
              //     color: Colors.white,
              //   ),
              // ),
              // Text("${data?.name}"),
              // Text("${data?.sys.country}"),
            ],
          ),
        ),
      ),
    );
  }
}

class CutomWidget extends StatelessWidget {
  const CutomWidget({
    super.key,
    required this.name,
    required this.value,
    required this.image,
  });
  final String name;
  final String value;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xff1b1e48),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(image, style: TextStyle(color: Colors.white, fontSize: 50)),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 22)),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
