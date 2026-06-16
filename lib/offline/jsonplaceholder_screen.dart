import 'package:broadway_bmi_cal/offline/jsonplaceholderapi.dart';
import 'package:broadway_bmi_cal/offline/offline_service.dart';
import 'package:broadway_bmi_cal/offline/store_data.dart';
import 'package:flutter/material.dart';

class JsonplaceholderScreen extends StatefulWidget {
  const JsonplaceholderScreen({super.key});

  @override
  State<JsonplaceholderScreen> createState() => _JsonplaceholderScreenState();
}

class _JsonplaceholderScreenState extends State<JsonplaceholderScreen> {
  Jsonplaceholderapi jsonplaceholderapi = Jsonplaceholderapi();
  List jsonPlaceholderData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                // print(jsonPlaceholderData.length);
                dynamic data = await jsonplaceholderapi.getData();

                setState(() {
                  jsonPlaceholderData = data;
                });
              },
              child: Text("Get Data"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: jsonPlaceholderData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text("${jsonPlaceholderData[index]['id']}"),
                    title: Text(jsonPlaceholderData[index]['title']),
                    trailing: IconButton(
                      onPressed: () async {
                        await OfflineService.instance.insertRawData(
                          jsonPlaceholderData[index],
                        );
                      },
                      icon: Icon(Icons.save),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StoreData()),
                );
              },
              child: Text("View Store Data"),
            ),
          ],
        ),
      ),
    );
  }
}
