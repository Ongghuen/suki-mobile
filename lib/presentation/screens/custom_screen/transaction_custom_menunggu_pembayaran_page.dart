import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/detail_transaction/detail_transaction_bloc.dart';
import 'package:mobile/logic/data/bloc/transaction_custom/transaction_custom_bloc.dart';
import 'package:mobile/presentation/screens/custom_screen/transaction_details_custom_page.dart';
import 'package:mobile/presentation/screens/transaction_screen/transaction_pembayaran_page.dart';
import 'package:mobile/presentation/utils/default.dart';

class TransactionCustomMenungguPembayaranPage extends StatefulWidget {
  const TransactionCustomMenungguPembayaranPage({Key? key}) : super(key: key);

  @override
  State<TransactionCustomMenungguPembayaranPage> createState() =>
      _TransactionCustomMenungguPembayaranPageState();
}

class _TransactionCustomMenungguPembayaranPageState
    extends State<TransactionCustomMenungguPembayaranPage> {
  void restartBlocs() {
    final state = context.read<AuthBloc>().state;
    if (state is AuthLoaded) {
      context
          .read<TransactionCustomBloc>()
          .add(GetTransactionCustomLists(state.userModel.token));
    }
  }

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
                      "Pembayaran/Konfirmasi",
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
                  child: RefreshIndicator(
                    onRefresh: () async {
                      restartBlocs();
                    },
                    child: BlocBuilder<TransactionCustomBloc,
                        TransactionCustomState>(
                      builder: (context, state) {
                        if (state is TransactionCustomLoaded) {
                          var custom = state.data.details!
                              .where((e) =>
                                  e.customs!.length != 0 &&
                                  e.status! == "Pending" || e.status! ==
                                      "Belum_Bayar")
                              .toList();
                          return custom.length != 0
                              ? ListView.builder(
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
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                "${custom[index].categories}"),
                                                            Text(
                                                              "${custom[index].createdAt}",
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Text(truncateWithEllipsis(
                                                        10,
                                                        "${custom[index].status}")),
                                                  ],
                                                ),

                                                // divider buat underline item
                                                Divider(
                                                  color: Colors.black,
                                                ),

                                                // item yang dibeli
                                                Row(
                                                  children: [
                                                    // nama barang
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${custom[index].customs!.first.name}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "${custom[index].customs!.first.jenisCustom}",
                                                              style: TextStyle(
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
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                            Text(
                                                              "${custom[index].customs!.first.bahan}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          "${custom[index].customs!.first.desc}",
                                                        ),
                                                      ],
                                                    ),
                                                  ],
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
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),

                                                    // button detail
                                                    ElevatedButton(
                                                      onPressed: () {},
                                                      child: Text("Detail"),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.black,
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
                                  })
                              : Center(
                                  child: SingleChildScrollView(
                                    physics: AlwaysScrollableScrollPhysics(
                                        parent: BouncingScrollPhysics()),
                                    child: Container(
                                      height: 400,
                                      width: 400,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Anda belum mengajukan "
                                              "furnitur custom."),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                        }
                        return loading();
                      },
                    ),
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
