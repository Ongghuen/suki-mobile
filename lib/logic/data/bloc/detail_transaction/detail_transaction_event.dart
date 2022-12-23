part of 'detail_transaction_bloc.dart';

abstract class DetailTransactionEvent extends Equatable {
  const DetailTransactionEvent();

  @override
  List<Object> get props => [];
}

class GetOngoingDetailTransactionList extends DetailTransactionEvent {
  var token;
  GetOngoingDetailTransactionList(this.token);
}

class GetDetailTransactionList extends DetailTransactionEvent {
  var transaction_id;
  var token;

  GetDetailTransactionList(this.transaction_id, this.token);
}

class AddProductToDetailTransactionList extends DetailTransactionEvent {
  var data;
  var dataDetail;
  var token;

  AddProductToDetailTransactionList(this.data, this.dataDetail, this.token);
}

class AddQTYProductToDetailTransactionList extends DetailTransactionEvent {
  var data;
  var token;

  AddQTYProductToDetailTransactionList(this.data, this.token);
}

class SubstractQTYProductToDetailTransactionList extends
DetailTransactionEvent {
  var data;
  var token;

  SubstractQTYProductToDetailTransactionList(this.data, this.token);
}

class DeleteProductToDetailTransactionList extends
DetailTransactionEvent {
  var data;
  var token;

  DeleteProductToDetailTransactionList(this.data, this.token);
}