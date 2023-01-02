import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/presentation/screens/custom_screen/transaction_details_custom_page.dart';
import 'package:mobile/presentation/screens/transaction_screen/transaction_pembayaran_page.dart';
import 'package:mobile/presentation/utils/default.dart';

buildCustomCard(BuildContext context, var custom){
  Size size = MediaQuery.of(context).size;
  return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics()),
      itemCount: custom.length,
      itemBuilder:
          (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            custom[index].status !=
                "Belum_Baya"
                    "r"
                ? Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        TransactionDetailsCustomPage(
                            transactionId:
                            custom[index]
                                .id ??
                                0)))
                : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TransactionPembayaranPage(
                            transactionId:
                            custom[index]
                                .id ??
                                0)));
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
                            Icon(
                                Icons.shopping_bag),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width:
                              size.width * 0.3,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Text(
                                      "${custom[index].categories}"),
                                  Text(
                                    "${custom[index].createdAt}",
                                    style: GoogleFonts.montserrat(
                                        fontSize:
                                        12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: statusColorizer(custom[index].status),
                              borderRadius: BorderRadius.all(Radius.circular(6))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:
                            6, vertical: 4),
                            child: Text(truncateWithEllipsis(
                                10,
                                custom[index].status), style: GoogleFonts
                                .montserrat(fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),

                    // divider buat underline item
                    Divider(
                      color: Colors.black,
                    ),

                    // item yang dibeli
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          // nama barang
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                truncateWithEllipsis(
                                    30,
                                    "${custom[index
                                    ].customs!
                                        .first
                                        .name}"),
                                style: GoogleFonts.montserrat(
                                    fontWeight:
                                    FontWeight
                                        .bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${custom[index].customs!.first.jenisCustom}",
                                    style: GoogleFonts.montserrat(
                                        fontWeight:
                                        FontWeight
                                            .w500),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets
                                        .symmetric(
                                        horizontal:
                                        4),
                                    child: Text(
                                      "-",
                                      style: GoogleFonts.montserrat(
                                          fontWeight:
                                          FontWeight
                                              .w500),
                                    ),
                                  ),
                                  Text(
                                    "${custom[index].customs!.first.bahan}",
                                    style: GoogleFonts.montserrat(
                                        fontWeight:
                                        FontWeight
                                            .w500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width:
                                size.width * 0.6,
                                child: Text(
                                  truncateWithEllipsis(
                                      50,
                                      "${custom[index].customs!.first.desc}"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                            Text("Total Harga:"),
                            Text(
                              "${rupiahConvert.format(custom[index].totalHarga)}",
                              style: GoogleFonts.montserrat(
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
