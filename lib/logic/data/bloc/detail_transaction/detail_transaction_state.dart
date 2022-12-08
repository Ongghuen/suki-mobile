part of 'detail_transaction_bloc.dart';

abstract class DetailTransactionState extends Equatable {
  const DetailTransactionState();

  @override
  List<Object> get props => [];
}

class DetailTransactionInitial extends DetailTransactionState {}
