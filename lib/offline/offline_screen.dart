import 'package:broadway_bmi_cal/animation/first_screen.dart';
import 'package:broadway_bmi_cal/offline/info_model.dart';
import 'package:broadway_bmi_cal/offline/offline_service.dart';
import 'package:flutter/material.dart';

class OfflineScreen extends StatefulWidget {
  const OfflineScreen({super.key});

  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  List<Info> myOfflineData = [
    // Info(name: "Prabesh", address: "address")
  ];
  void addUpdateData() {
    TextEditingController nameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Save Data Offline"),
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
              controller: addressController,
              decoration: InputDecoration(
                label: Text("Address"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                print(nameController.text);
                print(addressController.text);
                Info data = Info(
                  name: nameController.text,
                  address: addressController.text,
                );

                await OfflineService.instance.insert(data);
                setState(() {
                  myOfflineData.add(data);
                });
                Navigator.pop(context);
              },
              child: Text("save"),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext gitcontext) {
    return Scaffold(
      appBar: AppBar(title: Text("Offline Screen")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addUpdateData();
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirstScreen()),
              );
            },
            child: Text("Next Screen"),
          ),
          Text("My Data"),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: myOfflineData.length,
              itemBuilder: (context, index) {
                Info myData = myOfflineData[index];
                return ListTile(
                  title: Text(myData.name),
                  subtitle: Text(myData.address),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
