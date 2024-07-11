import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:event_app/halaman_login.dart';
import 'package:get/get.dart';

class HalamanRegister extends StatefulWidget {
  const HalamanRegister({super.key});

  @override
  State<HalamanRegister> createState() => _HalamanRegisterState();
}

class _HalamanRegisterState extends State<HalamanRegister> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  
  Future<void> _registerWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _pass.text,
      );
      // Navigasi kembali ke halaman login setelah registrasi berhasil
      Get.off(()=>HalamanLogin()); // Kembali ke halaman sebelumnya
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showErrorDialog('Password yang diberikan terlalu lemah.');
      } else if (e.code == 'email-already-in-use') {
        _showErrorDialog('Akun sudah ada untuk email tersebut.');
      } else {
        _showErrorDialog('Registrasi gagal. Silakan coba lagi.');
      }
    } catch (e) {
      _showErrorDialog('Terjadi kesalahan. Silakan coba lagi.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
                    hintText: "Username",
                    icon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _pass,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    icon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _registerWithEmailAndPassword,
                  child: const Text("Daftar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
