import 'package:broadway_bmi_cal/animation/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  double value = 0.0;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );
    // animation = ColorTween(
    //   begin: Colors.red,
    //   end: Colors.blue,
    // ).animate(controller);
    animation = Tween<double>(
      begin: 50,
      end: 300,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOutBack));
    // animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    controller.forward();
    animation.addListener(() {
      setState(() {
        // value = animation.value * 100;
        // value = animation.value;
        // print(value);
      });
    });

    // controller.reverse(from: 1.0);
    // controller.addListener(() {
    //   setState(() {
    //     value = controller.value * 100;
    //   });
    //   print("${controller.value}");
    //   print(controller.status);
    // });
    // controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // Text(
              //   "Loading ${value.toStringAsFixed(0)}%",
              //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(right: 10),
              //   child: Icon(Icons.image, size: animation.value),
              // ),
              Icon(Icons.image)
                  .animate()
                  .fade(duration: 500.ms)
                  .scale(delay: 500.ms), // runs after fade.
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => SecondScreen()),
              //     );
              //   },
              //   child: Text("Button"),
              // ),
              // Container(height: 600, width: 600, color: animation.value),
            ],
          ),
        ),
      ),
    );
  }
}
