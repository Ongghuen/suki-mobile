import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/logic/data/bloc/product/product_bloc.dart';
import 'package:mobile/logic/data/bloc/wishlist/wishlist_bloc.dart';
import 'package:mobile/presentation/utils/default.dart';

void main(List<String> args) {
  runApp(WishlistPage());
}

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Let's order fresh items for you
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Wishlist",
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // list view of wishlist
          BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state) {
              if (state is WishlistInitial) {
                return const Text("LOADING MAZ");
              } else if (state is WishlistLoaded) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.data.results!.length,
                  itemBuilder: (context, index) {
                    return BlocBuilder<ProductBloc, ProductState>(
                        builder: (_, pstate) {
                      if (pstate is ProductLoaded) {
                        var product = pstate.productModel.results!.where(
                            (element) =>
                                element.id ==
                                state.data.results![index].pivot!.productId);

                        return Container(
                          margin: EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Card(
                              child: Container(
                                margin: EdgeInsets.all(8.0),
                                child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    product.first.image == null
                                        ? SizedBox(
                                            width: 50,
                                            child: Icon(Icons.chair),
                                          )
                                        : SizedBox(
                                            width: 50,
                                            child: Image.network(
                                              "${apiUrlStorage}${product.first.image}",
                                              fit: BoxFit.fill,
                                              // Better way to load images from network flutter
                                              // https://stackoverflow.com/questions/53577962/better-way-to-load-images-from-network-flutter
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
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
                                    Column(
                                      children: <Widget>[
                                        Text(
                                            "${state.data.results![index].name}"),
                                        Text(
                                            "Rp.${state.data.results![index].harga},00"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    });
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
