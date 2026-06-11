import 'package:broadway_bmi_cal/restful-api/api_test_model.dart';
import 'package:broadway_bmi_cal/restful-api/api_test_services.dart';
import 'package:broadway_bmi_cal/weather/api_service.dart';
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
    TextEditingController nameController = TextEditingController(
      text: apiData?.name ?? "",
    );
    TextEditingController yearController = TextEditingController(
      text: "${apiData?.data?.year ?? 0}",
    );
    TextEditingController priceController = TextEditingController(
      text: "${apiData?.data?.price ?? 0}",
    );
    TextEditingController cpuModelController = TextEditingController(
      text: apiData?.data?.cpuModel ?? "",
    );
    TextEditingController hardDiskSizeController = TextEditingController(
      text: apiData?.data?.hardDiskSize ?? "",
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
            apiData == null ? Text("Add Data") : Text("Update Data"),
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
              controller: priceController,
              decoration: InputDecoration(
                label: Text("Price"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: cpuModelController,
              decoration: InputDecoration(
                label: Text("Cpu Model"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: hardDiskSizeController,
              decoration: InputDecoration(
                label: Text("Hard Disk Size"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (apiData == null) {
                  bool result = await apiTestServices.addData(
                    nameController.text,
                    int.parse(yearController.text),

                    double.parse(priceController.text),
                    cpuModelController.text,
                    hardDiskSizeController.text,
                  );
                  if (result) {
                    Navigator.pop(context);
                  }
                } else {
                  bool result = await apiTestServices.updateDataApi(
                    apiData.id,
                    nameController.text,
                    int.parse(yearController.text),

                    double.parse(priceController.text),
                    cpuModelController.text,
                    hardDiskSizeController.text,
                  );
                  if (result) {
                    Navigator.pop(context);
                  }
                }
                //api call
              },
              child: apiData == null ? Text("Save") : Text("Update"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Api Test")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          updateData(null);
        },
        child: Icon(Icons.add),
      ),
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
