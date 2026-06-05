import 'package:broadway_bmi_cal/weather/models/weather_data.dart';
import 'package:broadway_bmi_cal/weather/service/api_service.dart';
import 'package:broadway_bmi_cal/weather/widgets/extra_info_card.dart';
import 'package:broadway_bmi_cal/weather/widgets/location_weather_desc.dart';
import 'package:broadway_bmi_cal/weather/widgets/min_max_temp.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final ApiService apiService = ApiService();

  late Future<WeatherModel> _weatherData;

  @override
  void initState() {
    super.initState();
    _weatherData = apiService.getWeatherData();
  }

  void _refresh() {
    setState(() {
      _weatherData = apiService.getWeatherData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0b1426),
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Color(0xff0b1426),
        title: Text(
          "Weather App",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _refresh,
            icon: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 5),
              child: Icon(Icons.refresh, color: Colors.white),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: FutureBuilder<WeatherModel>(
        future: _weatherData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: TextButton(
                onPressed: _refresh,
                child: Text(snapshot.error.toString()),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Location, Weather desc
                LocationWeatherDesc(snapshot: snapshot),

                SizedBox(height: 15),
                // weather icon
                CircleAvatar(
                  backgroundColor: Color(0xff242b36),
                  radius: 50,
                  child: Image.network(
                    "https://openweathermap.org/img/wn/${snapshot.data!.icon}@2x.png",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(height: 12),
                // temperature
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${snapshot.data?.temp.toStringAsFixed(0)}',
                            style: TextStyle(fontSize: 60, color: Colors.white),
                          ),
                          WidgetSpan(
                            child: Transform.translate(
                              offset: Offset(2, -1),
                              child: Text(
                                '°C',
                                style: TextStyle(
                                  fontSize: 40,
                                  color: const Color.fromARGB(
                                    255,
                                    165,
                                    132,
                                    209,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Feels like: ${snapshot.data?.feelsLike.toStringAsFixed(0)}\u00B0C",
                      style: TextStyle(color: Color(0xff606672), fontSize: 18),
                    ),
                  ],
                ),

                SizedBox(height: 12),
                // min, max temp
                MinMaxTempWidget(snapshot: snapshot),

                SizedBox(height: 20),

                // extra info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //humidity
                    ExtraInfoCard(
                      icon: Icon(
                        Icons.water_drop,
                        color: Colors.blue,
                        size: 30,
                      ),
                      data: "${snapshot.data?.humidity}%",
                      title: "Humidity",
                    ),

                    //pressure
                    ExtraInfoCard(
                      icon: Icon(Icons.thermostat, color: Colors.red, size: 30),
                      data: "${snapshot.data?.pressure} hPa",
                      title: "Pressure",
                    ),
                  ],
                ),

                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Visibility
                    ExtraInfoCard(
                      icon: FaIcon(
                        FontAwesomeIcons.solidEye,
                        color: const Color.fromARGB(255, 132, 162, 198),
                        size: 30,
                      ),
                      data: "${((snapshot.data?.visibility)! / 1000)} km",
                      title: "Visibility",
                    ),

                    // Cloud cover %
                    ExtraInfoCard(
                      icon: Icon(Icons.cloud, color: Colors.white, size: 30),
                      data: "${snapshot.data?.cloudCover}%",
                      title: "Cloud cover",
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // wind
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff172031),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.wind_power_outlined,
                        size: 60,
                        color: Colors.blue,
                      ),

                      SizedBox(width: 20),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "WIND",
                            style: TextStyle(
                              color: Color.fromARGB(255, 141, 149, 165),
                              fontSize: 20,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            "${snapshot.data?.windSpeed.toStringAsFixed(1)} m/s",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
