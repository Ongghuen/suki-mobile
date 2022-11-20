import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile/logic/data/api/call.dart';
import 'package:mobile/logic/models/listing.dart';

part 'listing_event.dart';
part 'listing_state.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  ListingBloc() : super(ListingInitial()) {
    on<GetListingList>((event, emit) async{
      // TODO: implement event handler
      try {
        emit(ListingLoading());

        String apiUrl = "/api/listings";
        var res = await CallApi().getData(apiUrl);
        var body = json.decode(res.body);
        final listing = ListingModel.fromJson(body);
        print(body);

        emit(ListingLoaded(listing));

      } catch (ex, trace) {
        print("$ex $trace");
      }
    });
    on<GetDetailedListingList>((event, emit) async{
      // TODO: implement event handler
      try {
        emit(ListingLoading());

        String apiUrl = "/api/listings";
        var res = await CallApi().getData(apiUrl);
        var body = json.decode(res.body);
        final listing = ListingModel.fromJson(body);
        print(body);

        emit(ListingLoaded(listing));

      } catch (ex, trace) {
        print("$ex $trace");
      }
    });
  }
}
