import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';
import 'package:mobile/logic/data/bloc/detail_transaction/detail_transaction_bloc.dart';
import 'package:mobile/logic/data/bloc/product/product_bloc.dart';
import 'package:mobile/logic/data/bloc/wishlist/wishlist_bloc.dart';
import 'package:mobile/presentation/utils/components/snackbar.dart';
import 'package:mobile/presentation/utils/default.dart';

class DetailProduct extends StatefulWidget {
  final int productId;

  const DetailProduct({Key? key, required this.productId}) : super(key: key);

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is ProductLoaded) {
        var product = state.productModel.results!
            .where((element) => element.id == widget.productId);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
          ),

          //
          body: Column(
            children: [
              Expanded(
                child: SizedBox(
                  height: size.height / 1.8,
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: product.first.image == null
                              ? const SizedBox(
                                  width: 50,
                                  child: Icon(Icons.inventory),
                                )
                              : Image.network(
                                  "${apiUrlStorage}${product.first.image}",
                                  fit: BoxFit.fill,
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
                                ))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * 0.8,
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  "${product.first.name}",
                                  style: GoogleFonts.montserrat(
                                      fontSize: getAdaptiveTextSize(context, 32),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Text(
                              "${rupiahConvert.format(product.first.harga)}",
                              style: GoogleFonts.montserrat(fontSize:
                              getAdaptiveTextSize(context, 18)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(parent:
                      BouncingScrollPhysics()),
                      child: SizedBox(
                        height: size.height * 0.20,
                        child: Text(
                          "${product.first.desc}",
                          style: GoogleFonts.montserrat(fontSize:
                          getAdaptiveTextSize(context, 14)), textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: BlocBuilder<WishlistBloc, WishlistState>(
                              builder: (_, wstate) {
                            if (wstate is WishlistLoaded) {
                              return IconButton(
                                color: Colors.black,
                                onPressed: () {
                                  final astate = context.read<AuthBloc>().state;

                                  if (astate is AuthLoaded) {
                                    String productId =
                                        product.first.id.toString();

                                    var data = {"product_id": productId};

                                    wstate.wishlistedProduct.contains(productId)
                                        ? context.read<WishlistBloc>().add(
                                            DeleteProductFromWishlist(
                                                productId,
                                                astate.userModel.token
                                                    .toString()))
                                        : context.read<WishlistBloc>().add(
                                            AddProductToWishlist(
                                                data,
                                                astate.userModel.token
                                                    .toString()));
                                  }
                                },
                                icon: Icon(wstate.wishlistedProduct
                                        .contains(product.first.id.toString())
                                    ? Icons.favorite_outlined
                                    : Icons.favorite_outline),
                                iconSize: 36,
                              );
                            }
                            return IconButton(
                                iconSize: 36,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.heart_broken,
                                  color: Colors.black,
                                ));
                          }),
                        ),
                        Expanded(
                          child: Container(
                            height: size.height * 0.06,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: BlocBuilder<DetailTransactionBloc,
                                DetailTransactionState>(
                              builder: (context, state) {
                                return BlocBuilder<ProductBloc, ProductState>(
                                  builder: (context, pstate) {
                                    return GestureDetector(
                                      onTap: () async {
                                        if (pstate is ProductLoaded) {
                                          var product = pstate
                                              .productModel.results!
                                              .firstWhere((e) =>
                                                  e.id == widget.productId);
                                          if (state
                                              is DetailTransactionLoaded) {
                                            if (state.oncart.contains(
                                                widget.productId.toString())) {
                                              showSnackbar(
                                                  context, "Product Sudah Ada Di Keranjang");
                                            } else {
                                              var data = {
                                                "product_id":
                                                    widget.productId.toString()
                                              };

                                              var dataDetail = {
                                                "product_id": "${product.id}",
                                                "qty": "1",
                                                "sub_total": "${product.harga}"
                                              };

                                              final astate = context
                                                  .read<AuthBloc>()
                                                  .state;
                                              if (astate is AuthLoaded) {
                                                context
                                                    .read<
                                                        DetailTransactionBloc>()
                                                    .add(
                                                        AddProductToDetailTransactionList(
                                                            data, dataDetail,
                                                            astate.userModel
                                                                .token!));
                                                showSnackbar(
                                                    context, "Product Berhasil Dimasukkan Ke Keranjang");
                                              } else {
                                                showSnackbar(context, "Gagal");
                                              }
                                            }
                                          }
                                        }
                                      },
                                      child: const Center(
                                        child: Text(
                                          'Tambah ke Keranjang',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.02,)
                  ],
                ),
              )
            ],
          ),
        );
      }
      return const CircularProgressIndicator();
    });
  }
}
