import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/detail_transaction/detail_transaction_bloc.dart';
import 'package:mobile/logic/data/bloc/product/product_bloc.dart';
import 'package:mobile/presentation/utils/default.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  TextEditingController _alamat = TextEditingController();
  var totHarga = 0;
  var totOngkos = 20000;

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
                    child: Column(
                      children: [
                        // ini input text atau form
                        TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                          controller: _alamat,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Alamat '
                                'Anda',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            var auth = context.read<AuthBloc>().state;
                            if (auth is AuthLoaded) {
                              var data = {
                                "alamat": _alamat.text,
                              };
                              if (_alamat.text == auth.userModel.user!.email) {
                                data.remove("alamat");
                              }
                              context.read<AuthBloc>().add(
                                  UserAuthUpdate(data, auth.userModel.token));
                              Navigator.pop(context);
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
                                  'UPDATE ALAMAT',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                // pay now
                              ],
                            ),
                          ),
                        ),
                      ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            // Let's order fresh items for you
            Text(
              "Checkout",
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
                  var checkout = state.data.details.firstWhere((e) =>
                      e.status ==
                          "Pendi"
                              "ng" &&
                      e.categories == "Product");
                  return BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, astate) {
                      if (astate is AuthLoaded) {
                        var auth = astate.userModel.user!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Alamat Pengiriman",
                              style: GoogleFonts.montserrat(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),

                            // spacing
                            SizedBox(
                              height: 10,
                            ),

                            // inside
                            Text(
                              "${auth.name}",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${auth.phone}",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${auth.address == null ? "- *tolong isi "
                                      "alamat terlebih dahulu" : auth.address}",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      auth.address == null
                                          ? ""
                                          : _alamat.text = auth.address!;
                                      bottomSheet(context);
                                    },
                                    child: Text("Ganti Alamat",
                                        style: textStyleDefault()))
                              ],
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

            // list view of cart
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child:
                    BlocBuilder<DetailTransactionBloc, DetailTransactionState>(
                  builder: (context, state) {
                    if (state is DetailTransactionLoaded) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.data.results!.length,
                        itemBuilder: (context, index) {
                          return BlocBuilder<ProductBloc, ProductState>(
                              builder: (_, pstate) {
                            if (pstate is ProductLoaded) {
                              var product = pstate.productModel.results!.where(
                                  (element) =>
                                      element.id ==
                                      state.data.results![index].pivot!
                                          .productId);
                              totHarga += int.parse(state
                                  .data.results![index].pivot.subTotal
                                  .toString());

                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
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
                                                      BorderRadius.circular(15),
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
                                                      BorderRadius.circular(15),
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
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    "${rupiahConvert.format(state.data.results![index].pivot.subTotal)}"),
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
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),

            // divider
            divider(),

            Column(
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

                    // total tagihan
                    BlocBuilder<DetailTransactionBloc, DetailTransactionState>(
                      builder: (context, state) {
                        if (state is DetailTransactionLoaded) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Tagihan",
                                style: GoogleFonts.montserrat(fontSize: 16),
                              ),
                              Text(
                                "${rupiahConvert.format(state.totalHarga)}",
                                style: GoogleFonts.montserrat(fontSize: 16),
                              ),
                            ],
                          );
                        }
                        return loading();
                      },
                    ),
                  ],
                ),

                // spacing
                SizedBox(
                  height: 20,
                ),
              ],
            ),

            // total amount + pay now

            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoaded) {
                  var auth = state.userModel.user!;
                  return InkWell(
                    onTap: () {
                      auth.address == null ? bottomSheet(context) :
                      Navigator.of(context)
                          .pushNamed
                        ('/transaction-confirm');
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
                            '${auth.address == null ? "GANTI ALAMAT" : "BUAT "
                                "PESANAN"}',
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
