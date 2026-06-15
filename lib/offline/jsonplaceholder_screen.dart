import 'package:broadway_bmi_cal/offline/jsonplaceholderapi.dart';
import 'package:flutter/material.dart';

class JsonplaceholderScreen extends StatefulWidget {
  const JsonplaceholderScreen({super.key});

  @override
  State<JsonplaceholderScreen> createState() => _JsonplaceholderScreenState();
}

class _JsonplaceholderScreenState extends State<JsonplaceholderScreen> {
  Jsonplaceholderapi jsonplaceholderapi = Jsonplaceholderapi();
  List<Map<String, dynamic>> jsonPlaceholderData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              List<Map<String, dynamic>> data = await jsonplaceholderapi
                  .getData();
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
                Map<String, dynamic> myData = jsonPlaceholderData[index];
                return ListTile(
                  leading: Text("${myData['id']}"),
                  title: Text(myData['title']),
                  subtitle: Text(myData['body']),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          color: Colors.black,
                          onPressed: () {
                            // addUpdateData(myData);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          color: Colors.red,
                          onPressed: () {
                            // OfflineService.instance.delete(myData.id);
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
        ],
      ),
    );
  }
}
