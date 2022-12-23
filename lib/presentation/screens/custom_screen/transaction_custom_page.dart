import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/transaction_custom/transaction_custom_bloc.dart';
import 'package:mobile/presentation/screens/custom_screen/transaction_custom_menunggu_pembayaran_page.dart';
import 'package:mobile/presentation/screens/custom_screen/transaction_details_custom_page.dart';
import 'package:mobile/presentation/screens/transaction_screen/transaction_pembayaran_page.dart';
import 'package:mobile/presentation/utils/default.dart';

class TransactionCustomPage extends StatefulWidget {
  const TransactionCustomPage({Key? key}) : super(key: key);

  @override
  State<TransactionCustomPage> createState() => _TransactionCustomPageState();
}

const List<String> statustList = <String>[
  'Semua Status',
  'Menunggu_Konfirmasi',
  'Terkonfirmasi',
  'Dikirim',
  'Selesai'
];

class _TransactionCustomPageState extends State<TransactionCustomPage> {
  String statusValue = statustList.first;
  String statusValueText = "";

  void restartBlocs() {
    final state = context.read<AuthBloc>().state;
    if (state is AuthLoaded) {
      context
          .read<TransactionCustomBloc>()
          .add(GetTransactionCustomLists(state.userModel.token));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    restartBlocs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                    Container(
                      width: size.width * 0.7,
                      child: Text(
                        "List Request Custom",
                        style: GoogleFonts.montserrat(
                          fontSize: getAdaptiveTextSize(context, 20),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: statusValue,
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      underline: SizedBox(),
                      style: GoogleFonts.montserrat(
                        fontSize: getAdaptiveTextSize(context, 14),
                          fontWeight: FontWeight.w500, color: Colors.black),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          statusValue = value!;
                          statusValueText =
                              value!.contains("Semua") ? "" : value!;
                        });
                      },
                      items: statustList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(child: Text(value)),
                        );
                      }).toList(),
                    ),
                  ),
                  decoration: outlineBasic(),
                ),
                SizedBox(
                  height: 10,
                ),

                // menunggu pembayaran
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            TransactionCustomMenungguPembayaranPage(),
                        settings: RouteSettings(
                            name: "/menunggu-pembayaran-custom")));
                  },
                  child: Container(
                    decoration: outlineBasic(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.attach_money_rounded,
                                size: size.width * 0.08,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: size.width * 0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Pembayaran atau Konfirmasi",
                                      style: GoogleFonts.montserrat(
                                        fontSize: getAdaptiveTextSize
                                          (context, 14),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // transaction card
                Container(
                    height: size.height * 0.5,
                    child: RefreshIndicator(
                      color: Colors.black,
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
                                    e.status! != "Belum_Bayar" &&
                                    e.status! != "Pending" &&
                                    e.status!.contains(statusValueText))
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 20),
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
                                                          Icon(Icons
                                                              .shopping_bag),
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
                                                                style: GoogleFonts.montserrat(
                                                                    fontSize:
                                                                        getAdaptiveTextSize(context, 12)),
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
                                                            style: GoogleFonts.montserrat(
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
                                        height: size.height * 0.2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Anda belum mengajukan "
                                                "furnitur custom.",
                                                style: GoogleFonts
                                                    .montserrat(fontWeight:
                                                FontWeight.w300),
                                              textAlign:
                                              TextAlign.center,),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                          }
                          return loading();
                        },
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
