import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/wishlist_bloc.dart';

void main(List<String> args) {
  runApp(WishlistPage());
}

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Let's order fresh items for you
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Wishlist",
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // list view of wishlist
          BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state) {
              if (state is WishlistInitial) {
                return const Text("LOADING MAZ");
              } else if (state is WishlistLoaded) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.data.results!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Card(
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Text("${state.data.results![index].name}"),
                                Text(
                                    "Rp.${state.data.results![index].harga},00"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
