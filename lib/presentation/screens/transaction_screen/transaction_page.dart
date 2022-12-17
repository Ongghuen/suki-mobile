import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/detail_transaction/detail_transaction_bloc.dart';
import 'package:mobile/presentation/screens/transaction_screen/transaction_details_product_page.dart';
import 'package:mobile/presentation/utils/default.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

const List<String> statustList = <String>[
  'Semua Status',
  'Menunggu_Konfirmasi',
  'Terkonfirmasi',
  'Dikirim',
  'Selesai'
];

const List<String> itemList = <String>[
  'Semua Item',
  'Product',
  'Custom',
];

class _TransactionPageState extends State<TransactionPage> {
  String statusValue = statustList.first;
  String itemValue = itemList.first;

  void restartBlocs() {
    final state = context.read<AuthBloc>().state;
    if (state is AuthLoaded) {
      context.read<AuthBloc>().add(UserAuthCheckToken(state.userModel.token));
      context.read<DetailTransactionBloc>().add(
          GetOngoingDetailTransactionList(state.userModel.token.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      "Daftar Transaksi",
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Container(
                      child: Container(
                        height: 50,
                        width: 180,
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: statusValue,
                            icon: const Icon(Icons.keyboard_arrow_down_outlined),
                            underline: SizedBox(),
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, color: Colors.black),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                statusValue = value!;
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
                      ),
                      decoration: outlineBasic(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Container(
                        height: 50,
                        width: 150,
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: itemValue,
                            icon: const Icon(Icons.keyboard_arrow_down_outlined),
                            underline: SizedBox(),
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, color: Colors.black),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                itemValue = value!;
                              });
                            },
                            items: itemList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Container(child: Text(value)),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      decoration: outlineBasic(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                // menunggu pembayaran
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("/menunggu-pembayaran");
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.attach_money_rounded,
                                size: 32,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Menunggu Pembayaran",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                    decoration: outlineBasic(),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // transaction card
                Container(
                  height: 650,
                  child: BlocBuilder<DetailTransactionBloc,
                      DetailTransactionState>(
                    builder: (context, state) {
                      if (state is DetailTransactionLoaded) {
                        var details = state.data.details
                            .where((e) =>
                                e.status != "Belum_Bayar" &&
                                e.status != "Pending")
                            .toList();

                        return RefreshIndicator(
                          color: Colors.black,
                          onRefresh: () async {
                            restartBlocs();
                          },
                          child: details.length == 0
                              ? Center(
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
                                          Text("Anda belum melakukan "
                                              "transaksi."),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  physics: AlwaysScrollableScrollPhysics(
                                      parent: BouncingScrollPhysics()),
                                  itemCount: details.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // transaction card
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => details[
                                                                index]
                                                            .categories ==
                                                        "Pro"
                                                            "duct"
                                                    ? TransactionDetailsProductPage(
                                                        transactionId:
                                                            details[index].id)
                                                    : TransactionDetailsProductPage(
                                                        transactionId:
                                                            details[index]
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
                                                                "${details[index].categories}"),
                                                            Text(
                                                              "${details[index].createdAt}",
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                        "${truncateWithEllipsis(10, details[index].status)}"),
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
                                                          BorderRadius.circular(
                                                              5),
                                                      child: Container(
                                                        color: Colors.green,
                                                        height: 50,
                                                        width: 50,
                                                        child: details[index]
                                                                    .products
                                                                    .first
                                                                    .image ==
                                                                null
                                                            ? Icon(
                                                                Icons.inventory,
                                                              )
                                                            : Image.network(
                                                                "${apiUrlStorage}/${details[index].products.first.image}",
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${details[index].products.first.name}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                            "${details[index].products.first.pivot.qty}x"),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                                // spacing
                                                SizedBox(
                                                  height: details[index]
                                                                  .products
                                                                  .length -
                                                              1 ==
                                                          0
                                                      ? 0
                                                      : 10,
                                                ),

                                                // kasi keterangan kalo ada barang lain
                                                Text(details[index]
                                                                .products
                                                                .length -
                                                            1 ==
                                                        0
                                                    ? ""
                                                    : "+${details[index].products.length - 1} produk lainnya"),

                                                // spacing
                                                SizedBox(
                                                  height: details[index]
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
                                                        Text("Total Belanja:"),
                                                        Text(
                                                          "${rupiahConvert
                                                              .format(details[index].totalHarga)}",
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
