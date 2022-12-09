import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/logic/data/api/call.dart';
import 'package:mobile/logic/models/detail_transaction.dart';

part 'detail_transaction_event.dart';

part 'detail_transaction_state.dart';

class DetailTransactionBloc
    extends Bloc<DetailTransactionEvent, DetailTransactionState> {
  DetailTransactionBloc() : super(DetailTransactionInitial()) {
    on<GetOngoingDetailTransactionList>((event, emit) async {
      try {
        emit(DetailTransactionLoading());

        String apiUrl = "/api/orders/detail";
        var res = await CallApi().getData(apiUrl, token: event.token);
        var body = json.decode(res.body);
        final data = DetailTransactionModel.fromJson(body);
        emit(DetailTransactionLoaded(data));
      } catch (ex, trace) {
        emit(DetailTransactionError("sum ting wong"));
      }
    });
    on<GetDetailTransactionList>((event, emit) async {
      try {
        emit(DetailTransactionLoading());

        String apiUrl = "/api/orders/${event.transaction_id}";
        var res = await CallApi().getData(apiUrl, token: event.token);
        var body = json.decode(res.body);
        final data = DetailTransactionModel.fromJson(body);
        print(data.results!.first.id);

        emit(DetailTransactionLoaded(data));
      } catch (ex, trace) {
        emit(DetailTransactionError("sum ting wong"));
      }
    });
    on<AddProductToDetailTransactionList>((event, emit) async {
      try {
        emit(DetailTransactionLoading());

        String apiUrl = "/api/orders/detail";
        var res =
            await CallApi().postData(apiUrl,data: event.data, token: event
                .token);
        if (res.statusCode == 200) {
          print("MASUK????");
        }
        add(GetOngoingDetailTransactionList(event.token));
      } catch (ex, trace) {
        emit(DetailTransactionError("sum ting wong"));
      }
    });
  }
}
