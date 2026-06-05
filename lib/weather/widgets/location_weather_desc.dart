import 'package:broadway_bmi_cal/weather/models/weather_data.dart';
import 'package:flutter/material.dart';

class LocationWeatherDesc extends StatelessWidget {
  const LocationWeatherDesc({
    super.key, required this.snapshot,
  });

  final AsyncSnapshot<WeatherModel> snapshot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              color: Color(0xff4a72af),
              size: 22,
            ),
            SizedBox(width: 5),
            Text(
              "${snapshot.data?.city}, ${snapshot.data?.country}",
              style: TextStyle(
                color: Color(0xff527fc1),
                fontSize: 22,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
    
        Text(
          "${snapshot.data?.description}".toUpperCase(),
          style: TextStyle(fontSize: 22, color: Color(0xff606672)),
        ),
      ],
    );
  }
}