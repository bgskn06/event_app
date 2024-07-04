import 'package:event_app/halaman_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HalamanRegister extends StatefulWidget {
  const HalamanRegister({super.key});

  @override
  State<HalamanRegister> createState() => _HalamanRegisterState();
}

class _HalamanRegisterState extends State<HalamanRegister> {
  late Box box1;

  void initState() {
    super.initState();
    createBox();
  }
  void createBox() async{
    box1 = await Hive.openBox('logindata');
    setState(() {});
  }

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
    if (_email.text.isEmpty || _name.text.isEmpty || _nim.text.isEmpty || _noHp.text.isEmpty || _pass.text.isEmpty) {
    Get.snackbar('Error', 'Semua field harus diisi');
    return;
  }
    box1.put('email', _email.value.text);
    box1.put('name', _name.text);
    box1.put('nim', _nim.text);
    box1.put('noHp', _noHp.text);
    box1.put('pass', _pass.text);
    print(_email.text);
    print(_name.text);
    print(_nim.text);
    print(_noHp.text);
    print(_pass.text);
    Get.to(()=>HalamanLogin());
  }
}