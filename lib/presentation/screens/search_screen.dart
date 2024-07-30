import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';
import '../presentation.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchCtrl = TextEditingController();

  String get query => searchCtrl.text.trim();
  set query(String? text) => searchCtrl.text = text?.trim() ?? '';

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchCtrl,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: 'Search Merchants...',
            hintStyle: const TextStyle(fontSize: 14),
            border: InputBorder.none,
            suffixIcon: query.isEmpty
                ? null
                : IconButton(
                    iconSize: 20,
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      query = '';
                      setState(() {});
                      searchBloc.add(OnSearchEvent(query));
                    },
                  ),
          ),
          onChanged: (value) {
            if (value.length <= 1) {
              setState(() {});
            }
          },
          onSubmitted: (value) {
            FocusScope.of(context).unfocus();
            searchBloc.add(OnSearchEvent(query));
          },
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    if (query.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'My Favorites',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    query.isEmpty ? buildFavorites(state.favorites) : buildSearchResult(state.searchResult),
                  ],
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (query.isEmpty) {
            searchBloc.add(const OnLoadFavoritesEvent());
            return;
          }
          searchBloc.add(OnSearchEvent(query));
        },
        child: const Icon(Icons.sync_outlined),
      ),
    );
  }

  Widget buildSearchResult(List<Merchant> result) {
    return Expanded(
      child: result.isEmpty
          ? const Center(
              child: Text(
                'Nothing was found!',
                style: TextStyle(fontSize: 20),
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: result.length,
              itemBuilder: (_, index) => SearchItem(merchant: result[index]),
            ),
    );
  }

  Widget buildFavorites(List<FavMerchant> favorites) {
    return Expanded(
      child: favorites.isEmpty
          ? const Center(
              child: Text(
                'No favortes were found!',
                style: TextStyle(fontSize: 20),
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              //   maxCrossAxisExtent: 200,
              // ),
              itemCount: favorites.length,
              itemBuilder: (_, index) => FavItem(item: favorites[index]),
            ),
    );
  }
}
