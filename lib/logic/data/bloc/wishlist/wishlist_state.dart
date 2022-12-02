part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState extends Equatable{
  @override
    // TODO: implement props
    List<Object?> get props => [];
}

class WishlistInitial extends WishlistState {}
class WishlistLoading extends WishlistState {}
class WishlistLoaded extends WishlistState {
  WishlistModel data;
  List<String> wishlistedProduct;
  WishlistLoaded(this.data, this.wishlistedProduct);
}
class WishlistError extends WishlistState {
  String msg;
  WishlistError(this.msg);
}
