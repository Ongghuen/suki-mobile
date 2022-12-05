import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/product/product_bloc.dart';
import 'package:mobile/logic/data/bloc/wishlist/wishlist_bloc.dart';
import 'package:mobile/presentation/utils/components/snackbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // instance bloc
  // inget, kalo make atau buat baru atau provide
  // baru ke provider instansinya pasti bakalan beda
  // so... gada sih cuma ngingetin
  // final ListingBloc _listingBloc = ListingBloc();

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF212529),
        elevation: 0,
        actions: [Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is AuthLoaded) {
              return IconButton(
                icon: const Icon(Icons.logout_outlined),
                onPressed: () {
                  context
                      .read<AuthBloc>()
                      .add(UserAuthLogout(state.userModel.token));
                },
              );
            }
            return IconButton(
                onPressed: () {}, icon: const Icon(Icons.arrow_left));
          }),
        )],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --

              // container
              SizedBox(
                height: size.height * 0.2,
                child: Stack(
                  children: [
                    Container(
                      height: size.height * 0.2 - 27,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color(0xFF212529),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Container(
                                      width: 200,
                                      child: BlocConsumer<AuthBloc, AuthState>(
                                          listener: (_, state) {
                                        if (state is AuthLogout) {
                                          showSnackbar(context, "Logged Out");
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil('/login',
                                                  ModalRoute.withName('/'));
                                        }
                                      }, builder: (_, state) {
                                        if (state is AuthLoaded) {
                                          return Text(
                                              "Hi, ${state.userModel.user!.name?.split(" ")[0]}",
                                              style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 24),
                                              ));
                                        }
                                        return const CircularProgressIndicator(
                                          backgroundColor: Colors.black,
                                        );
                                      }),
                                    ),
                                  ),
                                  Text("Welcome to Suki",
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      )),
                                ]),

                            // kanan
                            Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // text field buat search
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            onEditingComplete: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            controller: searchController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(16)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                hintText: 'Cari Barang atau Perabotan',
                                prefixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  color: Colors.black,
                                  onPressed: () {
                                    // search disini
                                  },
                                ),
                                fillColor: const Color(0xFFF8F9FA),
                                filled: true),
                          ),
                        ))
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Kategori",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        height: 100,
                        child: ListView(
                          // This next line does the trick.
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                width: 100.0,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                width: 100.0,
                                color: Colors.black45,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                width: 100.0,
                                color: Colors.black38,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                width: 100.0,
                                color: Colors.black26,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text("Produk",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Column(
                            children: [
                              Builder(builder: (context) {
                                return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black),
                                    onPressed: () => context
                                        .read<ProductBloc>()
                                        .add(GetProductList()),
                                    child: const Text("Reload"));
                              }),
                              SizedBox(
                                height: 24,
                              ),
                              BlocBuilder<ProductBloc, ProductState>(
                                builder: (context, state) {
                                  if (state is ProductInitial) {
                                    return const Text("LOADING MAZ");
                                  } else if (state is ProductLoaded) {
                                    return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount:
                                          state.productModel.results!.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.all(8.0),
                                          child: InkWell(
                                            child: Card(
                                              child: Container(
                                                margin: EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                                "${state.productModel.results![index].name}"),
                                                            Text(
                                                                "Rp.${state.productModel.results![index].harga},00"),
                                                          ],
                                                        ),
                                                        BlocBuilder<
                                                                WishlistBloc,
                                                                WishlistState>(
                                                            builder: (context,
                                                                wstate) {
                                                          if (wstate
                                                              is WishlistLoaded) {
                                                            return IconButton(
                                                                onPressed: () {
                                                                  final astate =
                                                                      context
                                                                          .read<
                                                                              AuthBloc>()
                                                                          .state;
                                                                  if (astate
                                                                      is AuthLoaded) {
                                                                    var product_id = state
                                                                        .productModel
                                                                        .results![
                                                                            index]
                                                                        .id
                                                                        .toString();
                                                                    var data = {
                                                                      "product_id":
                                                                          product_id
                                                                    };
                                                                    wstate.wishlistedProduct.contains(
                                                                            product_id)
                                                                        ? context.read<WishlistBloc>().add(DeleteProductFromWishlist(
                                                                            product_id,
                                                                            astate.userModel.token
                                                                                .toString()))
                                                                        : context.read<WishlistBloc>().add(AddProductToWishlist(
                                                                            data,
                                                                            astate.userModel.token.toString()));
                                                                  }
                                                                },
                                                                icon: Icon(wstate.wishlistedProduct.contains(state
                                                                        .productModel
                                                                        .results![
                                                                            index]
                                                                        .id
                                                                        .toString())
                                                                    ? Icons
                                                                        .favorite_outlined
                                                                    : Icons
                                                                        .favorite_outline));
                                                            // return Text(wstate
                                                            //     .data
                                                            //     .results![index]
                                                            //     .pivot!
                                                            //     .productId.toString());
                                                          }
                                                          return IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(Icons
                                                                  .heart_broken));
                                                        })
                                                      ],
                                                    ),
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
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // --
            ]),
      ),
    );
  }
}
