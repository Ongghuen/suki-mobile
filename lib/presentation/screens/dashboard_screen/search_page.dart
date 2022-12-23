import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/bloc/product/product_bloc.dart';
import 'package:mobile/presentation/screens/product_screen/detail_product_page.dart';
import 'package:mobile/presentation/utils/default.dart';

class SearchPage extends StatefulWidget {
  String category;
  SearchPage({super.key, required this.category});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
  void initState() {
    widget.category == "Kursi" ? selectedIndex = 1 : 0;
    widget.category == "Meja" ? selectedIndex = 2 : 0;
    // TODO: implement initState
    categoryValue = selectedIndex == 0 ? "" : categories[selectedIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextField(
                  style: GoogleFonts.montserrat(
                    fontSize: 16
                  ),
                  onEditingComplete: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {
                      searchValue = search.text.toString();
                    });
                  },
                  controller: search,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(16)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.black12, width: 1),
                          borderRadius: BorderRadius.circular(16)),
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
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  // categories
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        textStyle: GoogleFonts.montserrat(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          color:
                                                              selectedIndex ==
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
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        BlocBuilder<ProductBloc, ProductState>(
                          builder: (context, state) {
                            if (state is ProductLoaded) {
                              var product = state.productModel.results!
                                  .where((e) =>
                                      e.name!.toLowerCase().contains(
                                          searchValue.toLowerCase()) &&
                                      e.categories!.toLowerCase().contains(
                                          categoryValue.toLowerCase()))
                                  .toList();

                              return product.length != 0
                                  ? SizedBox(
                                      height: 600,
                                      width: double.infinity,
                                      child: RefreshIndicator(
                                        color: Colors.black,
                                        onRefresh: () async {
                                          context
                                              .read<ProductBloc>()
                                              .add(GetProductList());
                                        },
                                        child: GridView.builder(
                                            physics: BouncingScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 200,
                                                    childAspectRatio:
                                                        size.aspectRatio * 1.5,
                                                    crossAxisSpacing: 10,
                                                    mainAxisSpacing: 10),
                                            itemCount: product.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              return Container(
                                                decoration: productBox(),
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
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          product[index]
                                                                      .image ==
                                                                  null
                                                              ? ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                    size
                                                                        .height * 0.16,
                                                                    width:
                                                                    size
                                                                        .width * 0.4,
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
                                                                              10),
                                                                  child: Image
                                                                      .network(
                                                                    "${apiUrlStorage}/${product![index].image}",
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: size
                                                                        .height * 0.16,
                                                                    width: size
                                                                        .width * 0.4,
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
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "${truncateWithEllipsis(12, "${product[index].name}")}",
                                                                    style: GoogleFonts.montserrat(
                                                                        fontSize: getAdaptiveTextSize(
                                                                            context,
                                                                            12),
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Text(
                                                                      "${truncateWithEllipsis(14, "${rupiahConvert.format(product[index].harga)}")}",
                                                                      style: GoogleFonts
                                                                          .montserrat(
                                                                        fontSize: getAdaptiveTextSize(
                                                                            context,
                                                                            12),
                                                                      )),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 600,
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
