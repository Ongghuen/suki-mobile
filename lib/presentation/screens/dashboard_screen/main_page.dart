import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/product/product_bloc.dart';
import 'package:mobile/logic/data/bloc/wishlist/wishlist_bloc.dart';
import 'package:mobile/presentation/screens/dashboard_screen/cart_page.dart';
import 'package:mobile/presentation/screens/dashboard_screen/home_page.dart';
import 'package:mobile/presentation/screens/dashboard_screen/profile_page.dart';
import 'package:mobile/presentation/screens/dashboard_screen/search_page.dart';
import 'package:mobile/presentation/screens/dashboard_screen/wishlist_page.dart';

void main(List<String> args) {
  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  List<Widget> pageList = [
    const HomePage(),
    const WishlistPage(),
    const SearchPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    final state = context.read<AuthBloc>().state;
    if (state is AuthLoaded) {
      // get products
      context.read<ProductBloc>().add(GetProductList());
      // get wishlists
      context
          .read<WishlistBloc>()
          .add(GetWishlistUserList(state.userModel.token.toString()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: pageList.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: GNav(
                onTabChange: (value) {
                  setState(() {
                    _selectedIndex = value;
                  });
                },
                gap: 2,
                color: Colors.black,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.black,
                duration: Duration(milliseconds: 200),
                iconSize: 26,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                tabs: [
                  GButton(
                    icon: Icons.home_outlined,
                  ),
                  GButton(
                    icon: Icons.favorite_outline,
                  ),
                  GButton(
                    icon: Icons.search_outlined,
                  ),
                  GButton(
                    icon: Icons.shopping_cart_outlined,
                  ),
                  GButton(
                    icon: Icons.person_outline,
                  )
                ]),
          ),
        ));
  }
}
