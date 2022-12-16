part of 'detail_transaction_bloc.dart';

abstract class DetailTransactionState extends Equatable {
  const DetailTransactionState();

  @override
  List<Object> get props => [];
}

class DetailTransactionInitial extends DetailTransactionState {}

class DetailTransactionLoading extends DetailTransactionState {}

class DetailTransactionLoaded extends DetailTransactionState {
  var data;
  List<String> oncart;
  int totalHarga;

  DetailTransactionLoaded(this.data, this.oncart, this.totalHarga);
}

class DetailTransactionError extends DetailTransactionState {
  String msg;

  DetailTransactionError(this.msg);
}
