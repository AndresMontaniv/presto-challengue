import '../domain.dart';

abstract class MerchantsRepository {
  Future<List<FavMerchant>> getFavorites();
  Future<List<Merchant>> search(String query);
  Future<void> addFavorite(String merchandId);
}
