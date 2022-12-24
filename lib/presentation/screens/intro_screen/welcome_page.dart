import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobile/presentation/screens/auth_screen/auth_page.dart';
import 'package:mobile/presentation/screens/auth_screen/login_page.dart';
import 'package:mobile/presentation/screens/intro_screen/intro_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);



  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var box = Hive.box('utils');

  @override
  void initState() {
    // TODO: implement initState
    box.get("intro") ?? box.put("intro", false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return box.get("intro") ? AuthPage() : IntroPage();
  }
}
