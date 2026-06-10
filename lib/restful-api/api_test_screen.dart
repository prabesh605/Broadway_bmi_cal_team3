import 'package:broadway_bmi_cal/restful-api/api_test_model.dart';
import 'package:broadway_bmi_cal/restful-api/api_test_services.dart';
import 'package:flutter/material.dart';

class ApiTestScreen extends StatefulWidget {
  const ApiTestScreen({super.key});

  @override
  State<ApiTestScreen> createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  ApiTestServices apiTestServices = ApiTestServices();
  List<TestApiResponse> datas = [];

  void updateData(TestApiResponse? apiData) {
    TextEditingController controller = TextEditingController(
      text: apiData?.name ?? "",
    );
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        margin: EdgeInsets.all(12),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Edit Data"),
            SizedBox(height: 20),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            ElevatedButton(onPressed: () {

              //api call 
            }, child: Text("Save")),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Api Test")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              var apiData = await apiTestServices.getAllData();
              setState(() {
                datas = apiData;
              });
            },
            child: Text("Get Data"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: datas.length,
              itemBuilder: (context, index) {
                TestApiResponse data = datas[index];
                return ListTile(
                  // leading: Text(data.id),
                  leading: Text("${index + 1}"),
                  title: Text(data.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text(data.id), Text(data.data?.cpuModel ?? "")],
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            updateData(data);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () async {
                            await apiTestServices.deleteData(data.id);
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
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
