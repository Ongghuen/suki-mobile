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
        print(event.token);
        var body = json.decode(res.body);
        final data = WishlistModel.fromJson(body);
        print(body);

        emit(WishlistLoaded(data));
      } catch (ex, trace) {
        emit(WishlistError("sum ting wong"));
        print("$ex $trace");
      }
    });
  }
}
