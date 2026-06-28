import 'package:broadway_bmi_cal/firebase/firebase_model.dart';
import 'package:broadway_bmi_cal/firebase/firebase_product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirbaseService {
  //////////////////////---Student------------/////////////////////////
  Future<void> insertData(FirebaseModel data) async {
    await FirebaseFirestore.instance.collection('student').add(data.toJson());
  }

  //get Data from firebase
  Future<List> getAllData() async {
    QuerySnapshot allData =
        await FirebaseFirestore.instance.collection('student').get();
    var result = allData.docs.map((e) => e.data()).toList();
    print(result);
    return result;
  }

  //get data from firebase with model
  Future<List<FirebaseModel>> getAllDataWithModel() async {
    QuerySnapshot allData =
        await FirebaseFirestore.instance.collection('student').get();
    // var result = allData.docs.map((e) => e.data()).toList();
    List<FirebaseModel> result = allData.docs.map((doc) {
      return FirebaseModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
    // print(result);
    return result;
  }

  //delete data
  Future<void> deleteData(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('student')
          .doc("$id")
          .delete();
    } catch (e) {
      throw e.toString();
    }
  }

  //update data
  Future<void> updateData(FirebaseModel updateData) async {
    try {
      await FirebaseFirestore.instance
          .collection('student')
          .doc(updateData.id)
          .update(updateData.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

  Stream<List<FirebaseModel>> getStreamData() {
    return FirebaseFirestore.instance.collection('student').snapshots().map((
      snapshot,
    ) {
      return snapshot.docs.map((doc) {
        return FirebaseModel.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }

  ///////////////////---------students--------------////////////////////

  /////////////////////-------------products-----------------///////////////////////////

  Future<void> insertProduct(Map<String, dynamic> product) async {
    await FirebaseFirestore.instance.collection('Products').add(product);
  }

  Future<void> insertProductWithModel(FirebaseProductsModel product) async {
    await FirebaseFirestore.instance
        .collection('Products')
        .add(product.toJson());
  }

  Future<List<FirebaseProductsModel>> getFirebaseProducts() async {
    try {
      QuerySnapshot result =
          await FirebaseFirestore.instance.collection('Products').get();
      return result.docs
          .map(
            (doc) => FirebaseProductsModel.fromJsom(
              doc.data() as Map<String, dynamic>,
              doc.id,
            ),
          )
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  /////////////////////-------------products-----------------///////////////////////////

  Future<UserCredential> createUser(String email, String password) async {
    try {
      UserCredential crediential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // print(crediential);
      return crediential;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential crediential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // print(crediential);
      return crediential;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn.instance.authenticate();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = googleUser!.authentication;

    // Create a new credential
    final credential =
        GoogleAuthProvider.credential(idToken: googleAuth.idToken);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
//gradlew signingReport
