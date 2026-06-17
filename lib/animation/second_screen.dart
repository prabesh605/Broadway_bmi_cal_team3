import 'package:broadway_bmi_cal/offline/offline_screen.dart';
import 'package:broadway_bmi_cal/state_example/counter_screen.dart';
import 'package:broadway_bmi_cal/state_example/counter_screen_withProvider.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Second Screen"),
              Hero(tag: "image", child: Icon(Icons.image, size: 500)),
              // Icon(Icons.image, size: 500),
              ElevatedButton(
                onPressed: () {
                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CounterScreenWithprovider(),
                    ),
                  );
                },
                child: Text("Button"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
