import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.android_outlined,
                size: 100,
              ),
              // text di atas
              Text(
                "Ongghuen??!",
                style: TextStyle(
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
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Email'),
                    ),
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
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Password'),
                    ),
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
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.yellow[500],
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                      child: Text(
                    "Sign In",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
                ),
              ),
        
              const SizedBox(
                height: 20,
              ),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Belum register? ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Register sekarang",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
