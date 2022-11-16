import 'package:flutter/material.dart';
import 'package:mobile/presentation/auths/auth_page.dart';

class AppRouter {

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const AuthPage());
      case '/second':
        return MaterialPageRoute(
            builder: (_) => const AuthPage());
      case '/third':
        return MaterialPageRoute(
            builder: (_) => const AuthPage());
      default:
        return null;
    }
  }

}
