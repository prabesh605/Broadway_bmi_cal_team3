import 'package:flutter/material.dart';

class ExtraInfoCard extends StatelessWidget {
  const ExtraInfoCard({
    super.key,
    required this.icon,
    required this.data,
    required this.title,
  });

  final Icon icon;
  final String data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xff172031),
      ),
      height: 115,
      width: 180,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          SizedBox(height: 6),
          Text(data, style: TextStyle(fontSize: 22, color: Colors.white)),
          SizedBox(height: 4),

          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Color.fromARGB(255, 141, 149, 165),
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
