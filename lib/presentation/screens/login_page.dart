import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/api/call.dart';
import 'package:mobile/logic/data/hive/user.dart';
import 'package:mobile/presentation/screens/home_page.dart';
import 'package:mobile/presentation/screens/register_page.dart';
import 'package:mobile/presentation/utils/components/snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // hive buat nyimpen sesi
  UserHiveDatabase udb = UserHiveDatabase();

  // text controllers
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  // fungsi buat login
  Future<bool> login() async {
    try {
      String apiUrl = "/api/login";
      // var data = {
      //   "username": _emailController.text,
      //   "password": _passController.text,
      // };
      //
      var res = await CallApi().getData(apiUrl);
      print(res);
      var body = json.decode(res.body);
      print(body);

      if (body["msg"].contains('success')) {
        // LoggedUser user = LoggedUser.fromJson(body);
        //
        // udb.user = user.username;
        // udb.updateDB();

        return true;
      }
    } catch (ex) {
      print("Login Error: $ex");
    }
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
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text("Selamat Datang Kembali!",
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20))),
                  ),

                  // sized box cuma buat margin, idk any alternatives
                  const SizedBox(
                    height: 50,
                  ),

                  // ini input text atau form
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Username',
                        fillColor: Color(0xFFF8F9FA),
                        filled: true),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // ini input text atau form
                  TextField(
                    controller: _passController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.password_outlined),
                        fillColor: Color(0xFFF8F9FA),
                        filled: true),
                  ),

                  //
                  const SizedBox(
                    height: 30,
                  ),

                  //
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: GestureDetector(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (await login()) {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                            showSnackbar(context, "INFO: apinya blom ya :)");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: const Color(0xFF151515)),
                        child:
                            const Text("MASUK", style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "< Belum mempunyai akun? ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF979797)),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage())),
                        child: const Text(
                          "Daftar",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
