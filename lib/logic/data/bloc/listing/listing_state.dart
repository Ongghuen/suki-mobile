part of 'listing_bloc.dart';

@immutable
abstract class ListingState extends Equatable {
  const ListingState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ListingInitial extends ListingState {}
class ListingLoading extends ListingState {}
class ListingLoaded extends ListingState {
  final ListingModel listingModel;
  ListingLoaded(this.listingModel);
}
class ListingError extends ListingState {
  final String? msg;
  ListingError(this.msg);
}
