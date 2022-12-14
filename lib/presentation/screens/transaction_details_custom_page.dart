import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/logic/data/api/call.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/detail_transaction/detail_transaction_bloc.dart';
import 'package:mobile/logic/data/bloc/product/product_bloc.dart';
import 'package:mobile/logic/data/bloc/transaction/transaction_bloc.dart';
import 'package:mobile/presentation/screens/dashboard_screen/main_page.dart';
import 'package:mobile/presentation/utils/components/snackbar.dart';
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
          MaterialPageRoute(builder: (context) => MainPage()),
          ModalRoute.withName("/main"));
    }
  }

  void showPesananDiterimaDialog() async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Selesaikan Pemesanan?',
          style:
          GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold),
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
                        Navigator.pop(context);
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Detail Transaksi LMAO",
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

                              Text(
                                "Status: ${checkout.status}",
                                style: GoogleFonts.montserrat(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              // divider
                              divider(),
                              // nomor virtual account

                              Text(
                                "Alamat Pengiriman",
                                style: GoogleFonts.montserrat(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),

                              // inside
                              Text(
                                "${checkout.alamat}",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400),
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
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.data.results!.length,
                              itemBuilder: (context, index) {
                                return BlocBuilder<ProductBloc, ProductState>(
                                    builder: (_, pstate) {
                                      if (pstate is ProductLoaded) {
                                        var product = pstate.productModel.results!
                                            .where((element) =>
                                        element.id ==
                                            state.data.results![index].pivot!
                                                .productId);

                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  children: [
                                                    product.first.image == null
                                                        ? ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          15),
                                                      child: Container(
                                                        height: 100,
                                                        width: 100,
                                                        child: Icon(
                                                          Icons.inventory,
                                                        ),
                                                      ),
                                                    )
                                                        : ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          15),
                                                      child: Image.network(
                                                        "${apiUrlStorage}/${product.first.image}",
                                                        fit: BoxFit.fill,
                                                        height: 100,
                                                        width: 100,
                                                        // Better way to load images from network flutter
                                                        // https://stackoverflow.com/questions/53577962/better-way-to-load-images-from-network-flutter
                                                        loadingBuilder: (BuildContext
                                                        context,
                                                            Widget child,
                                                            ImageChunkEvent?
                                                            loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) return child;
                                                          return Center(
                                                            child:
                                                            CircularProgressIndicator(
                                                              value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                                  null
                                                                  ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                                  : null,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 100,
                                                      width: 150,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "${product.first.name}",
                                                            style:
                                                            GoogleFonts.montserrat(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                          Text(
                                                              "Rp.${product.first.harga},00"),
                                                          Text(
                                                              "${state.data.results![index].pivot!.qty} barang"),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return CircularProgressIndicator();
                                    });
                              },
                            );
                          }
                          return loading();
                        },
                      ),
                    ),
                  )),

              // spacing
              SizedBox(
                height: 20,
              ),

              BlocBuilder<DetailTransactionBloc, DetailTransactionState>(
                builder: (context, state) {
                  if (state is DetailTransactionLoaded) {
                    var checkout = state.data.details
                        .firstWhere((e) => e.id == widget.transactionId);
                    return checkout.status != "Dikirim" ? Text("") : InkWell(
                      onTap: () async {
                        showPesananDiterimaDialog();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: checkout.status != "Dikirim" ? Colors.black38 :
                          Colors.black,
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "PESANAN DITERIMA",
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
