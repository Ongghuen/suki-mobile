import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/detail_transaction/detail_transaction_bloc.dart';
import 'package:mobile/presentation/utils/components/productCardBuilder.dart';
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

class _TransactionPageState extends State<TransactionPage> {
  String statusValue = statustList.first;
  String statusValueText = "";

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                        icon: const Icon(Icons.arrow_back_ios)),
                    Text(
                      "Daftar Transaksi",
                      style: GoogleFonts.montserrat(
                        fontSize: getAdaptiveTextSize(context, 20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  decoration: outlineBasic(),
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: statusValue,
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      underline: const SizedBox(),
                      style: GoogleFonts.montserrat(
                        fontSize: getAdaptiveTextSize(context, 14),
                          fontWeight: FontWeight.w500, color: Colors.black),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          statusValue = value!;
                          statusValueText =
                              value.contains("Semua") ? "" : value;
                        });
                      },
                      items: statustList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // menunggu pembayaran
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("/menunggu-pembayaran");
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
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: size.width * 0.55,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Menunggu Pembayaran",
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

                const SizedBox(
                  height: 10,
                ),

                // transaction card
                SizedBox(
                  height: size.height * 0.6,
                  child: RefreshIndicator(
                    color: Colors.black,
                    onRefresh: () async {
                      restartBlocs();
                    },
                    child: BlocBuilder<DetailTransactionBloc,
                        DetailTransactionState>(
                      builder: (context, state) {
                        if (state is DetailTransactionLoaded) {
                          var product = state.data.details
                              .where((e) =>
                                  e.categories == "Product" &&
                                  e.status != "Belum_Bayar" &&
                                  e.status != "Pending" &&
                                  e.status!.contains(statusValueText))
                              .toList();

                          return product.length == 0
                              ? SingleChildScrollView(
                                physics:
                                    const AlwaysScrollableScrollPhysics(
                                        parent: BouncingScrollPhysics()),
                                child: SizedBox(
                                  height: size.height * 0.5,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text("Anda belum melakukan "
                                          "transaksi.", style: notFoundText()),
                                    ],
                                  ),
                                ),
                              )
                              : buildProductCard(context, product);
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
