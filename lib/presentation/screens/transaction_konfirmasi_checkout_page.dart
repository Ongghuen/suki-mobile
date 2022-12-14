import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/detail_transaction/detail_transaction_bloc.dart';
import 'package:mobile/logic/data/bloc/transaction/transaction_bloc.dart';
import 'package:mobile/presentation/screens/transaction_after_konfirmasi_checkout_page.dart';
import 'package:mobile/presentation/utils/default.dart';

class TransactionKonfirmasiCheckoutPage extends StatefulWidget {
  const TransactionKonfirmasiCheckoutPage({Key? key}) : super(key: key);

  @override
  State<TransactionKonfirmasiCheckoutPage> createState() =>
      _TransactionKonfirmasiCheckoutPageState();
}

enum metode_pembayaran { transfer }

class _TransactionKonfirmasiCheckoutPageState
    extends State<TransactionKonfirmasiCheckoutPage> {
  metode_pembayaran _metode_bayar = metode_pembayaran.transfer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Konfirmasi Pembayaran",
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            // spacing
            SizedBox(
              height: 10,
            ),

            // divider
            divider(),

            BlocBuilder<DetailTransactionBloc, DetailTransactionState>(
              builder: (context, state) {
                if (state is DetailTransactionLoaded) {
                  return BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, astate) {
                      if (astate is AuthLoaded) {
                        var auth = astate.userModel.user!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Metode Pembayaran",
                              style: GoogleFonts.montserrat(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  Icon(Icons.local_atm_outlined),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  const Text('Transfer Rekening'),
                                ],
                              ),
                              trailing: Radio<metode_pembayaran>(
                                value: metode_pembayaran.transfer,
                                groupValue: _metode_bayar,
                                onChanged: (metode_pembayaran? value) {
                                  setState(() {
                                    _metode_bayar = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      return loading();
                    },
                  );
                }
                return loading();
              },
            ),

            // divider
            divider(),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ringkasan Belanja",
                    style: GoogleFonts.montserrat(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),

                  // spacing
                  SizedBox(
                    height: 10,
                  ),

                  // inside
                  Column(
                    children: [
                      // total harga
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Harga",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "test",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),

                      // total ongkos kirim
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Ongkos Service",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "test",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),

                      // total tagihan
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Tagihan",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            "test",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // spacing
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),

            // total amount + pay now

            BlocBuilder<DetailTransactionBloc, DetailTransactionState>(
              builder: (context, state) {
                if (state is DetailTransactionLoaded) {
                  var checkout = state.data.details.firstWhere((e) =>
                      e.status ==
                      "Pendi"
                          "ng");
                  return InkWell(
                    onTap: () {
                      final state = context.read<AuthBloc>().state;
                      if (state is AuthLoaded) {
                        context.read<TransactionBloc>().add(
                            CheckoutTransactionLists(state.userModel.token));
                        context.read<DetailTransactionBloc>().add(
                            GetOngoingDetailTransactionList(
                                state.userModel.token));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TransactionAfterConfirmedCheckoutPage(
                                      transactionId: checkout.id)),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'KONFIRMASI PESANAN',
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          // pay now
                        ],
                      ),
                    ),
                  );
                }
                return loading();
              },
            )
          ],
        ),
      ),
    );
  }
}