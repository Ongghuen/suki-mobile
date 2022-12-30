import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/detail_transaction/detail_transaction_bloc.dart';
import 'package:mobile/logic/data/bloc/transaction_custom/transaction_custom_bloc.dart';
import 'package:mobile/presentation/screens/custom_screen/transaction_details_custom_page.dart';
import 'package:mobile/presentation/screens/transaction_screen/transaction_pembayaran_page.dart';
import 'package:mobile/presentation/utils/components/customCardBuilder.dart';
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
    Size size = MediaQuery.of(context).size;
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
                    Container(
                      width: size.width * 0.7,
                      child: Text(
                        "Pembayaran/Konfirmasi",
                        style: GoogleFonts.montserrat(
                          fontSize: getAdaptiveTextSize(context, 18),
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
                  height: size.height * 0.8,
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
                                      e.status! == "Pending" ||
                                  e.status! == "Belum_Bayar")
                              .toList();
                          return custom.length != 0
                              ? buildCustomCard(context, custom)
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
                                          Text(
                                            "Anda belum mengajukan "
                                            "furnitur custom.",
                                            style: GoogleFonts.montserrat(
                                                fontSize: getAdaptiveTextSize(
                                                    context, 14),
                                                fontWeight: FontWeight.w300),
                                            textAlign: TextAlign.center,
                                          ),
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
