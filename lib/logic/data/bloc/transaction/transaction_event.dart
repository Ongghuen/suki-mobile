part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class GetAllTransactionLists extends TransactionEvent {
  var token;

  GetAllTransactionLists(this.token);
}

class CheckoutTransactionLists extends TransactionEvent {
  var data;
  var token;

  CheckoutTransactionLists(this.data, this.token);
}

class ChangeTransactionStatus extends TransactionEvent {
  var transactionId;
  String status;
  var token;

  ChangeTransactionStatus(this.transactionId, this.status, this.token);
}
