import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/logic/data/api/call.dart';
import 'package:mobile/logic/data/bloc/transaction/transaction_bloc.dart';
import 'package:mobile/logic/models/detail_transaction_custom.dart';

part 'transaction_custom_event.dart';

part 'transaction_custom_state.dart';

class TransactionCustomBloc
    extends Bloc<TransactionCustomEvent, TransactionCustomState> {
  TransactionCustomBloc() : super(TransactionCustomInitial()) {
    on<GetTransactionCustomLists>((event, emit) async {
      try {
        emit(TransactionCustomLoading());

        String apiUrl = "/api/customs";
        var res = await CallApi().getData(apiUrl, token: event.token);
        var body = json.decode(res.body);
        final data = DetailTransactionCustomModel.fromJson(body);

        emit(TransactionCustomLoaded(data));
      } catch (ex, trace) {
        emit(TransactionCustomError("sum ting wong"));
      }
    });
    on<RequestTransactionCustom>((event, emit) async {
      try {
        emit(TransactionCustomInitial());
        String apiUrl = "/api/customs/create";
        var res = await CallApi()
            .postData(apiUrl, data: event.data, token: event.token);
        var body = json.decode(res.body);
        if (res.statusCode == 200) {
          emit(TransactionCustomSuccess());
        } else {
          print(body['message']);
          emit(TransactionCustomError(body['message']));
        }
      } catch (ex, trace) {
        emit(TransactionCustomError("sum ting wong"));
        print("$ex $trace");
      }
    });
  }
}
