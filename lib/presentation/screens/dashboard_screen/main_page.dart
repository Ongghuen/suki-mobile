import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/detail_transaction/detail_transaction_bloc.dart';
import 'package:mobile/logic/data/bloc/product/product_bloc.dart';
import 'package:mobile/logic/data/bloc/transaction/transaction_bloc.dart';
import 'package:mobile/logic/data/bloc/wishlist/wishlist_bloc.dart';
import 'package:mobile/presentation/screens/auth_screen/auth_page.dart';
import 'package:mobile/presentation/screens/dashboard_screen/cart_page.dart';
import 'package:mobile/presentation/screens/dashboard_screen/home_page.dart';
import 'package:mobile/presentation/screens/dashboard_screen/profile_page.dart';
import 'package:mobile/presentation/screens/dashboard_screen/search_page.dart';
import 'package:mobile/presentation/screens/dashboard_screen/wishlist_page.dart';

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

  void initStartBlocs() {
    final state = context.read<AuthBloc>().state;
    if (state is AuthLoaded) {
      context.read<AuthBloc>().add(UserAuthCheckToken(state.userModel.token));
      // get products
      context.read<ProductBloc>().add(GetProductList());
      // get wishlists
      context
          .read<WishlistBloc>()
          .add(GetWishlistUserList(state.userModel.token.toString()));
      context
          .read<TransactionBloc>()
          .add(GetAllTransactionLists(state.userModel.token.toString()));
      context.read<DetailTransactionBloc>().add(
          GetOngoingDetailTransactionList(state.userModel.token.toString()));
    }
  }

  @override
  void initState() {
    initStartBlocs();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLogout) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (BuildContext context) => AuthPage()),
                (route) => false);
          }
        },
        child: Scaffold(
            body: pageList.elementAt(_selectedIndex),
            bottomNavigationBar: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal:
                    size.width * 0.02),
                child: GNav(
                    onTabChange: (value) {
                      setState(() {
                        value != 5 ? _selectedIndex = value : initStartBlocs();
                      });
                    },
                    color: Colors.black,
                    activeColor: Colors.white,
                    tabBackgroundColor: Colors.black,
                    duration: const Duration(milliseconds: 200),
                    iconSize: size.width * 0.07 - 2,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    tabs: const [
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
                      ),
                    ]),
              ),
            ), ),
      ),
    );
  }
}
