import 'package:flutter/material.dart';
import 'package:ongghuen/pages/login_page.dart';
import 'package:ongghuen/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  bool _showLoginPage = true;

  void _switchPage() {
    setState(() {
      _showLoginPage = !_showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showLoginPage
        ? LoginPage(showRegisterPage: _switchPage)
        : RegisterPage(showLoginPage: _switchPage);
  }
}
