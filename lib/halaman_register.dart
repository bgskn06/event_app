import 'package:event_app/halaman_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HalamanRegister extends StatefulWidget {
  const HalamanRegister({super.key});

  @override
  State<HalamanRegister> createState() => _HalamanRegisterState();
}

class _HalamanRegisterState extends State<HalamanRegister> {

  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _nim = TextEditingController();
  TextEditingController _noHp = TextEditingController();
  TextEditingController _pass = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Buat Akun",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                      hintText: "Username", icon: Icon(Icons.person),),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                      hintText: "Nama Lengkap", icon: Icon(Icons.badge)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nim,
                  decoration: InputDecoration(
                      hintText: "NIM", icon: Icon(Icons.school)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _noHp,
                  decoration: InputDecoration(
                      hintText: "No. Hp", icon: Icon(Icons.phone)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _pass,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password", icon: Icon(Icons.lock)),
                ),
                // const SizedBox(height: 20),
                // TextFormField(
                //   obscureText: true,
                //   decoration: InputDecoration(
                //       hintText: "Konfirmasi Password", icon: Icon(Icons.lock)),
                // ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    registration();
                  },
                  child: const Text("Daftar")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future registration() async{
    
  }
}