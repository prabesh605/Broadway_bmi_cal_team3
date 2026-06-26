import 'package:broadway_bmi_cal/firebase/firbase_service.dart';
import 'package:broadway_bmi_cal/firebase/firebase_login_screen.dart';
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
  late Future<List<FirebaseModel>> students;
  // late Stream<List<FirebaseModel>> streamStudents;

  @override
  void initState() {
    getData();
    // streamStudents = firebaseService.getStreamData();
    // students = firebaseService.getAllDataWithModel();
    super.initState();
  }

  Future<void> getData() async {
    // students =
    students = firebaseService.getAllDataWithModel();
    setState(() {});
    // setState(() {});
  }

  void showButtonSheetDialog(FirebaseModel? firebaseData) {
    TextEditingController nameController = TextEditingController(
      text: firebaseData?.name ?? "",
    );
    TextEditingController yearController = TextEditingController(
      text: firebaseData?.year ?? "0",
    );
    TextEditingController marksController = TextEditingController(
      text: firebaseData?.marks ?? "0",
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
            firebaseData == null ? Text("Add Data") : Text("Update Data"),
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
                  id: firebaseData == null ? "" : firebaseData.id,
                  name: name,
                  year: "$year",
                  marks: "$marks",
                );
                if (firebaseData == null) {
                  //create
                  await firebaseService.insertData(data);
                } else {
                  //update
                  await firebaseService.updateData(data);
                }

                Navigator.pop(context);
              },
              child: firebaseData == null ? Text("Save") : Text("Update"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Screen"),
        actions: [
          IconButton(
            onPressed: () {
              firebaseService.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => FirebaseLoginScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showButtonSheetDialog(null);
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              getData();
            },
            child: Text("Refresh"),
          ),
          FutureBuilder(
            future: students,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text("Error");
              }
              final List<FirebaseModel> students = snapshot.data!;
              return Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    var student = students[index];

                    return ListTile(
                      title: Text(student.name),
                      subtitle: Text("${student.marks}"),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                showButtonSheetDialog(student);
                              },
                              icon: Icon(Icons.edit, color: Colors.green),
                            ),
                            IconButton(
                              onPressed: () async {
                                await firebaseService.deleteData(
                                  student.id ?? "i88",
                                );
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          StreamBuilder(
            stream: firebaseService.getStreamData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Error"));
              }
              final students = snapshot.data!;
              return Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    var student = students[index];
                    return ListTile(
                      title: Text(student.name),
                      subtitle: Text("${student.marks}"),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                showButtonSheetDialog(student);
                              },
                              icon: Icon(Icons.edit, color: Colors.green),
                            ),
                            IconButton(
                              onPressed: () async {
                                await firebaseService.deleteData(
                                  student.id ?? "i88",
                                );
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: students.length,
          //     itemBuilder: (context, index) {
          //       var student = students[index];
          //       return ListTile(
          //         title: Text(student.name),
          //         subtitle: Text("${student.marks}"),
          //         trailing: SizedBox(
          //           width: 100,
          //           child: Row(
          //             children: [
          //               IconButton(
          //                 onPressed: () async {
          //                   showButtonSheetDialog(student);
          //                 },
          //                 icon: Icon(Icons.edit, color: Colors.green),
          //               ),
          //               IconButton(
          //                 onPressed: () async {
          //                   await firebaseService.deleteData(
          //                     student.id ?? "i88",
          //                   );
          //                 },
          //                 icon: Icon(Icons.delete, color: Colors.red),
          //               ),
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
