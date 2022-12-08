part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}
class TransactionLoading extends TransactionState {}
class TransactionLoaded extends TransactionState {
  var data;
  TransactionLoaded(this.data);
}
class TransactionError extends TransactionState {
  String msg;
  TransactionError(this.msg);
}
