import 'package:broadway_bmi_cal/firebase/firebase_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirbaseService {
  Future<void> insertData(FirebaseModel data) async {
    await FirebaseFirestore.instance.collection('student').add(data.toJson());
  }

  Future<List> getAllData() async {
    QuerySnapshot allData = await FirebaseFirestore.instance
        .collection('student')
        .get();
    var result = allData.docs.map((e) => e.data()).toList();
    print(result);
    return result;
  }

  Future<List<FirebaseModel>> getAllDataWithModel() async {
    QuerySnapshot allData = await FirebaseFirestore.instance
        .collection('student')
        .get();
    // var result = allData.docs.map((e) => e.data()).toList();
    List<FirebaseModel> result = allData.docs.map((doc) {
      return FirebaseModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
    print(result);
    return result;
  }

  Future<void> deleteData(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('student')
          .doc("FnMApDRumBG8leIQYBre")
          .delete();
    } catch (e) {
      throw e.toString();
    }
  }
}
