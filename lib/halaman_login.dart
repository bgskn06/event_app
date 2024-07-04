import 'package:event_app/halaman_register.dart';
import 'package:event_app/halaman_utama.dart';
import 'package:event_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HalamanLogin extends StatefulWidget {
  const HalamanLogin({super.key});

  @override
  State<HalamanLogin> createState() => _HalamanLoginState();
}

class _HalamanLoginState extends State<HalamanLogin> {
 bool isChecked = false;
 bool isLogged = false;

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  late Box box1;
  late Box box2;

  @override
  void initState() {
    super.initState();
    createBox();
  }
  void createBox() async{
    box1 = await Hive.openBox('logindata');
    box2 = await Hive.openBox('ingatsaya');
    getdata();
  }

  void getdata() async{
    if(box2.get('email')!=null){
      email.text = box2.get('email');
    }
    if(box2.get('pass')!=null){
      pass.text = box2.get('pass');
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('aset_media/gambar/logo_login.png'),
      ),
    );

    final username = TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: pass,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            login();
          },
          color: Colors.blueAccent,
          child: const Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
    final ingatSaya = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Ingat Saya",style: TextStyle(color: Colors.black54),),
      Checkbox(
        value: isChecked,
        onChanged: (value){
          isChecked = !isChecked;
            setState(() {
              
            });
        },
      ),
    ]);

    final daftarAkun = TextButton(
      child: const Text(
        'Belum punya akun? daftar',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Get.to(()=>HalamanRegister());
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            const SizedBox(height: 48.0),
            username,
            const SizedBox(height: 8.0),
            password,
            const SizedBox(height: 24.0),
            loginButton,
            ingatSaya,
            daftarAkun
          ],
        ),
      ),
    );
  }

  Future login() async{
    String? storedEmail = await box1.get("email");
    String? storedpass = await box1.get("pass");
    isLogged = true;

    if (email.value.text == storedEmail && pass.value.text == storedpass) {
      if(isChecked){
        box2.put('email', email.text);
        box2.put('pass', pass.text);
      }
      box1.put('isLogged', true);
      Get.snackbar('Success', 'Berhasil Login');
      Get.to(()=>SplashScreen());
    } else {
      Get.snackbar('Error', 'Email atau password salah');
    }
    
  }
}
