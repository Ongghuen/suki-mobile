import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
  // @override
  // void initState() {
  //   final pstate = context.read<ProductBloc>().state;
  //   if (pstate is ProductLoaded) {
  //     var product = pstate.productModel.results!
  //         .where((element) => element.id == widget.productId);
  //   }
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

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
            actions: [
              BlocBuilder<WishlistBloc, WishlistState>(builder: (_, wstate) {
                if (wstate is WishlistLoaded) {
                  return IconButton(
                      color: Colors.black,
                      onPressed: () {
                        final astate = context.read<AuthBloc>().state;

                        if (astate is AuthLoaded) {
                          String productId = product.first.id.toString();

                          var data = {"product_id": productId};

                          wstate.wishlistedProduct.contains(productId)
                              ? context.read<WishlistBloc>().add(
                                  DeleteProductFromWishlist(productId,
                                      astate.userModel.token.toString()))
                              : context.read<WishlistBloc>().add(
                                  AddProductToWishlist(
                                      data, astate.userModel.token.toString()));
                        }
                      },
                      icon: Icon(wstate.wishlistedProduct
                              .contains(product.first.id.toString())
                          ? Icons.favorite_outlined
                          : Icons.favorite_outline));
                }
                return IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.heart_broken,
                      color: Colors.black,
                    ));
              })
            ],
          ),

          //
          body: Column(
            children: [
              SizedBox(
                height: height / 1.7,
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
                            Text(
                              "${product.first.name}",
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Rp.${product.first.harga},00",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      height: 100,
                      child: Text(
                        "${product.first.desc}",
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                              text: 'Total Price\n',
                            ),
                            TextSpan(
                              text: "Hahay",
                            ),
                          ]),
                        ),
                        Container(
                          height: 40.0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: BlocBuilder<DetailTransactionBloc,
                              DetailTransactionState>(
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: () {
                                  var data = {"product_id": widget.productId
                                      .toString()};
                                  final astate = context.read<AuthBloc>().state;
                                  if (astate is AuthLoaded) {
                                    context.read<DetailTransactionBloc>().add(
                                        AddProductToDetailTransactionList(
                                            data, astate.userModel.token!));
                                    print(
                                        "WOYYY====; ${data} and ${astate.userModel.token}");
                                    showSnackbar(context, "Berhasil Hore");
                                  } else {
                                    showSnackbar(context, "Gagal");
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
                          ),
                        )
                      ],
                    )
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
