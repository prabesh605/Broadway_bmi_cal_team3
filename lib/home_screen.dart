import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0e112e),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.black,
        title: Text("BMI CALCULATOR", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Row(
            children: [
              CustomWidget(name: 'MALE', icon: FontAwesomeIcons.mars),
              CustomWidget(name: 'FEMALE', icon: FontAwesomeIcons.venus),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  const CustomWidget({super.key, required this.name, required this.icon});
  final String name;
  final FaIconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xff181d4a),
        borderRadius: BorderRadius.circular(12),
      ),
      height: 250,
      width: MediaQuery.of(context).size.width * 0.45,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(icon, color: Colors.white, size: 120),
          SizedBox(height: 20),
          Text(name, style: TextStyle(color: Colors.grey, fontSize: 22)),
        ],
      ),
    );
  }
}
