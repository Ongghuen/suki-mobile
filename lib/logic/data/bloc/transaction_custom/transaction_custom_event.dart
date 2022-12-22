part of 'transaction_custom_bloc.dart';

abstract class TransactionCustomEvent extends Equatable {
  const TransactionCustomEvent();

  @override
  List<Object> get props => [];
}

class GetTransactionCustomLists extends TransactionCustomEvent {
  var token;

  GetTransactionCustomLists(this.token);
}

class RequestTransactionCustom extends TransactionCustomEvent {
  var data;
  var token;

  RequestTransactionCustom(this.data, this.token);
}

class ChangeTransactionCustomStatus extends TransactionCustomEvent {
  String status;
  var transactionId;
  var token;

  ChangeTransactionCustomStatus(this.transactionId, this.status, this.token);
}
