import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/presentation/router/app_router.dart';

void main(List<String> args) async {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (_) => AuthBloc(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      // check di AppRouter() "/" -- itu initial routenya kemana
      onGenerateRoute: AppRouter().onGenerateRoute,
    ),
  ));
}
