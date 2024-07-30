import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MerchantsRepository repository;
  SearchBloc(this.repository) : super(const SearchState()) {
    on<OnSearchEvent>(_onSearch);
    on<OnAddFavoriteEvent>(_onAddFavorite);
    on<OnLoadFavoritesEvent>(_onLoadFavorites);
    _init();
  }

  void _init() {
    add(const OnLoadFavoritesEvent());
  }

  void _onSearch(OnSearchEvent event, Emitter<SearchState> emit) async {
    if (event.query.isEmpty) {
      emit(state.copyWith(
        searchResult: [],
      ));
      return;
    }
    emit(state.copyWith(
      searchResult: [],
      isLoading: true,
    ));
    final results = await repository.search(event.query);
    emit(state.copyWith(
      searchResult: results,
      isLoading: false,
    ));
  }

  void _onLoadFavorites(OnLoadFavoritesEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(
      favorites: [],
      isLoading: true,
    ));
    final favorites = await repository.getFavorites();
    emit(state.copyWith(
      favorites: favorites,
      isLoading: false,
    ));
  }

  void _onAddFavorite(OnAddFavoriteEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(isLoading: true));
    await repository.addFavorite(event.merchantId);
    emit(state.copyWith(isLoading: false));
    add(const OnLoadFavoritesEvent());
  }
}
