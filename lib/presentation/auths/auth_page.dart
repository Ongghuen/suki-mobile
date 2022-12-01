import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mobile/presentation/screens/login_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: udb.user == null ? const LoginPage() : const HomePage(),
      body: const LoginPage()
    );
  }
}
