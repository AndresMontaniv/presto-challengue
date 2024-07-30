part of 'search_bloc.dart';

class SearchState extends Equatable {
  final List<Merchant> searchResult;
  final List<FavMerchant> favorites;
  final bool isLoading;
  const SearchState({
    this.searchResult = const [],
    this.favorites = const [],
    this.isLoading = false,
  });

  SearchState copyWith({
    List<Merchant>? searchResult,
    List<FavMerchant>? favorites,
    bool? isLoading,
  }) =>
      SearchState(
        searchResult: searchResult ?? this.searchResult,
        favorites: favorites ?? this.favorites,
        isLoading: isLoading ?? this.isLoading,
      );

  bool isFavorite(String id) {
    if (favorites.isEmpty) return false;
    final ids = favorites.map((e) => e.merchantId);
    return ids.contains(id);
  }

  @override
  List<Object> get props => [
        searchResult,
        favorites,
        isLoading,
      ];
}
