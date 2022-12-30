import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/presentation/screens/transaction_screen/transaction_details_product_page.dart';
import 'package:mobile/presentation/utils/default.dart';

buildProductCard(BuildContext context, var product){
  Size size = MediaQuery.of(context).size;
  return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics()),
      itemCount: product.length,
      itemBuilder:
          (BuildContext context, int index) {
        // transaction card
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => product[
                    index]
                        .categories ==
                        "Pro"
                            "duct"
                        ? TransactionDetailsProductPage(
                        transactionId:
                        product[index].id)
                        : TransactionDetailsProductPage(
                        transactionId:
                        product[index]
                            .id)));
          },

          // outer padding
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8),
            child: Container(
              // inner padding
              decoration: outlineBasic(),
              // inner padding
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    // pertama
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                                Icons.shopping_bag),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Text(
                                    "${product[index].categories}"),
                                Container(
                                  width: size
                                      .width * 0.3,
                                  child: Text(
                                    "${product[index].createdAt}",
                                    style:
                                    TextStyle(
                                        fontSize:
                                        getAdaptiveTextSize(context, 12)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: statusColorizer(product[index].status),
                            borderRadius: BorderRadius.all(Radius.circular(6))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:
                            6, vertical: 4),
                            child: Text(truncateWithEllipsis(
                                10,
                                product[index].status), style: GoogleFonts
                                .montserrat(fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),

                    // divider buat underline item
                    const Divider(
                      color: Colors.black,
                    ),

                    // item yang dibeli
                    Row(
                      children: [
                        // image item
                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(
                              5),
                          child: Container(
                            color: Colors.green,
                            height: 50,
                            width: 50,
                            child: product[index]
                                .products
                                .first
                                .image ==
                                null
                                ? const Icon(
                              Icons.inventory,
                            )
                                : Image.network(
                              "$apiUrlStorage/${product[index].products.first.image}",
                              fit:
                              BoxFit.fill,
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
                                    null) {
                                  return child;
                                }
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
                        ),

                        // spacing
                        const SizedBox(
                          width: 10,
                        ),

                        // nama barang
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            SizedBox(
                              width: size.width *
                                  0.6,
                              child: Text(
                                "${truncateWithEllipsis(40,
                                    product[index].products
                                        .first.name)}",
                                style: const TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .bold),
                              ),
                            ),
                            Text(
                                "${product[index].products.first.pivot.qty}x"),
                          ],
                        ),
                      ],
                    ),

                    // spacing
                    SizedBox(
                      height: product[index]
                          .products
                          .length -
                          1 ==
                          0
                          ? 0
                          : 10,
                    ),

                    // kasi keterangan kalo ada barang lain
                    Text(product[index]
                        .products
                        .length -
                        1 ==
                        0
                        ? ""
                        : "+${product[index].products.length - 1} produk lainnya"),

                    // spacing
                    SizedBox(
                      height: product[index]
                          .products
                          .length -
                          1 ==
                          0
                          ? 0
                          : 10,
                    ),

                    // kolom 3
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: [
                        // total belanja
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            const Text(
                                "Total Belanja:"),
                            Text(
                              rupiahConvert.format(
                                  product[index]
                                      .totalHarga),
                              style: const TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .bold),
                            ),
                          ],
                        ),

                        // button detail
                        Container(
                          decoration:
                          BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                              BorderRadius.all(Radius.circular(25))
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons
                                .arrow_forward_ios,
                                color: Colors
                                    .white),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
