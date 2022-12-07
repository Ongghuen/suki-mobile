import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/product/product_bloc.dart';
import 'package:mobile/logic/data/bloc/wishlist/wishlist_bloc.dart';
import 'package:mobile/presentation/screens/detail_product_page.dart';
import 'package:mobile/presentation/utils/components/snackbar.dart';
import 'package:mobile/presentation/utils/default.dart';

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
  List<String> categories = ["Semua", "Kursi", "Lol", "Hahay", "Lmao"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF212529),
        elevation: 0,
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --

                // container
                SafeArea(
                  child: SizedBox(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Container(
                                          width: 200,
                                          child:
                                              BlocConsumer<AuthBloc, AuthState>(
                                                  listener: (_, state) {
                                            if (state is AuthLogout) {
                                              showSnackbar(
                                                  context, "Logged Out");
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      '/login',
                                                      ModalRoute.withName('/'));
                                            }
                                          }, builder: (_, state) {
                                            if (state is AuthLoaded) {
                                              return Text(
                                                  "Hi, ${state.userModel.user!.name?.split(" ")[0]}",
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                color: Colors.white,
                                                fontSize: 18),
                                          )),
                                    ]),

                                // kanan
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
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
                          child: ListView.builder(
                              // This next line does the trick.
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(Icons.archive),
                                        Text(categories[index],
                                            style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: selectedIndex == index
                                                    ? Colors.black
                                                    : Colors.grey,
                                              ),
                                            )),
                                        Container(
                                          margin: EdgeInsets.only(top: 20 / 4),
                                          //top padding 5
                                          height: 2,
                                          width: 30,
                                          color: selectedIndex == index
                                              ? Colors.black
                                              : Colors.transparent,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Text("Produk",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              BlocBuilder<ProductBloc, ProductState>(
                                builder: (context, state) {
                                  if (state is ProductLoaded) {
                                    return SizedBox(
                                      height: 250,
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            state.productModel.results!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailProduct(
                                                                productId: state
                                                                    .productModel
                                                                    .results![
                                                                        index]
                                                                    .id!
                                                                    .toInt())));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Column(
                                                  children: <Widget>[
                                                    state
                                                                .productModel
                                                                .results![index]
                                                                .image ==
                                                            null
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            child: Container(
                                                              height: 150,
                                                              width: 150,
                                                              child: Icon(
                                                                Icons.inventory,
                                                              ),
                                                            ),
                                                          )
                                                        : ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            child:
                                                                Image.network(
                                                              "${apiUrlStorage}/${state.productModel.results![index].image}",
                                                              fit: BoxFit.fill,
                                                              height: 150,
                                                              width: 150,
                                                              // Better way to load images from network flutter
                                                              // https://stackoverflow.com/questions/53577962/better-way-to-load-images-from-network-flutter
                                                              loadingBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      Widget
                                                                          child,
                                                                      ImageChunkEvent?
                                                                          loadingProgress) {
                                                                if (loadingProgress ==
                                                                    null)
                                                                  return child;
                                                                return Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    value: loadingProgress.expectedTotalBytes !=
                                                                            null
                                                                        ? loadingProgress.cumulativeBytesLoaded /
                                                                            loadingProgress.expectedTotalBytes!
                                                                        : null,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 100,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${state.productModel.results![index].name}",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                              ),
                                                              Text(
                                                                  "Rp.${state.productModel.results![index].harga},00"),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
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
                        Text("Maunya sih gitu",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              BlocBuilder<ProductBloc, ProductState>(
                                builder: (context, state) {
                                  if (state is ProductLoaded) {
                                    return SizedBox(
                                      width: double.infinity,
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            state.productModel.results!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailProduct(
                                                                productId: state
                                                                    .productModel
                                                                    .results![
                                                                        index]
                                                                    .id!
                                                                    .toInt())));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Column(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        state
                                                                    .productModel
                                                                    .results![
                                                                        index]
                                                                    .image ==
                                                                null
                                                            ? ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                child:
                                                                    Container(
                                                                  height: 100,
                                                                  width: 100,
                                                                  child: Icon(
                                                                    Icons
                                                                        .inventory,
                                                                  ),
                                                                ),
                                                              )
                                                            : ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                child: Image
                                                                    .network(
                                                                  "${apiUrlStorage}/${state.productModel.results![index].image}",
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  height: 100,
                                                                  width: 100,
                                                                  // Better way to load images from network flutter
                                                                  // https://stackoverflow.com/questions/53577962/better-way-to-load-images-from-network-flutter
                                                                  loadingBuilder: (BuildContext
                                                                          context,
                                                                      Widget
                                                                          child,
                                                                      ImageChunkEvent?
                                                                          loadingProgress) {
                                                                    if (loadingProgress ==
                                                                        null)
                                                                      return child;
                                                                    return Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        value: loadingProgress.expectedTotalBytes !=
                                                                                null
                                                                            ? loadingProgress.cumulativeBytesLoaded /
                                                                                loadingProgress.expectedTotalBytes!
                                                                            : null,
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                        Container(
                                                          height: 100,
                                                          width: 150,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${state.productModel.results![index].name}",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                              ),
                                                              Text(
                                                                "${truncateWithEllipsis(20, state.productModel.results![index].desc.toString())}",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                              ),
                                                              Text(
                                                                  "Rp.${state.productModel.results![index].harga},00"),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.black,
                                    ),
                                  );
                                },
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () => context
                                      .read<ProductBloc>()
                                      .add(GetProductList()),
                                  child: const Text("Reload")),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // --
              ]),
        ),
      ),
    );
  }
}
