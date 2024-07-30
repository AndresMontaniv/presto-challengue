part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnSearchEvent extends SearchEvent {
  final String query;
  const OnSearchEvent(this.query);
}

class OnLoadFavoritesEvent extends SearchEvent {
  const OnLoadFavoritesEvent();
}

class OnAddFavoriteEvent extends SearchEvent {
  final String merchantId;
  const OnAddFavoriteEvent(this.merchantId);
}
