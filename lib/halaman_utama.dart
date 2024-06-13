import 'package:event_app/tab_daftar_mahasiswa.dart';
import 'package:event_app/tab_event.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({Key? key}) : super(key: key);

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            TabEvent(),
            TabDaftarMahasiswa(),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Warna latar belakang tab bar
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
                    text: "Daftar mahasiswa",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
