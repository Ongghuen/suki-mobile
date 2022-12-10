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

        List<String> oncart = [];
        for (var i = 0; i < data.results!.length; i++) {
          oncart.add(data.results![i].pivot!.productId.toString());
        }
        print(oncart);

        emit(DetailTransactionLoaded(data, oncart));
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

        List<String> oncart = [];
        for (var i = 0; i < data.results!.length; i++) {
          oncart.add(data.results![i].pivot!.productId.toString());
        }

        emit(DetailTransactionLoaded(data, oncart));
      } catch (ex, trace) {
        emit(DetailTransactionError("sum ting wong"));
      }
    });
    on<AddProductToDetailTransactionList>((event, emit) async {
      try {
        emit(DetailTransactionLoading());

        String apiUrl = "/api/orders/detail";
        var res = await CallApi()
            .postData(apiUrl, data: event.data, token: event.token);
        if (res.statusCode == 200) {
          print("MASUK????");
        }
        add(GetOngoingDetailTransactionList(event.token));
      } catch (ex, trace) {
        emit(DetailTransactionError("sum ting wong"));
      }
    });
    on<AddQTYProductToDetailTransactionList>((event, emit) async {
      print("ini nambah");
      add(GetOngoingDetailTransactionList(event.token));
    });
    on<SubstractQTYProductToDetailTransactionList>((event, emit) async {
      print("ini ngurang");
      add(GetOngoingDetailTransactionList(event.token));
    });
    on<DeleteProductToDetailTransactionList>((event, emit) async {
      try {
        emit(DetailTransactionLoading());

        String apiUrl = "/api/orders/detail";
        var res = await CallApi()
            .deleteData(apiUrl, data: event.data, token: event.token);
        if (res.statusCode == 200) {
          print("KEAPUS HAHAY");
        }
        add(GetOngoingDetailTransactionList(event.token));
      } catch (ex, trace) {
        emit(DetailTransactionError("sum ting wong"));
      }
      add(GetOngoingDetailTransactionList(event.token));
    });
  }
}
