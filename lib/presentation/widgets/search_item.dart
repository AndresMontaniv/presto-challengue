import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../domain/domain.dart';
import '../presentation.dart';

class SearchItem extends StatelessWidget {
  final Merchant merchant;
  const SearchItem({super.key, required this.merchant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBottomSheet(context),
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.purple,
            width: 2,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AutoSizeText(
                merchant.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: AutoSizeText(
                  merchant.category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  final isFav = state.isFavorite(merchant.id);
                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: isFav
                        ? const Icon(
                            Icons.favorite,
                            size: 30,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            size: 30,
                            color: Colors.black,
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                merchant.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  merchant.category,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    final searchBloc = BlocProvider.of<SearchBloc>(context);
                    searchBloc.add(OnAddFavoriteEvent(merchant.id));
                    Navigator.pop(context);
                  },
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.redAccent,
                    ),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  child: const Text('Add Favorite'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
