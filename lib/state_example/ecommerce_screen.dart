import 'package:broadway_bmi_cal/state_example/cart_screen.dart';
import 'package:broadway_bmi_cal/state_example/cart_service.dart'
    show CartService;
import 'package:broadway_bmi_cal/state_example/counter_screen.dart';
import 'package:broadway_bmi_cal/state_example/product_model.dart';
import 'package:broadway_bmi_cal/state_example/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EcommerceScreen extends StatefulWidget {
  const EcommerceScreen({super.key});

  @override
  State<EcommerceScreen> createState() => _EcommerceScreenState();
}

class _EcommerceScreenState extends State<EcommerceScreen> {
  // bool isLoading = false;
  // Future<void> loadData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   await Future.delayed(Duration(seconds: 5));
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // List<Product> cartItem = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Switch(
              value: context.watch<ThemeService>().isColorChange,
              // value: true,
              onChanged: (value) {
                context.read<ThemeService>().changeTheme();
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = products[index];
                  return ListTile(
                    leading: Image.network(product.image, height: 100),
                    title: Text(product.name),
                    subtitle: Text("Price: ${product.price}"),
                    trailing: IconButton(
                      onPressed: () {
                        // cartItem.add(product);
                        context.read<CartService>().addToCart(product);
                        print(products);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${product.name} is Added to Cart"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      icon: Icon(Icons.shopping_cart),
                    ),
                  );
                },
              ),
            ),
            // isLoading
            //     ? CircularProgressIndicator()
            //     : ElevatedButton(
            //         onPressed: () {
            //           loadData();
            //         },
            //         child: Text("Load Data"),
            //       ),
            // CircularProgressIndicator(),
            context.watch<CartService>().isLoading == true
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      context.read<CartService>().loadData();
                    },
                    child: Text("Load Data"),
                  ),
            SizedBox(height: 60),
            Consumer<CartService>(
              builder: (context, service, child) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: service.data.length,
                    itemBuilder: (context, index) {
                      var data = service.data[index];
                      return ListTile(title: Text(data['title']));
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
              child: Text("View in Counter Screen"),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Product> products = [
  Product(
    image: 'https://picsum.photos/id/1/200/200',
    name: 'iPhone 15 Pro',
    price: 999.99,
  ),
  Product(
    image: 'https://picsum.photos/id/2/200/200',
    name: 'Samsung Galaxy S24',
    price: 899.99,
  ),
  Product(
    image: 'https://picsum.photos/id/3/200/200',
    name: 'MacBook Air M3',
    price: 1299.99,
  ),
  Product(
    image: 'https://picsum.photos/id/4/200/200',
    name: 'AirPods Pro',
    price: 249.99,
  ),
  Product(
    image: 'https://picsum.photos/id/5/200/200',
    name: 'Apple Watch',
    price: 399.99,
  ),
];
