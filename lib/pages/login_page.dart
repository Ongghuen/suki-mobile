import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/logged_user.dart';
import 'home_page.dart';
import '../process/prefs.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // controllers
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  var testText = "hai";

  Future<bool> login() async {
    var url = Uri.http("192.168.8.112", "/api/api/login/login.php");
    var response = await http.post(url, body: {
      "username": _emailController.text,
      "password": _passController.text,
    });
    LoggedUser data = LoggedUser.fromJson(json.decode(response.body));
    String username = data.username;
    print(username);
    await setPrefs("username", username);
    setState(() {
      testText = data.msg;
    });
    if (data.msg.contains('masuk')) {
      return true;
    }
    return false;
  }

  // Future _signIn() async {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: _emailController.text.trim(),
  //       password: _passController.text.trim());
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Icon(
                //   Icons.android_outlined,
                //   size: 100,
                // ),
                // text di atas
                Text(
                  testText,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 36),
                ),

                // sized box cuma buat margin, idk any alternatives
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Selamat datang, ngabs!",
                  style: TextStyle(fontSize: 20),
                ),

                //
                const SizedBox(
                  height: 50,
                ),

                // ini input text atau form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          filled: true),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                // ini input text atau form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: _passController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          filled: true),
                    ),
                  ),
                ),

                //
                const SizedBox(
                  height: 10,
                ),
                //

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: () async {
                      var isLoggedIn = login();
                      if (await isLoggedIn) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.yellow[500],
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Belum register? ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      child: const Text(
                        "Register sekarang",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
