import 'package:flutter/material.dart';

class DetailEvent extends StatelessWidget {
  final Map<String, dynamic> eventData;

  DetailEvent(this.eventData);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            eventData['judul'],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "Tanggal: ${eventData['tanggal']}",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            "Jam: ${eventData['jam']}",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            "Deskripsi:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            eventData['deskripsi'],
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}