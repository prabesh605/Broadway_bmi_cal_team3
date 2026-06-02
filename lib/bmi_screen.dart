import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Gender { male, female }

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  Color unselectedColor = Color(0xff111328);
  Color backgroundColor = Color(0xff0a0e21);
  Color selectedColor = Color(0xff1d1e33);
  Gender? selectedGender;
  double height = 180;
  int weight = 70;
  int age = 18;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("BMI CALCULATOR", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TopCustomWidget(
                    unselectedColor: selectedGender == Gender.male
                        ? selectedColor
                        : unselectedColor,
                    name: 'MALE',
                    icon: FaIcon(
                      FontAwesomeIcons.mars,
                      color: Colors.white,
                      size: 60,
                    ),
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });

                      print(selectedGender?.name);
                    },
                  ),
                ),
                Expanded(
                  child: TopCustomWidget(
                    unselectedColor: selectedGender == Gender.female
                        ? selectedColor
                        : unselectedColor,
                    name: 'FEMALE',
                    icon: FaIcon(
                      FontAwesomeIcons.venus,
                      color: Colors.white,
                      size: 60,
                    ),
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.female;
                        print(selectedGender?.name);
                      });
                    },
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 50),
              decoration: BoxDecoration(
                color: unselectedColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "HEIGHT",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        height.toStringAsFixed(0),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Cm",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    max: 500,
                    value: height,
                    onChanged: (value) {
                      setState(() {
                        height = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: BottomCustomWidget(
                    unselectedColor: unselectedColor,
                    name: 'WEIGHT',
                    value: weight,
                    incrementOnTap: () {
                      setState(() {
                        weight++;
                      });
                    },
                    decrementOnTap: () {
                      setState(() {
                        weight--;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: BottomCustomWidget(
                    unselectedColor: unselectedColor,
                    name: 'AGE',
                    value: age,
                    incrementOnTap: () {
                      setState(() {
                        age++;
                      });
                    },
                    decrementOnTap: () {
                      setState(() {
                        age--;
                      });
                    },
                  ),
                ),
              ],
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  print("Print Values");
                },
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  height: 70,
                  width: double.infinity,
                  color: Color(0xffeb1555),
                  child: Text(
                    "CALCULATE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomCustomWidget extends StatelessWidget {
  const BottomCustomWidget({
    super.key,
    required this.unselectedColor,
    required this.name,
    required this.value,
    required this.incrementOnTap,
    required this.decrementOnTap,
  });

  final Color unselectedColor;
  final String name;
  final int value;
  final VoidCallback incrementOnTap;
  final VoidCallback decrementOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 50),
      decoration: BoxDecoration(
        color: unselectedColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: TextStyle(color: Colors.white)),
          SizedBox(height: 10),
          Text(
            "$value",
            style: TextStyle(
              color: Colors.white,
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                child: IconButton(
                  onPressed: decrementOnTap,
                  icon: Icon(Icons.remove),
                ),
              ),
              SizedBox(width: 10),
              CircleAvatar(
                child: IconButton(
                  onPressed: incrementOnTap,
                  icon: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TopCustomWidget extends StatelessWidget {
  const TopCustomWidget({
    super.key,
    required this.unselectedColor,
    required this.name,
    required this.icon,
    required this.onTap,
  });

  final Color unselectedColor;
  final String name;
  final Icon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical: 50),
        decoration: BoxDecoration(
          color: unselectedColor,
          borderRadius: BorderRadius.circular(12),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            SizedBox(height: 20),
            Text(name, style: TextStyle(color: Colors.grey, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
