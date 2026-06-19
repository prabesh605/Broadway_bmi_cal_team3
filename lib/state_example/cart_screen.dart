import 'package:broadway_bmi_cal/state_example/cart_service.dart';
import 'package:broadway_bmi_cal/state_example/counter_screen.dart';
import 'package:broadway_bmi_cal/state_example/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Consumer<CartService>(
            builder: (context, cartService, child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: cartService.cartItem.length,
                  itemBuilder: (BuildContext context, int index) {
                    Product product = cartService.cartItem[index];
                    return ListTile(
                      leading: Image.network(product.image, height: 100),
                      title: Text(product.name),
                      subtitle: Text("Price: ${product.price}"),
                      trailing: Icon(Icons.shopping_cart),
                    );
                  },
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CounterScreen()),
              );
            },
            child: Text("Counter Screen"),
          ),
        ],
      ),
    );
  }
}
