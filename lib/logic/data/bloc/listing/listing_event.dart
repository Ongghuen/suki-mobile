part of 'listing_bloc.dart';

@immutable
abstract class ListingEvent extends Equatable {
  const ListingEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetListingList extends ListingEvent {}
class GetDetailedListingList extends ListingEvent {}
