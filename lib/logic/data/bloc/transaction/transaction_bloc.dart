import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/logic/data/api/call.dart';
import 'package:mobile/logic/models/transaction.dart';

part 'transaction_event.dart';

part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<GetAllTransactionLists>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(TransactionLoading());

        String apiUrl = "/api/orders";
        var res = await CallApi().getData(apiUrl, token: event.token);
        var body = json.decode(res.body);
        final data = TransactionModel.fromJson(body);

        emit(TransactionLoaded(data));
      } catch (ex, trace) {
        emit(TransactionError("sum ting wong"));
        print("$ex $trace");
      }
    });
    on<CheckoutTransactionLists>((event, emit) async {
      try {
        String apiUrl = "/api/orders/create";
        var res = await CallApi().postData(apiUrl, token: event.token);
        if (res.statusCode == 200) {
          print("ntaps");
        }else{
          print("lmao");
        }
      } catch (ex, trace) {
        emit(TransactionError("sum ting wong"));
        print("$ex $trace");
      }
    });
  }
}
