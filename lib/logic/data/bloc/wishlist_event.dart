part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent extends Equatable{
  @override
    // TODO: implement props
    List<Object?> get props => [];
}

class GetWishlistUserList extends WishlistEvent{
  String token;
  GetWishlistUserList(this.token);
}
