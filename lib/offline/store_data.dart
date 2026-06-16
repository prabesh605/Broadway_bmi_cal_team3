import 'package:broadway_bmi_cal/offline/offline_service.dart';
import 'package:flutter/material.dart';

class StoreData extends StatefulWidget {
  const StoreData({super.key});

  @override
  State<StoreData> createState() => _StoreDataState();
}

class _StoreDataState extends State<StoreData> {
  List rawData = [];
  Future<void> getStoreData() async {
    List data = await OfflineService.instance.getRawData();
    setState(() {
      rawData = data;
    });
  }

  @override
  void initState() {
    getStoreData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Store Data"),

            Expanded(
              child: ListView.builder(
                itemCount: rawData.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text("${rawData[index]['title']}"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
