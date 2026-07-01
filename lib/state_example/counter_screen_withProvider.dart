import 'package:broadway_bmi_cal/animation/second_screen.dart';
import 'package:broadway_bmi_cal/state_example/counter_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterScreenWithprovider extends StatefulWidget {
  const CounterScreenWithprovider({super.key});

  @override
  State<CounterScreenWithprovider> createState() =>
      _CounterScreenWithproviderState();
}

class _CounterScreenWithproviderState extends State<CounterScreenWithprovider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Counter"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<CounterService>().increment();
                  },
                  icon: Icon(Icons.add),
                ),
                // Text("${context.watch<CounterService>().count}"),
                Consumer<CounterService>(
                  builder: (context, state, child) {
                    return Text("${state.count}");
                  },
                ),
                IconButton(
                  onPressed: () {
                    context.read<CounterService>().decrement();
                  },
                  icon: Icon(Icons.remove),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CounterService>().reset();
              },
              child: Text("Reset"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen()),
                );
              },
              child: Text("Next Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
