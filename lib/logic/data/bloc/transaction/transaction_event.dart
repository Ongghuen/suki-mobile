part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class GetTransactionLists extends TransactionEvent {
  var token;

  GetTransactionLists(this.token);
}

class CheckoutTransactionLists extends TransactionEvent {
  var token;

  CheckoutTransactionLists(this.token);
}
