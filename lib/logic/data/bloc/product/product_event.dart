part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetProductList extends ProductEvent {}
class GetDetailedProductList extends ProductEvent {
  int id;
  GetDetailedProductList(this.id);
}
