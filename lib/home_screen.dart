import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Gender { male, female }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Gender? gender;
  int weight = 60;
  int age = 12;
  double height = 150;

  Color highlightedColor = Color(0xff4c4f5e);
  Color unhighlightedColor = Color(0xff111328);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0a0e21),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.black,
        title: Text("BMI CALCULATOR", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomWidget(
                  name: 'MALE',
                  icon: FontAwesomeIcons.mars,
                  onTap: () {
                    setState(() {
                      gender = Gender.male;
                    });

                    print(gender!.name);
                  },
                  color: gender == Gender.male
                      ? highlightedColor
                      : unhighlightedColor,
                ),
              ),
              Expanded(
                child: CustomWidget(
                  name: 'FEMALE',
                  icon: FontAwesomeIcons.venus,
                  onTap: () {
                    setState(() {
                      gender = Gender.female;
                    });
                  },
                  color: gender == Gender.female
                      ? highlightedColor
                      : unhighlightedColor,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              // height: 250,
              // width: double.infinity,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: unhighlightedColor,
              ),
              //  MediaQuery.of(context).size.width * 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "HEIGHT",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        height.toStringAsFixed(0),
                        style: TextStyle(color: Colors.white, fontSize: 28),
                      ),
                      Text(
                        "cm",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  Slider(
                    value: height,
                    min: 100,
                    max: 500,
                    onChanged: (value) {
                      setState(() {
                        height = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ButtomCustomWidget(
                    unhighlightedColor: unhighlightedColor,
                    name: "WEIGHT",
                    value: weight,
                    decrementOnTap: () {
                      setState(() {
                        weight--;
                      });
                    },
                    incrementOnTap: () {
                      setState(() {
                        weight++;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ButtomCustomWidget(
                    unhighlightedColor: unhighlightedColor,
                    name: "AGE",
                    value: age,
                    decrementOnTap: () {
                      setState(() {
                        age--;
                      });
                    },
                    incrementOnTap: () {
                      setState(() {
                        age++;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ButtomCustomWidget extends StatelessWidget {
  const ButtomCustomWidget({
    super.key,
    required this.unhighlightedColor,
    required this.name,
    required this.value,
    required this.decrementOnTap,
    required this.incrementOnTap,
  });

  final Color unhighlightedColor;
  final String name;
  final int value;
  final VoidCallback decrementOnTap;
  final VoidCallback incrementOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: unhighlightedColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(name, style: TextStyle(color: Colors.white, fontSize: 18)),
          SizedBox(height: 10),
          Text("$value", style: TextStyle(color: Colors.white, fontSize: 28)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: decrementOnTap,
                child: CircleAvatar(
                  child: Icon(Icons.remove, color: Colors.black),
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: incrementOnTap,
                child: CircleAvatar(
                  child: Icon(Icons.add, color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  const CustomWidget({
    super.key,
    required this.name,
    required this.icon,
    required this.onTap,
    required this.color,
  });
  final String name;
  final FaIconData icon;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),

        // height: 250,
        // width: MediaQuery.of(context).size.width * 0.45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, color: Colors.white, size: 120),
            SizedBox(height: 20),
            Text(name, style: TextStyle(color: Colors.grey, fontSize: 22)),
          ],
        ),
      ),
    );
  }
}
