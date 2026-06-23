import 'package:broadway_bmi_cal/firebase/firbase_service.dart';
import 'package:broadway_bmi_cal/firebase/firebase_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseScreen extends StatefulWidget {
  const FirebaseScreen({super.key});

  @override
  State<FirebaseScreen> createState() => _FirebaseScreenState();
}

class _FirebaseScreenState extends State<FirebaseScreen> {
  FirbaseService firebaseService = FirbaseService();
  List<FirebaseModel> students = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    students = await firebaseService.getAllDataWithModel();
    setState(() {});
  }

  void showButtonSheetDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController yearController = TextEditingController();
    TextEditingController marksController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        margin: EdgeInsets.all(12),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Add Data"),
            SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                label: Text("Name"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: yearController,
              decoration: InputDecoration(
                label: Text("Year"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: marksController,
              decoration: InputDecoration(
                label: Text("Marks"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text;
                int year = int.parse(yearController.text);
                int marks = int.parse(marksController.text);

                var data = FirebaseModel(
                  id: "",
                  name: name,
                  year: year,
                  marks: marks,
                );

                await firebaseService.insertData(data);
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Screen")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showButtonSheetDialog();
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                var student = students[index];
                return ListTile(
                  title: Text(student.name),
                  subtitle: Text("${student.marks}"),
                  trailing: IconButton(
                    onPressed: () async {
                      await firebaseService.deleteData(student.id ?? "i88");
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
