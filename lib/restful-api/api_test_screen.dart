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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Api Test")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              apiTestServices.getAllData();
              setState(() {});
            },
            child: Text("Get Data"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: datas.length,
              itemBuilder: (context, index) {
                TestApiResponse data = datas[index];
                return ListTile(leading: Text(data.id), title: Text(data.name));
              },
            ),
          ),
        ],
      ),
    );
  }
}
