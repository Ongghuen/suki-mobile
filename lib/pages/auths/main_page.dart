import 'package:flutter/material.dart';
import 'package:mobile/data/hive/user.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mobile/pages/screens/home_page.dart';
import 'package:mobile/pages/screens/login_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var userBox = Hive.box("user");
  UserHiveDatabase udb = UserHiveDatabase();

  @override
  Widget build(BuildContext context) {
    udb.loadDB();
    return Scaffold(
      body: udb.user == null ? const LoginPage() : const HomePage(),
    );
  }
}
