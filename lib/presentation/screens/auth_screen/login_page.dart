import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/presentation/utils/components/snackbar.dart';
import 'package:mobile/presentation/utils/default.dart';

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
    Size size = MediaQuery.of(context).size;
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
                    padding: EdgeInsets.symmetric(horizontal: size
                        .width * 0.01),
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
                              textStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold, fontSize:
                              getAdaptiveTextSize(context, 20))), textAlign:
                        TextAlign.center,);
                    }),
                  ),

                  // sized box cuma buat margin, idk any alternatives
                  const SizedBox(
                    height: 50,
                  ),

                  // ini input text atau form
                  TextField(
                    style: GoogleFonts.montserrat(),
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        prefixIcon: Icon(Icons.person_outline),
                        hintText: 'Username',
                        fillColor: Color(0xFFF8F9FA),
                        filled: true),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // ini input text atau form
                  TextField(
                    style: GoogleFonts.montserrat(),
                    controller: _passController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_outlined),
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
                            return Text("MASUK",
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,
                                    fontSize:
                                getAdaptiveTextSize(context, 16)));
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
                      Text(
                        "Belum mempunyai akun? ",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF979797)),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.of(context).pushNamed('/register'),
                        child: Text(
                          "Daftar",
                          style: GoogleFonts.montserrat(
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
