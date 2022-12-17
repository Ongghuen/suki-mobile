import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/bloc/product/product_bloc.dart';
import 'package:mobile/presentation/screens/detail_product_page.dart';
import 'package:mobile/presentation/utils/default.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  var searchValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextField(
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
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
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
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {

                      if (state is ProductLoaded) {
                        var product = state.productModel.results!.where((e)
                        => e.name!.toLowerCase().contains(searchValue
                            .toLowerCase())).toList();

                        return SizedBox(
                          width: double.infinity,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: product.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailProduct(
                                                productId: product[index].id!
                                                    .toInt())));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            product[index]
                                                        .image ==
                                                    null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Container(
                                                      height: 100,
                                                      width: 100,
                                                      child: Icon(
                                                        Icons.inventory,
                                                      ),
                                                    ),
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Image.network(
                                                      "${apiUrlStorage}/${product![index].image}",
                                                      fit: BoxFit.fill,
                                                      height: 100,
                                                      width: 100,
                                                      // Better way to load images from network flutter
                                                      // https://stackoverflow.com/questions/53577962/better-way-to-load-images-from-network-flutter
                                                      loadingBuilder: (BuildContext
                                                              context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) return child;
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
                                                    ),
                                                  ),
                                            Container(
                                              height: 100,
                                              width: 150,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${product![index].name}",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Text(
                                                    "${truncateWithEllipsis
                                                      (20, product![index].desc
                                                        .toString())}",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                  ),
                                                  Text(
                                                      "${rupiahConvert
                                                          .format
                                                        (product![index]
                                                          .harga)}"),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
