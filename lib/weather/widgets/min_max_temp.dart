import 'package:broadway_bmi_cal/weather/models/weather_data.dart';
import 'package:flutter/material.dart';

class MinMaxTempWidget extends StatelessWidget {
  const MinMaxTempWidget({super.key, required this.snapshot});

  final AsyncSnapshot<WeatherModel> snapshot;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      height: 40,
      width: 250,
      decoration: BoxDecoration(
        color: Color(0xff151d2f),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.arrow_downward, color: Color(0xff5a8eb1)),
          SizedBox(width: 4),
          Text(
            "${snapshot.data?.tempMin.toStringAsFixed(1)}\u00B0C",
            style: TextStyle(fontSize: 18, color: Color(0xff5a8eb1)),
          ),

          SizedBox(width: 24),
          Text("|", style: TextStyle(color: Colors.grey, fontSize: 18)),

          SizedBox(width: 20),
          Icon(Icons.arrow_upward, color: Color(0xfff2af76)),

          SizedBox(width: 4),
          Text(
            "${snapshot.data?.tempMax.toStringAsFixed(1)}\u00B0C",
            style: TextStyle(fontSize: 18, color: Color(0xff5a8eb1)),
          ),
        ],
      ),
    );
  }
}
