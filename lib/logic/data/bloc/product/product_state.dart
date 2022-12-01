part of 'product_bloc.dart';

@immutable
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class ProductLoaded extends ProductState {
  final ProductModel productModel;
  ProductLoaded(this.productModel);
}
class ProductError extends ProductState {
  final String? msg;
  ProductError(this.msg);
}
