import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/logic/data/api/call.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/transaction/transaction_bloc.dart';
import 'package:mobile/logic/data/bloc/transaction_custom/transaction_custom_bloc.dart';
import 'package:mobile/presentation/screens/dashboard_screen/main_page.dart';
import 'package:mobile/presentation/utils/default.dart';

class TransactionDetailsCustomPage extends StatefulWidget {
  final int transactionId;

  TransactionDetailsCustomPage({Key? key, required this.transactionId})
      : super(key: key);

  @override
  State<TransactionDetailsCustomPage> createState() =>
      _TransactionDetailsCustomPageState();
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class _TransactionDetailsCustomPageState
    extends State<TransactionDetailsCustomPage> {
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
      context.read<TransactionBloc>().add(ChangeTransactionStatus(
          widget.transactionId, "Selesai", auth.userModel.token));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
          ModalRoute.withName("/main"));
    }
  }

  bottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      // isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Form(
          child: SingleChildScrollView(
            child: AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: BlocBuilder<TransactionCustomBloc,
                        TransactionCustomState>(
                      builder: (context, state) {
                        if (state is TransactionCustomLoaded) {
                          var custom = state.data.details!
                              .firstWhere((e) => e.id == widget.transactionId);
                          return Column(
                            children: [
                              Center(
                                child: Text(
                                  "Pesanan Furnitur Custom Anda telah "
                                  "disetujui oleh Admin!",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      fontSize: getAdaptiveTextSize(context, 22),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "Total Harga: ${rupiahConvert.format(custom.totalHarga)}",
                                  style: GoogleFonts.montserrat(
                                      fontSize: getAdaptiveTextSize(context, 16),
                                      fontWeight: FontWeight.w500)),
                              Text(
                                  "Down Payment: ${rupiahConvert.format(custom.customs!.first.dp)}",
                                  style: GoogleFonts.montserrat(
                                      fontSize: getAdaptiveTextSize(context, 16),
                                      fontWeight: FontWeight.w500)),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: SizedBox(
                                          width: 250,
                                          child: Text(
                                                                        "* pelunasan akan dilakukan saat barang telah diterima",
                                                                        style: GoogleFonts.montserrat(
                                          fontSize: getAdaptiveTextSize(context, 12),
                                          fontWeight: FontWeight.w300), textAlign: TextAlign.center,),
                                        ),
                                      ),
                              // ini input text atau form
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  changeStatus("Belum_Bayar");
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
                                        'SETUJU',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: getAdaptiveTextSize
                                              (context, 18),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // pay now
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  changeStatus("Gagal");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.red[500],
                                  ),
                                  padding: const EdgeInsets.all(24),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'TOLAK',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: getAdaptiveTextSize
                                              (context, 18),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // pay now
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
        );
      },
    );
  }

  void showPesananDiterimaDialog() async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Selesaikan Pemesanan?',
          style:
              GoogleFonts.montserrat(fontSize: getAdaptiveTextSize(context, 18),
              fontWeight: FontWeight
                  .bold),
        ),
        content: Text(
          'Klik tombol \"OK\" jika pesanan'
          ' anda telah diterima.',
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
      context.read<TransactionCustomBloc>().add(
          GetTransactionCustomLists(state.userModel.token.toString()));
    }
  }

  void checkCustomConfirmation() {
    final state = context.read<TransactionCustomBloc>().state;
    if (state is TransactionCustomLoaded) {
      var custom =
          state.data.details!.firstWhere((e) => e.id == widget.transactionId);
      if (custom.status == "Pending" &&
          custom.customs!.first.dp != 0 &&
          custom.totalHarga != 0) {
        bottomSheet(context);
      }
    }
  }

  void changeStatus(String status) {
    var auth = AuthBloc().state;
    if (auth is AuthLoaded) {
      context.read<TransactionCustomBloc>().add(ChangeTransactionCustomStatus(
          widget.transactionId.toString(), "${status}", auth.userModel.token));
      restartBlocs();
      Navigator.popUntil(
          context,
          (route) =>
              route.settings.name ==
              "/menunggu-pembayaran-custom");
    }
  }

  void loadBloc() {
    var auth = AuthBloc().state;
    if (auth is AuthLoaded) {
      context
          .read<TransactionCustomBloc>()
          .add(GetTransactionCustomLists(auth.userModel.token));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    loadBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Detail Custom",
                  style: GoogleFonts.montserrat(
                    fontSize: getAdaptiveTextSize(context, 24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // spacing
            const SizedBox(
              height: 10,
            ),

            BlocConsumer<TransactionCustomBloc, TransactionCustomState>(
              listener: (context, state) {
                if (state is TransactionCustomLoaded) {
                  checkCustomConfirmation();
                }
              },
              builder: (context, state) {
                if (state is TransactionCustomLoaded) {
                  var custom = state.data.details!
                      .firstWhere((e) => e.id == widget.transactionId);
                  return BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, astate) {
                      if (astate is AuthLoaded) {
                        var auth = astate.userModel.user!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Status: ",
                                  style: GoogleFonts.montserrat(
                                      fontSize: getAdaptiveTextSize(context, 14),
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: statusColorizer("${custom.status}"),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 4),
                                    child: Text(
                                      truncateWithEllipsis(20, "${custom.status}"),
                                      style: GoogleFonts.montserrat(
                                        fontSize: getAdaptiveTextSize(context, 14),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Status Custom: ${custom.customs!.first.status}",
                              style: GoogleFonts.montserrat(
                                  fontSize: getAdaptiveTextSize(context, 14),
                                  fontWeight:
                              FontWeight.w600),
                            ),
                            // divider
                            divider(),
                            // nomor virtual account

                            Text(
                              "Alamat Pengiriman",
                              style: GoogleFonts.montserrat(
                                  fontSize: getAdaptiveTextSize(context, 18),
                                  fontWeight:
                              FontWeight.w600),
                            ),

                            // inside
                            Text(
                              "${custom.alamat}",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400),
                            ),

                            // spacing
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      }
                      return SizedBox();
                    },
                  );
                }
                return SizedBox();
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
                child:
                    BlocBuilder<TransactionCustomBloc, TransactionCustomState>(
                  builder: (context, state) {
                    if (state is TransactionCustomLoaded) {
                      var custom = state.data.details!
                          .firstWhere((e) => e.id == widget.transactionId);
                      return RefreshIndicator(
                        onRefresh: () async {
                          loadBloc();
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: outlineBasic(),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 40),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: Text(
                                        "Furnitur yang "
                                        "diajukan",
                                        style: GoogleFonts.montserrat(
                                            fontSize: getAdaptiveTextSize
                                              (context, 18),
                                            fontWeight: FontWeight.bold),
                                      )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      divider(),
                                      Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Center(
                                            child: Text(
                                          "Judul: ${custom.customs!.first.name}",
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600),
                                        )),
                                      ),
                                      divider(),
                                      Text(
                                        "Jenis: ${custom.customs!.first.jenisCustom}",
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "Bahan: ${custom.customs!.first.bahan}",
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "Deskripsi: ${custom.customs!.first.desc}",
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      divider(),
                                      Text(
                                        "Down Payment: "
                                        "${custom.customs!.first.dp != 0 ? rupiahConvert.format(custom.customs!.first.dp) : "Menunggu Konfirmasi"}",
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "Total Harga: "
                                        "${custom.totalHarga != 0 ? rupiahConvert.format(custom.totalHarga) : "Menunggu Konfirmasi"}",
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return loading();
                  },
                ),
              ),
            )),

            // spacing
            const SizedBox(
              height: 20,
            ),

            BlocBuilder<TransactionCustomBloc, TransactionCustomState>(
              builder: (context, state) {
                if (state is TransactionCustomLoaded) {
                  var custom = state.data.details!
                      .firstWhere((e) => e.id == widget.transactionId);
                  return custom.status != "Dikirim"
                      ? const SizedBox()
                      : InkWell(
                          onTap: () async {
                            showPesananDiterimaDialog();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: custom.status != "Dikirim"
                                  ? Colors.black38
                                  : Colors.black,
                            ),
                            padding: const EdgeInsets.all(24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "PESANAN DITERIMA",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: getAdaptiveTextSize(context, 16),
                                      fontWeight: FontWeight.bold),
                                ),
                                // pay now
                              ],
                            ),
                          ),
                        );
                }
                return SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
