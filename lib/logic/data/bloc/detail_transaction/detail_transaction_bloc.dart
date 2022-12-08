import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_transaction_event.dart';
part 'detail_transaction_state.dart';

class DetailTransactionBloc extends Bloc<DetailTransactionEvent, DetailTransactionState> {
  DetailTransactionBloc() : super(DetailTransactionInitial()) {
    on<DetailTransactionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
