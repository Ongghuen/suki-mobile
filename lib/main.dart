import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mobile/presentation/router/app_router.dart';

void main(List<String> args) async {
  await Hive.initFlutter();
  await Hive.openBox("user");

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // check di AppRouter() "/" -- itu initial routenya kemana
    onGenerateRoute: AppRouter().onGenerateRoute,
  ));
}
