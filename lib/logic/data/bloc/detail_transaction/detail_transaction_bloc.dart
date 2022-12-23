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
        if (res.statusCode != 200) {
          emit(DetailTransactionError("${body['message']}"));
        }

        final data = DetailTransactionModel.fromJson(body);

        List<String> oncart = [];
        int tempTotHarga = 0;
        for (var i = 0; i < data.results!.length; i++) {
          tempTotHarga = tempTotHarga +
              int.parse(data.results![i].pivot!.subTotal.toString());
          oncart.add(data.results![i].pivot!.productId.toString());
        }

        emit(DetailTransactionLoaded(data, oncart, tempTotHarga));
      } catch (ex, trace) {
        emit(DetailTransactionError("Cart: something's wrong"));
      }
    });
    on<GetDetailTransactionList>((event, emit) async {
      try {
        emit(DetailTransactionLoading());

        String apiUrl = "/api/orders/${event.transaction_id}";
        var res = await CallApi().getData(apiUrl, token: event.token);

        var body = json.decode(res.body);
        if (res.statusCode != 200) {
          emit(DetailTransactionError("${body['message']}"));
        }

        final data = DetailTransactionModel.fromJson(body);

        List<String> oncart = [];
        int tempTotHarga = 0;
        for (var i = 0; i < data.results!.length; i++) {
          tempTotHarga = tempTotHarga +
              int.parse(data.results![i].pivot!.subTotal.toString());
          oncart.add(data.results![i].pivot!.productId.toString());
        }

        emit(DetailTransactionLoaded(data, oncart, tempTotHarga));
      } catch (ex, trace) {
        emit(DetailTransactionError("Get: something's wrong"));
      }
    });
    on<AddProductToDetailTransactionList>((event, emit) async {
      try {
        String apiUrl = "/api/orders/detail";
        var res = await CallApi()
            .postData(apiUrl, data: event.data, token: event.token);

        var body = json.decode(res.body);
        if (res.statusCode == 200) {
          print("Add: masuk");
          add(AddQTYProductToDetailTransactionList(
              event.dataDetail, event.token));
          add(GetOngoingDetailTransactionList(event.token));
        } else {
          emit(DetailTransactionError("${body['message']}"));
        }
      } catch (ex, trace) {
        emit(DetailTransactionError("Add Product: something's wrong"));
      }
    });
    on<AddQTYProductToDetailTransactionList>((event, emit) async {
      try {
        String apiUrl = "/api/orders/detail";
        var res = await CallApi()
            .putData(apiUrl, data: event.data, token: event.token);
        var body = json.decode(res.body);
        if (res.statusCode == 200) {
          print("Add qty: masuk");
          add(GetOngoingDetailTransactionList(event.token));
        } else {
          emit(DetailTransactionError("${body['message']}"));
        }
      } catch (ex, trace) {
        emit(DetailTransactionError("Add: something's wrong"));
      }
    });

    on<SubstractQTYProductToDetailTransactionList>((event, emit) async {
      try {
        String apiUrl = "/api/orders/detail";
        var res = await CallApi()
            .putData(apiUrl, data: event.data, token: event.token);
        var body = json.decode(res.body);
        if (res.statusCode == 200) {
          print("SIP MINES");
          add(GetOngoingDetailTransactionList(event.token));
        } else {
          emit(DetailTransactionError("${body['message']}"));
        }
      } catch (ex, trace) {
        emit(DetailTransactionError("Substract: something's wrong $ex $trace"));
      }
    });

    on<DeleteProductToDetailTransactionList>((event, emit) async {
      try {
        emit(DetailTransactionLoading());

        String apiUrl = "/api/orders/detail";
        var res = await CallApi()
            .deleteData(apiUrl, data: event.data, token: event.token);
        var body = json.decode(res.body);
        if (res.statusCode == 200) {
          print("KEAPUS HAHAY");
          add(GetOngoingDetailTransactionList(event.token));
        } else {
          emit(DetailTransactionError("${body['message']}"));
        }
      } catch (ex, trace) {
        emit(DetailTransactionError("Delete: something's wrong"));
      }
    });
  }
}
