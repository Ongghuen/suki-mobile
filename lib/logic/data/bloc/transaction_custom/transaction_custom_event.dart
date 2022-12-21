part of 'transaction_custom_bloc.dart';

abstract class TransactionCustomEvent extends Equatable {
  const TransactionCustomEvent();

  @override
  List<Object> get props => [];
}

class GetTransactionCustom extends TransactionCustomEvent {
  var data;
  GetTransactionCustom(this.data);
}
