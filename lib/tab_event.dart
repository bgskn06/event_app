import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TabEvent extends StatefulWidget {
  @override
  _TabEventState createState() => _TabEventState();
}

class _TabEventState extends State<TabEvent> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  Box? _daftarEvent;

  @override
  void initState() {
    super.initState();
    Hive.openBox("daftar_event").then((_box) {
      setState(() {
        _daftarEvent = _box;
      });
    }).catchError((error) {
      // Handle error if Hive box fails to open
      print("Error opening Hive box: $error");
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _timeController.dispose();
    _dateController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Cari Berdasarkan Kategori',
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.date_range_outlined),
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      _dateController.text =
                          "${selectedDate.toLocal()}".split(' ')[0];
                    }
                  },
                  tooltip: 'Select Date',
                ),
                FloatingActionButton(
                  onPressed: () => _displayTextInputDialog(context),
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
            _daftarEvent == null
                ? Center(child: CircularProgressIndicator())
                : ValueListenableBuilder(
                    valueListenable: _daftarEvent!.listenable(),
                    builder: (context, box, widget) {
                      final eventKeys = box.keys.toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: eventKeys.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> event = _daftarEvent!.get(eventKeys[index]);
                          return _buildEventCard(context, event);
                        },
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, Map<String, dynamic> eventData) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventData['judul'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              eventData['tanggal'],
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              eventData['jam'],
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              eventData['kategori'],
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tambah Event"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Judul',
                  ),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                  ),
                ),
                TextField(
                  controller: _timeController,
                  decoration: InputDecoration(
                    labelText: 'Jam',
                  ),
                  keyboardType: TextInputType.datetime,
                ),
                TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Tanggal',
                  ),
                  keyboardType: TextInputType.datetime,
                ),
                TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    labelText: 'Kategori',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Ubah warna tombol Simpan
                foregroundColor: Colors.white, // Ubah warna tulisan tombol
              ),
              child: Text("Simpan"),
              onPressed: () {
                if (_daftarEvent != null) {
                  _daftarEvent!.add({
                    "judul": _titleController.text,
                    "deskripsi": _descriptionController.text,
                    "jam": _timeController.text,
                    "tanggal": _dateController.text,
                    "kategori": _categoryController.text,
                    "timestamp": DateTime.now().toIso8601String(),
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Ubah warna tombol Batal
                foregroundColor: Colors.white, // Ubah warna tulisan tombol
              ),
              child: Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void main() async {
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Event Manager")),
        body: TabEvent(),
      ),
    );
  }
}
