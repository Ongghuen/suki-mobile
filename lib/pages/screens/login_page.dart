import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:mobile/data/api/call.dart';
import 'package:mobile/data/hive/user.dart';
import 'package:mobile/models/logged_user.dart';
import 'package:mobile/pages/components/snackbar.dart';
import 'package:mobile/pages/screens/register_page.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // hive buat nyimpen sesi
  final userBox = Hive.box("user");
  UserHiveDatabase udb = UserHiveDatabase();

  // text controllers
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  var testText = "hai";

  // fungsi buat login
  Future<bool> login() async {
    String apiUrl = "/api/api/login/login.php";
    var data = {
      "username": _emailController.text,
      "password": _passController.text,
    };

    var res = await CallApi().postData(data, apiUrl);
    var body = json.decode(res.body);

    if (body["msg"].contains('masuk')) {
      LoggedUser user = LoggedUser.fromJson(body);

      udb.user = user.username;
      udb.updateDB();

      return true;
    }
    showSnackbar(context, "what the hell", "lol");
    return false;
  }

  @override
  void dispose() {
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
                //
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
                      if (await login()) {
                        Navigator.pushReplacement(
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
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage())),
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
