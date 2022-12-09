import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile/logic/data/api/call.dart';
import 'package:mobile/logic/models/wishlist.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<GetWishlistUserList>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(WishlistLoading());

        String apiUrl = "/api/wishlists";
        var res = await CallApi().getData(apiUrl, token: event.token);
        var body = json.decode(res.body);
        final data = WishlistModel.fromJson(body);

        // taroh product id aunthenticated user ke list
        List<String> wishlisted = [];
        for (var i = 0; i < data.results!.length; i++) {
          wishlisted.add(data.results![i].pivot!.productId.toString());
        }

        emit(WishlistLoaded(data, wishlisted));
      } catch (ex, trace) {
        emit(WishlistError("sum ting wong"));
        print("$ex $trace");
      }
    });

    on<AddProductToWishlist>((event, emit) async {
      String apiUrl = "/api/wishlists";
      await CallApi().postData(apiUrl, data: event.productId, token: event
          .token);
      add(GetWishlistUserList(event.token));
    });

    on<DeleteProductFromWishlist>((event, emit) async {
      String apiUrl = "/api/wishlists/${event.productId}";
      await CallApi().deleteData(apiUrl, token: event.token);
      add(GetWishlistUserList(event.token));
    });
  }
}
