import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/product/product_bloc.dart';
import 'package:mobile/presentation/screens/product_screen/detail_product_page.dart';
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

  TextEditingController search = TextEditingController();
  var searchValue = "";
  var categoryValue = "";
  List<String> categories = ["Semua", "Kursi", "Meja", "Pagar", "Pintu", "Rak"];
  List<IconData> categoriesIcon = [
    Icons.fiber_manual_record_outlined,
    Icons.chair_alt_outlined,
    Icons.table_bar_outlined,
    Icons.fence_outlined,
    Icons.door_front_door_outlined,
    Icons.night_shelter_outlined
  ];
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
                    height: size.height * 0.17,
                    child: Stack(
                      children: [
                        Container(
                          height: size.height * 0.17 - 20,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Color(0xFF212529),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(15))),
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
                                              var user = state.userModel.user!;
                                              var name = truncateWithEllipsis(
                                                  12, user.name!.split(" ")[0]);
                                              return Text("Hi, ${name}",
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 24),
                                                  ));
                                            }
                                            return loading();
                                          }),
                                        ),
                                      ),
                                      Text("Welcome to Suki!",
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          )),
                                    ]),

                                // kanan
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    if (state is AuthLoaded) {
                                      var user = state.userModel.user;
                                      return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: user?.image == null
                                              ? Container(
                                                  color: Colors.white,
                                                  height: 50,
                                                  width: 50,
                                                  child: const Icon(
                                                    Icons.person,
                                                    size: 40,
                                                    color: Colors.black54,
                                                  ),
                                                )
                                              : Image.network(
                                                  "${apiUrlStorage}/${user?.image}",
                                                  fit: BoxFit.cover,
                                                  height: 50,
                                                  width: 50,
                                                  // Better way to load images from network flutter
                                                  // https://stackoverflow.com/questions/53577962/better-way-to-load-images-from-network-flutter
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    );
                                                  },
                                                ));
                                    }
                                    return loading();
                                  },
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
                                style: GoogleFonts.montserrat(),
                                onEditingComplete: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  setState(() {
                                    searchValue = search.text.toString();
                                    print(searchValue);
                                  });
                                },
                                controller: search,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
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
                                    fillColor: Colors.white,
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

                // categories
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                      categoryValue =
                                          index == 0 ? "" : categories[index];
                                    });
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            decoration: BoxDecoration(
                                              color: selectedIndex == index
                                                  ? Colors.black
                                                  : Colors.white,

                                              //border categories
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(categoriesIcon[index],
                                                    color:
                                                        selectedIndex == index
                                                            ? Colors.white
                                                            : Colors.grey),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(categories[index],
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color: selectedIndex ==
                                                                index
                                                            ? Colors.white
                                                            : Colors.grey,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              BlocBuilder<ProductBloc, ProductState>(
                                builder: (context, state) {
                                  if (state is ProductLoaded) {
                                    var product = state.productModel.results!
                                        .where((e) =>
                                            e.name!.toLowerCase().contains(
                                                searchValue.toLowerCase()) &&
                                            e.categories!
                                                .toLowerCase()
                                                .contains(categoryValue
                                                    .toLowerCase()))
                                        .toList();
                                    return product.length != 0
                                        ? SizedBox(
                                            height: 220,
                                            child: ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: product.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  decoration: productBox(),
                                                  margin: const EdgeInsets.only(
                                                      right: 12),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DetailProduct(
                                                                      productId: product[
                                                                              index]
                                                                          .id!
                                                                          .toInt())));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(14.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            product[index]
                                                                        .image ==
                                                                    null
                                                                ? ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          130,
                                                                      width:
                                                                          130,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .inventory,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    child: Image
                                                                        .network(
                                                                      "${apiUrlStorage}/${product![index].image}",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      height:
                                                                          130,
                                                                      width:
                                                                          130,
                                                                      // Better way to load images from network flutter
                                                                      // https://stackoverflow.com/questions/53577962/better-way-to-load-images-from-network-flutter
                                                                      loadingBuilder: (BuildContext context,
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
                                                                            value: loadingProgress.expectedTotalBytes != null
                                                                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
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
                                                              children: [
                                                                Container(
                                                                  width: 100,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "${truncateWithEllipsis(14, "${product[index].name}")}",
                                                                        style: GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                          "${truncateWithEllipsis(14, "${rupiahConvert.format(product[index].harga)}")}",
                                                                          style:
                                                                              GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                12,
                                                                          )),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : SizedBox(
                                            height: 220,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Produk Tidak Ditemukan.",
                                                  style: notFoundText(),
                                                ),
                                              ],
                                            ),
                                          );
                                  }
                                  return Center(
                                    child: loading(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Furnitur Populer",
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "/search");
                              },
                              child: Text("Lihat Semua",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Column(
                          children: [
                            BlocBuilder<ProductBloc, ProductState>(
                              builder: (context, state) {
                                if (state is ProductLoaded) {
                                  var product = state.productModel.topProduct!
                                      .where((e) =>
                                          e.name!.toLowerCase().contains(
                                              searchValue.toLowerCase()) &&
                                          e.categories!.toLowerCase().contains(
                                              categoryValue.toLowerCase()))
                                      .toList();
                                  return product.length != 0
                                      ? SizedBox(
                                          height: 120,
                                          child: ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: product.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                decoration: productBox(),
                                                margin: const EdgeInsets.only(
                                                    bottom: 12, right: 12),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailProduct(
                                                                    productId: product[
                                                                            index]
                                                                        .id!
                                                                        .toInt())));
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              14.0),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              product[index]
                                                                          .image ==
                                                                      null
                                                                  ? ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.only(
                                                                              topLeft: Radius.circular(10)),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            80,
                                                                        width:
                                                                            80,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .inventory,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10)),
                                                                      child: Image
                                                                          .network(
                                                                        "${apiUrlStorage}/${product[index].image}",
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        height:
                                                                            80,
                                                                        width:
                                                                            80,
                                                                        // Better way to load images from network flutter
                                                                        // https://stackoverflow.com/questions/53577962/better-way-to-load-images-from-network-flutter
                                                                        loadingBuilder: (BuildContext context,
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
                                                                              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              Container(
                                                                width: 150,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "${product[index].name}",
                                                                      style: GoogleFonts.montserrat(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Text(
                                                                      "${truncateWithEllipsis(12, product[index].desc.toString())}",
                                                                      style: GoogleFonts.montserrat(
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                    Text(
                                                                        "${rupiahConvert.format(state.productModel.results![index].harga)}"),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : SizedBox(
                                          height: 120,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Produk Tidak Ditemukan.",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ],
                                          ),
                                        );
                                }
                                return Center(
                                  child: loading(),
                                );
                              },
                            ),
                          ],
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
