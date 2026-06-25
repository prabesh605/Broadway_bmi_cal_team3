import 'package:broadway_bmi_cal/firebase/firebase_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirbaseService {
  Future<void> insertData(FirebaseModel data) async {
    await FirebaseFirestore.instance.collection('student').add(data.toJson());
  }

  //get Data from firebase
  Future<List> getAllData() async {
    QuerySnapshot allData = await FirebaseFirestore.instance
        .collection('student')
        .get();
    var result = allData.docs.map((e) => e.data()).toList();
    print(result);
    return result;
  }

  //get data from firebase with model
  Future<List<FirebaseModel>> getAllDataWithModel() async {
    QuerySnapshot allData = await FirebaseFirestore.instance
        .collection('student')
        .get();
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
}
