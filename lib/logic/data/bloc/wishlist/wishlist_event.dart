part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetWishlistUserList extends WishlistEvent {
  String token;
  GetWishlistUserList(this.token);
}

class AddProductToWishlist extends WishlistEvent {
  var productId;
  String token;
  AddProductToWishlist(this.productId, this.token);
}

class DeleteProductFromWishlist extends WishlistEvent {
  var productId;
  String token;
  DeleteProductFromWishlist(this.productId, this.token);
}
