import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // controllers
  final _usernameController = TextEditingController();
  final _noTelpController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _hidePass = true;

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _noTelpController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: IconButton(icon: const Icon(Icons.arrow_back), color:
            Colors.black, onPressed: () => Navigator.pop(context),), backgroundColor:
          const Color(0xFFF8F9FA),elevation: 0),
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Icon(
                  //   Icons.android_outlined,
                  //   size: 100,
                  // ),
                  // text di atas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Buat Akunmu!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ],
                  ),

                  // sized box cuma buat margin, idk any alternatives
                  const SizedBox(
                    height: 20,
                  ),

                  // ini input text atau form
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Nama Anda',
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // ini input text atau form
                  TextField(
                    controller: _noTelpController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Nomer Telepon',
                    ),
                  ),
                  //
                  const SizedBox(
                    height: 10,
                  ),
                  //

                  // ini input text atau form
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),

                  //
                  const SizedBox(
                    height: 10,
                  ),
                  //

                  TextField(
                    obscureText: _hidePass,
                    controller: _passController,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Sandi',
                        suffixIcon: IconButton(
                          icon: Icon(_hidePass
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _hidePass = !_hidePass;
                            });
                          },
                        )),
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
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: const Color(0xFF151515)),
                        child: const Text("BUAT AKUN",
                            style: TextStyle(fontSize: 18)),
                        onPressed: () async {},
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
                        "< Sudah memiliki akun? ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF979797)),
                      ),

                      //
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Login",
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
