import 'package:event_app/halaman_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({Key? key}) : super(key: key);

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  final List<Map<String, String>> eventDataList = [
    {
      'judul': 'Konser Musik',
      'deskripsi': 'deskripsi 1',
      'tanggal': '1 July 2024',
      'jam': '18:00 PM',
      'kategori': 'Musik',
    },
    {
      'judul': 'Pameran Seni',
      'deskripsi': 'deskripsi 1',
      'tanggal': '3 July 2024',
      'jam': '10:00 AM',
      'kategori': 'Seni',
    },
    {
      'judul': 'Workshop Fotografi',
      'deskripsi': 'deskripsi 1',
      'tanggal': '5 July 2024',
      'jam': '09:00 AM',
      'kategori': 'Workshop',
    },
    {
      'judul': 'Seminar Teknologi',
      'deskripsi': 'deskripsi 1',
      'tanggal': '10 July 2024',
      'jam': '13:00 PM',
      'kategori': 'Teknologi',
    },
    {
      'judul': 'Festival Makanan',
      'deskripsi': 'deskripsi 1',
      'tanggal': '12 July 2024',
      'jam': '11:00 AM',
      'kategori': 'Makanan',
    },
    {
      'judul': 'Lomba Lari',
      'deskripsi': 'deskripsi 1',
      'tanggal': '15 July 2024',
      'jam': '06:00 AM',
      'kategori': 'Olahraga',
    },
    {
      'judul': 'Pemutaran Film',
      'deskripsi': 'deskripsi 1',
      'tanggal': '18 July 2024',
      'jam': '20:00 PM',
      'kategori': 'Film',
    },
    {
      'judul': 'Bazar Buku',
      'deskripsi': 'deskripsi 1',
      'tanggal': '20 July 2024',
      'jam': '09:00 AM',
      'kategori': 'Buku',
    },
    {
      'judul': 'Konferensi Pendidikan',
      'deskripsi': 'deskripsi 1',
      'tanggal': '22 July 2024',
      'jam': '10:00 AM',
      'kategori': 'Pendidikan',
    },
    {
      'judul': 'Pentas Tari',
      'deskripsi': 'deskripsi 1',
      'tanggal': '25 July 2024',
      'jam': '19:00 PM',
      'kategori': 'Tari',
    },
  ];

  final List<Map<String, String>> registeredEvents = [];
  final List<String> categories = ['Semua', 'Musik', 'Seni', 'Workshop', 'Teknologi', 'Makanan', 'Olahraga', 'Film', 'Buku', 'Pendidikan', 'Tari'];
  String selectedCategory = 'Semua';
  DateTime? selectedDate;

  void showEventDetail(BuildContext context, Map<String, String> eventData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(eventData['judul'] ?? 'Judul tidak tersedia'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Deskripsi: ${eventData['deskripsi'] ?? 'Deskripsi tidak tersedia'}'),
              SizedBox(height: 8),
              Text('Tanggal: ${eventData['tanggal'] ?? 'Tanggal tidak tersedia'}'),
              SizedBox(height: 8),
              Text('Jam: ${eventData['jam'] ?? 'Jam tidak tersedia'}'),
              SizedBox(height: 8),
              Text('Kategori: ${eventData['kategori'] ?? 'Kategori tidak tersedia'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  registeredEvents.add(eventData);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Terima kasih telah mendaftar!'),
                ));
              },
              child: Text('Daftar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  void showRegisteredEventDetail(BuildContext context, Map<String, String> eventData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(eventData['judul'] ?? 'Judul tidak tersedia'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Deskripsi: ${eventData['deskripsi'] ?? 'Deskripsi tidak tersedia'}'),
              SizedBox(height: 8),
              Text('Tanggal: ${eventData['tanggal'] ?? 'Tanggal tidak tersedia'}'),
              SizedBox(height: 8),
              Text('Jam: ${eventData['jam'] ?? 'Jam tidak tersedia'}'),
              SizedBox(height: 8),
              Text('Kategori: ${eventData['kategori'] ?? 'Kategori tidak tersedia'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  registeredEvents.remove(eventData);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Pendaftaran dibatalkan!'),
                ));
              },
              child: Text('Batal Daftar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => HalamanLogin());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            buildEventList(eventDataList, showEventDetail),
            buildEventList(registeredEvents, showRegisteredEventDetail),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Akun Saya', style: TextStyle(fontSize: 24)),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _logout,
                    child: Text('Logout'),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.calendar_month),
                    text: "Event",
                  ),
                  Tab(
                    icon: Icon(Icons.list),
                    text: "Event Saya",
                  ),
                  Tab(
                    icon: Icon(Icons.person),
                    text: "Akun",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEventList(List<Map<String, String>> events, Function(BuildContext, Map<String, String>) onTap) {
    List<Map<String, String>> filteredEvents = events.where((event) {
      bool matchesCategory = selectedCategory == 'Semua' || event['kategori'] == selectedCategory;
      bool matchesDate = selectedDate == null || event['tanggal'] == '${selectedDate!.day} ${_getMonthName(selectedDate!.month)} ${selectedDate!.year}';
      return matchesCategory && matchesDate;
    }).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                    items: categories.map<DropdownMenuItem<String>>((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.date_range_outlined),
                  onPressed: () async {
                    final selected = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selected != null) {
                      setState(() {
                        selectedDate = selected;
                      });
                    }
                  },
                  tooltip: 'Pilih Tanggal',
                ),
                if (selectedDate != null)
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        selectedDate = null;
                      });
                    },
                    tooltip: 'Batal Pilihan Tanggal',
                  ),
                FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Daftar Event",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ...filteredEvents.map((eventData) => GestureDetector(
              onTap: () {
                onTap(context, eventData);
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventData['judul'] ?? 'Judul tidak tersedia',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        eventData['tanggal'] ?? 'Tanggal tidak tersedia',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 8),
                      Text(
                        eventData['jam'] ?? 'Jam tidak tersedia',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 8),
                      Text(
                        eventData['kategori'] ?? 'Kategori tidak tersedia',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}
