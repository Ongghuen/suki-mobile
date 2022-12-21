part of 'transaction_custom_bloc.dart';

abstract class TransactionCustomState extends Equatable {
  const TransactionCustomState();

  @override
  List<Object> get props => [];
}

class TransactionCustomInitial extends TransactionCustomState {
}
class TransactionCustomLoading extends TransactionCustomState {
}
class TransactionCustomLoaded extends TransactionCustomState {
}
class TransactionCustomError extends TransactionCustomState {
}
