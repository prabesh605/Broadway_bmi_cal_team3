import 'package:broadway_bmi_cal/firebase/firebase_product_model.dart';

abstract class FirebaseProductState {}

class InitialProduct extends FirebaseProductState {}

class ProductLoading extends FirebaseProductState {}

class ProductError extends FirebaseProductState {}

class ProductLoaded extends FirebaseProductState {
  List<FirebaseProductsModel> products;
  ProductLoaded(this.products);
}
