import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/api/call.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/presentation/utils/components/snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

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
                    child:
                        BlocConsumer<AuthBloc, AuthState>(listener: (_, state) {
                      if (state is AuthLoaded) {
                        Navigator.of(context).pushReplacementNamed('/main');
                      }
                      if (state is AuthError) {
                        showSnackbar(context, state.msg);
                      }
                    }, builder: (_, state) {
                      return Text("Selamat Datang Kembali!",
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)));
                    }),
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
                      child: Builder(builder: (context) {
                        return ElevatedButton(
                          onPressed: () async {
                            var data = {
                              "username": _emailController.text.trim(),
                              "password": _passController.text.trim(),
                            };

                            context.read<AuthBloc>().add(UserAuthLogin(data));
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              backgroundColor: const Color(0xFF151515)),
                          child: BlocBuilder<AuthBloc, AuthState>(
                              builder: (_, state) {
                            if (state is AuthLoading) {
                              return const CircularProgressIndicator(
                                backgroundColor: Colors.black,
                                color: Colors.white,
                              );
                            }
                            return const Text("MASUK",
                                style: TextStyle(fontSize: 16));
                          }),
                        );
                      }),
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
                        onTap: () =>
                            Navigator.of(context).pushNamed('/register'),
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
