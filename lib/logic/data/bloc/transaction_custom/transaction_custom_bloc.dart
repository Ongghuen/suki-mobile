import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/logic/data/bloc/transaction/transaction_bloc.dart';

part 'transaction_custom_event.dart';
part 'transaction_custom_state.dart';

class TransactionCustomBloc extends Bloc<TransactionCustomEvent, TransactionCustomState> {
  TransactionCustomBloc() : super(TransactionCustomInitial()) {
    on<GetTransactionCustom>((event, emit) {
      print(event.data);
    });
  }
}
