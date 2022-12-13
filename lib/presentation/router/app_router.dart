import 'package:flutter/material.dart';
import 'package:mobile/presentation/auths/auth_page.dart';
import 'package:mobile/presentation/screens/dashboard_screen/cart_page.dart';
import 'package:mobile/presentation/screens/dashboard_screen/home_page.dart';
import 'package:mobile/presentation/screens/dashboard_screen/main_page.dart';
import 'package:mobile/presentation/screens/dashboard_screen/profile_page.dart';
import 'package:mobile/presentation/screens/dashboard_screen/search_page.dart';
import 'package:mobile/presentation/screens/dashboard_screen/wishlist_page.dart';
import 'package:mobile/presentation/screens/login_page.dart';
import 'package:mobile/presentation/screens/profile_detail.dart';
import 'package:mobile/presentation/screens/register_page.dart';
import 'package:mobile/presentation/screens/transaction_konfirmasi_checkout_page.dart';
import 'package:mobile/presentation/screens/transaction_menunggu_pembayaran_page.dart';
import 'package:mobile/presentation/screens/transaction_page.dart';

class AppRouter {
  // INI ADALAH ROUTERNYAAAAAAAAAAAAAAAAAAAAAA
  // HAHAHAHAHAHHAHAHAHAHAHAHAHAHAHAHAHHAHHAHA
  // APA APAAN DEADLINE 4 MINGGU

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const AuthPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/main':
        return MaterialPageRoute(builder: (_) => const MainPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case '/wishlist':
        return MaterialPageRoute(builder: (_) => const WishlistPage());
      case '/cart':
        return MaterialPageRoute(builder: (_) => const CartPage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case '/detail-profile':
        return MaterialPageRoute(builder: (_) => const ProfileDetailPage());
      case '/transaction':
        return MaterialPageRoute(builder: (_) => const TransactionPage());
      case '/transaction-confirm':
        return MaterialPageRoute(builder: (_) => const TransactionKonfirmasiCheckoutPage());
      case '/menunggu-pembayaran':
        return MaterialPageRoute(
            builder: (_) => const TransactionMenungguPembayaranPage());
      default:
        return null;
    }
  }
}
