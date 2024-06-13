import 'package:flutter/material.dart';

class TabDaftarMahasiswa extends StatefulWidget {
  @override
  _TabDaftarMahasiswaState createState() => _TabDaftarMahasiswaState();
}

class _TabDaftarMahasiswaState extends State<TabDaftarMahasiswa> {
  List<bool> isNotificationActiveList = []; // List of booleans to track notification status for each event

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> events = [
      {"title": "My Event 1", "description": "Deskripsi my event 1"},
      {"title": "My Event 2", "description": "Deskripsi my event 2"},
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "My Event",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: events.length,
              itemBuilder: (BuildContext context, int index) {
                // Initialize isNotificationActiveList with false for each event if it's not already initialized
                if (isNotificationActiveList.length <= index) {
                  isNotificationActiveList.add(false);
                }
                return _buildMyEventCard(events[index], index);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMyEventCard(Map<String, dynamic> eventData, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventData['title'],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    eventData['description'],
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  // Ketika lonceng diklik, ubah statusnya
                  isNotificationActiveList[index] = !isNotificationActiveList[index];
                });
              },
              child: Icon(
                isNotificationActiveList[index] ? Icons.notifications_active : Icons.notifications_off,
                color: isNotificationActiveList[index] ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
