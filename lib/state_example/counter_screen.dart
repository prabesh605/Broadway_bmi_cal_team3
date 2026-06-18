import 'package:broadway_bmi_cal/animation/second_screen.dart';
import 'package:broadway_bmi_cal/state_example/cart_service.dart';
import 'package:broadway_bmi_cal/state_example/ecommerce_screen.dart';
import 'package:broadway_bmi_cal/state_example/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int count = 0;
  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext gitcontext) {
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
                    increment();
                  },
                  icon: Icon(Icons.add),
                ),
                Text("$count"),
                IconButton(
                  onPressed: () {
                    decrement();
                  },
                  icon: Icon(Icons.remove),
                ),
              ],
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
            Expanded(
              child: ListView.builder(
                itemCount: context.watch<CartService>().cartItem.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = context
                      .watch<CartService>()
                      .cartItem[index];
                  return ListTile(
                    leading: Image.network(product.image, height: 100),
                    title: Text(product.name),
                    subtitle: Text("Price: ${product.price}"),
                    trailing: Icon(Icons.shopping_cart),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
