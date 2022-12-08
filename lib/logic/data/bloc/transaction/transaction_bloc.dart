import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/logic/data/api/call.dart';
import 'package:mobile/logic/models/transaction.dart';

part 'transaction_event.dart';

part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<GetTransactionLists>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(TransactionLoading());

        String apiUrl = "/api/orders";
        var res = await CallApi().getData(apiUrl, token: event.token);
        var body = json.decode(res.body);
        final data = TransactionModel.fromJson(body);
        print(data.customs);
        print(data.ongoing!.id);
        print(data.orders);

        // taroh product id aunthenticated user ke list
        // List<String> wishlisted = [];
        // for (var i = 0; i < data.results!.length; i++) {
        //   wishlisted.add(data.results![i].pivot!.productId.toString());
        // }

        emit(TransactionLoaded(data));
      } catch (ex, trace) {
        emit(TransactionError("sum ting wong"));
        print("$ex $trace");
      }
    });
  }
}
