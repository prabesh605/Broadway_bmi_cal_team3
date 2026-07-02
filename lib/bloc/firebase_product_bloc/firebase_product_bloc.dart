import 'package:broadway_bmi_cal/bloc/firebase_product_bloc/firebase_product_event.dart';
import 'package:broadway_bmi_cal/bloc/firebase_product_bloc/firebase_product_state.dart';
import 'package:broadway_bmi_cal/firebase/firbase_service.dart';
import 'package:broadway_bmi_cal/firebase/firebase_product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirebaseProductBloc
    extends Bloc<FirebaseProductEvent, FirebaseProductState> {
  FirbaseService firbaseService = FirbaseService();
  List<FirebaseProductsModel> products = [];
  FirebaseProductBloc() : super(InitialProduct()) {
    on<GetFirebaseProducts>((event, emit) async {
      emit(ProductLoading());
      products = await firbaseService.getFirebaseProducts();
      if (products.isNotEmpty) {
        emit(ProductLoaded(products));
      } else {
        emit(ProductError());
      }
    });
  }
}
