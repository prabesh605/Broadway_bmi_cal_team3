import 'package:broadway_bmi_cal/animation/first_screen.dart';
import 'package:broadway_bmi_cal/offline/info_model.dart';
import 'package:broadway_bmi_cal/offline/jsonplaceholder_screen.dart';
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
  void addUpdateData(Info? info) {
    TextEditingController nameController = TextEditingController(
      text: info?.name ?? "",
    );
    TextEditingController addressController = TextEditingController(
      text: info?.address ?? "",
    );
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            info == null
                ? Text("Save Data Offline")
                : Text("Update Data Offline"),
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
                  id: info == null ? 0 : info.id,
                );
                info == null
                    ? await OfflineService.instance.insert(data)
                    : await OfflineService.instance.update(data);
                // setState(() {
                //   myOfflineData.add(data);
                // });
                Navigator.pop(context);
              },
              child: info == null ? Text("save") : Text("Update"),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    List<Info> data = await OfflineService.instance.get();
    setState(() {
      myOfflineData = data;
    });
  }

  @override
  Widget build(BuildContext gitcontext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offline Screen"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirstScreen()),
              );
            },
            icon: Icon(Icons.arrow_back),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addUpdateData(null);
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              List<Info> data = await OfflineService.instance.get();
              setState(() {
                myOfflineData = data;
              });

              print(data);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => FirstScreen()),
              // );
            },
            child: Text("Get offline Data"),
          ),
          Text("My Data"),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: myOfflineData.length,
              itemBuilder: (context, index) {
                Info myData = myOfflineData[index];
                return ListTile(
                  leading: Text("${myData.id}"),
                  title: Text(myData.name),
                  subtitle: Text(myData.address),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          color: Colors.black,
                          onPressed: () {
                            addUpdateData(myData);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          color: Colors.red,
                          onPressed: () {
                            OfflineService.instance.delete(myData.id);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JsonplaceholderScreen(),
                ),
              );
            },
            child: Text("Next Screen"),
          ),
        ],
      ),
    );
  }
}
