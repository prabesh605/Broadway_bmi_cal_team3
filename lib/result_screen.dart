import 'package:broadway_bmi_cal/bmi_service.dart';
import 'package:broadway_bmi_cal/constant.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.bmiValue,
    required this.category,
    required this.advice,
    required this.gender,
    required this.age,
  });
  final double bmiValue;
  final String category;
  final String advice;
  final String gender;
  final int age;

  @override
  Widget build(BuildContext context) {
    BmiService service = BmiService();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Result", style: TextStyle(color: Colors.white)),
        backgroundColor: appbarBackgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 12),
            child: Text(
              "Your Result",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(12),
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: highlightedColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  gender,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "AGE is $age",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  bmiValue.toStringAsFixed(2),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 82,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  advice,
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              service.reset();
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.all(12),
              height: 60,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: buttomColor,
              ),
              child: Center(
                child: Text(
                  "RE-CALCULATE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
