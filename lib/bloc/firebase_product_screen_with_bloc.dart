import 'package:broadway_bmi_cal/bloc/firebase_product_bloc/firebase_product_bloc.dart';
import 'package:broadway_bmi_cal/bloc/firebase_product_bloc/firebase_product_event.dart';
import 'package:broadway_bmi_cal/bloc/firebase_product_bloc/firebase_product_state.dart';
import 'package:broadway_bmi_cal/firebase/firbase_service.dart';
import 'package:broadway_bmi_cal/firebase/firebase_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirebaseProductScreenWithBloc extends StatefulWidget {
  const FirebaseProductScreenWithBloc({super.key});

  @override
  State<FirebaseProductScreenWithBloc> createState() =>
      _FirebaseProductScreenWithBlocState();
}

class _FirebaseProductScreenWithBlocState
    extends State<FirebaseProductScreenWithBloc> {
  // FirbaseService firebaseService = FirbaseService();
  // List<FirebaseProductsModel> products = [];
  void showButtonSheetDialog(FirebaseProductsModel? product) {
    TextEditingController titleController = TextEditingController(
      text: product?.title ?? "",
    );
    TextEditingController subtitleController = TextEditingController(
      text: product?.subtitle ?? "0",
    );
    TextEditingController priceController = TextEditingController(
      text: "${product?.price ?? 0}",
    );
    TextEditingController imageController = TextEditingController(
      text: product?.image ?? "",
    );
    TextEditingController ratingController = TextEditingController(
      text: "${product?.rating}",
    );

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        margin: EdgeInsets.all(12),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            product == null ? Text("Add Data") : Text("Update Data"),
            SizedBox(height: 20),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                label: Text("Title"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: subtitleController,
              decoration: InputDecoration(
                label: Text("SubTitle"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(
                label: Text("Price"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: imageController,
              decoration: InputDecoration(
                label: Text("Image"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: ratingController,
              decoration: InputDecoration(
                label: Text("Rating"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String title = titleController.text;
                String subtitle = subtitleController.text;
                double price = double.parse(priceController.text);
                String image = imageController.text;
                double rating = double.parse(ratingController.text);

                var product = FirebaseProductsModel(
                  id: '',
                  title: title,
                  subtitle: subtitle,
                  price: price,
                  image: image,
                  rating: rating,
                );
                // var product = {
                //   'title': title,
                //   'subtitle': subtitle,
                //   'price': price,
                //   'image': image,
                //   'rating': rating,
                // };

                // await firebaseService.insertProduct(product.toJson());
                // await firebaseService.insertProductWithModel(product);

                Navigator.pop(context);
              },
              child: product == null ? Text("Save") : Text("Update"),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> getProducts() async {
  //   products = await firebaseService.getFirebaseProducts();
  //   setState(() {});
  // }

  @override
  void initState() {
    // getProducts();
    context.read<FirebaseProductBloc>().add(GetFirebaseProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Firebase Products")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showButtonSheetDialog(null);
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: products.length,
          //     itemBuilder: (context, index) {
          //       FirebaseProductsModel product = products[index];
          //       return ListTile(title: Text(product.title));
          //     },
          //   ),
          // ),
          BlocBuilder<FirebaseProductBloc, FirebaseProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return CircularProgressIndicator();
              } else if (state is ProductError) {
                return Text("Error");
              } else if (state is ProductLoaded) {
                final products = state.products;
                return Expanded(
                  child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                    itemBuilder: (context, index) {
                      FirebaseProductsModel product = products[index];
                      return Card(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80,
                              child: Image.network(product.image ?? ""),
                            ),
                            Text(product.title),
                            Text(product.subtitle ?? ""),
                            Text("Price: ${product.price}"),
                            Text("Rating: ${product.rating}"),
                          ],
                        ),
                      );
                      //  ListTile(title: Text(product.title));
                    },
                  ),
                );
              }
              return Container();
            },
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     // getProducts();
          //   },
          //   child: Text("Get Data"),
          // ),
        ],
      ),
    );
  }
}
