import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/logic/data/api/call.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/detail_transaction/detail_transaction_bloc.dart';
import 'package:mobile/logic/data/bloc/transaction/transaction_bloc.dart';
import 'package:mobile/presentation/screens/dashboard_screen/main_page.dart';
import 'package:mobile/presentation/utils/components/snackbar.dart';
import 'package:mobile/presentation/utils/default.dart';

class TransactionPembayaranPage extends StatefulWidget {
  final int transactionId;

  TransactionPembayaranPage({Key? key, required this.transactionId})
      : super(key: key);

  @override
  State<TransactionPembayaranPage> createState() =>
      _TransactionPembayaranPageState();
}

class _TransactionPembayaranPageState extends State<TransactionPembayaranPage> {
  void uploadImage() async {
    var auth = AuthBloc().state;
    if (auth is AuthLoaded) {
      ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        await CallApi().multiPartData(
            '/api/orders/upload/${widget.transactionId}',
            data: image.path,
            token: auth.userModel.token);
        restartBlocs();
      }
    }
  }

  void finalize() {
    var auth = AuthBloc().state;
    if (auth is AuthLoaded) {
      context.read<TransactionBloc>().add(ChangeTransactionStatus(widget
          .transactionId, "Menunggu_Konfirmasi", auth.userModel.token));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
          ModalRoute.withName("/main"));
      showSnackbar(
          context,
          "Transaksi akan segera dikonfirmasi oleh "
          "admin!");
    }
  }

  void showFinalizeDialog() async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Selesaikan Pembayaran?',
          style:
              GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Anda tidak dapat mengubah gambar bukti transaksi'
          ' lagi jika anda telah menyelesaikan pembayaran ini.',
          style: textStyleDefault(),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(
              'Cancel',
              style: textStyleDefault(),
            ),
          ),
          TextButton(
            onPressed: () {
              finalize();
            },
            child: Text(
              'OK',
              style: textStyleDefault(),
            ),
          ),
        ],
      ),
    );
  }

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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(
            color: Colors.grey[800],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MainPage()),
                            ModalRoute.withName("/main"));
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Pembayaran",
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
                    var checkout = state.data.details
                        .firstWhere((e) => e.id == widget.transactionId);
                    return BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, astate) {
                        if (astate is AuthLoaded) {
                          var auth = astate.userModel.user!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Bank Transfer",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(Icons.local_atm_outlined)
                                ],
                              ),

                              divider(),

                              // spacing
                              SizedBox(
                                height: 10,
                              ),

                              // nomor virtual account
                              Text(
                                "Nomor Rekening Transfer Bank",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "1200624857 (Munir)",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500),
                              ),

                              // total pembayaran
                              Text(
                                "Total Pembayaran",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Rp ${checkout.totalHarga}",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500),
                              ),

                              // spacing
                              SizedBox(
                                height: 10,
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
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: RefreshIndicator(
                  onRefresh: () async {
                    restartBlocs();
                  },
                  child: BlocBuilder<DetailTransactionBloc,
                      DetailTransactionState>(
                    builder: (context, state) {
                      if (state is DetailTransactionLoaded) {
                        var checkout = state.data.details
                            .firstWhere((e) => e.id == widget.transactionId);
                        return checkout.buktiBayar != null
                            ? Image.network(
                                "${apiUrlStorage}/${checkout.buktiBayar}",
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: 700,
                                // Better way to load images from network flutter
                                // https://stackoverflow.com/questions/53577962/better-way-to-load-images-from-network-flutter
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              )
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
                                        Text(
                                          "Anda belum menyatakan "
                                          "cinta.\n Pull down untuk refresh"
                                          " ",
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
              )),

              BlocBuilder<DetailTransactionBloc, DetailTransactionState>(
                builder: (context, state) {
                  if (state is DetailTransactionLoaded) {
                    var checkout = state.data.details
                        .firstWhere((e) => e.id == widget.transactionId);
                    return checkout.buktiBayar != null
                        ? Center(
                            child: TextButton(
                                onPressed: () {
                                  uploadImage();
                                },
                                child: Text(
                                  "Ganti "
                                  "Gambar",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black),
                                )))
                        : Text("");
                  }
                  return loading();
                },
              ),

              // divider
              divider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Pesananmu baru diteruskan ke toko setelah pembayaran "
                      "terverifikasi",
                      style: GoogleFonts.montserrat(
                          fontSize: 18, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),

              // spacing
              SizedBox(
                height: 20,
              ),

              // total amount + pay now
              BlocBuilder<DetailTransactionBloc, DetailTransactionState>(
                builder: (context, state) {
                  if (state is DetailTransactionLoaded) {
                    var checkout = state.data.details
                        .firstWhere((e) => e.id == widget.transactionId);
                    return InkWell(
                      onTap: () async {
                        checkout.buktiBayar == null
                            ? uploadImage()
                            : showFinalizeDialog();
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
                              checkout.buktiBayar == null
                                  ? 'UPLOAD BUKTI PEMBAYARAN'
                                  : "FINALIZE PEMBAYARAN",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 16,
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
      ),
    );
  }
}
