import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/bloc/detail_transaction/detail_transaction_bloc.dart';
import 'package:mobile/logic/data/bloc/transaction/transaction_bloc.dart';
import 'package:mobile/presentation/utils/default.dart';

class TransactionMenungguPembayaranPage extends StatefulWidget {
  const TransactionMenungguPembayaranPage({Key? key}) : super(key: key);

  @override
  State<TransactionMenungguPembayaranPage> createState() =>
      _TransactionMenungguPembayaranPageState();
}

class _TransactionMenungguPembayaranPageState
    extends State<TransactionMenungguPembayaranPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    Text(
                      "Menunggu Pembayaran",
                      style: GoogleFonts.montserrat(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  height: 650,
                  child: BlocBuilder<DetailTransactionBloc,
                      DetailTransactionState>(
                    builder: (context, state) {
                      if (state is DetailTransactionLoaded) {
                        var belumBayar = state.data.details
                            .where((e) => e.status == "Belum_Bayar")
                            .toList();

                        return RefreshIndicator(
                          color: Colors.black,
                          onRefresh: () async {
                          },
                          child: belumBayar.length == 0
                              ? Center(
                            child: SingleChildScrollView(
                              physics:
                              AlwaysScrollableScrollPhysics(parent:
                              BouncingScrollPhysics()),
                              child: Container(
                                height: 400,
                                width: 400,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Anda belum melakukan "
                                        "transaksi."),
                                  ],
                                ),
                              ),
                            ),
                          ) : ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              itemCount: belumBayar.length,
                              itemBuilder: (BuildContext context, int index) {
                                // transaction card
                                return InkWell(
                                  onTap: () {},

                                  // outer padding
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Container(
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
                                                    Icon(Icons.shopping_bag),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "${belumBayar[index].categories}"),
                                                        Text(
                                                          "${belumBayar[index].createdAt}",
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Text("Belum Bayar"),
                                              ],
                                            ),

                                            // divider buat underline item
                                            Divider(
                                              color: Colors.black,
                                            ),

                                            // item yang dibeli
                                            Row(
                                              children: [
                                                // image item
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Container(
                                                    color: Colors.red,
                                                    height: 50,
                                                    width: 50,
                                                    child:
                                                        belumBayar[index]
                                                                    .products
                                                                    .first
                                                                    .image ==
                                                                null
                                                            ? Icon(
                                                                Icons.inventory,
                                                              )
                                                            : Image.network(
                                                                "${apiUrlStorage}/${belumBayar[index].products.first.image}",
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
                                                ),

                                                // spacing
                                                SizedBox(
                                                  width: 10,
                                                ),

                                                // nama barang
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${belumBayar[index].products.first.name}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                        "${belumBayar[index].products.first.pivot.qty}x"),
                                                  ],
                                                ),
                                              ],
                                            ),

                                            // spacing
                                            SizedBox(
                                              height: belumBayar[index]
                                                              .products
                                                              .length -
                                                          1 ==
                                                      0
                                                  ? 0
                                                  : 10,
                                            ),

                                            // kasi keterangan kalo ada barang lain
                                            Text(belumBayar[index]
                                                            .products
                                                            .length -
                                                        1 ==
                                                    0
                                                ? ""
                                                : "+${belumBayar[index].products.length - 1} produk lainnya"),

                                            // spacing
                                            SizedBox(
                                              height: belumBayar[index]
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Total Belanja:"),
                                                    Text(
                                                      "Rp ${belumBayar[index].totalHarga}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),

                                                // button detail
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text("Ayo Bayar!"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.black54,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: outlineBasic(),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                      return loading();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
