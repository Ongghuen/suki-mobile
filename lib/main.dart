import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mobile/pages/auths/main_page.dart';
import 'package:mobile/test_page.dart';

void main(List<String> args) async {
  await Hive.initFlutter();
  await Hive.openBox("user");

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainPage(),
  ));
}
