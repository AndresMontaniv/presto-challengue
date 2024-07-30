import '../../domain/domain.dart';

class MerchantsRepositoryImpl implements MerchantsRepository {
  final MerchantsDatasource datasource;

  MerchantsRepositoryImpl({required this.datasource});

  @override
  Future<void> addFavorite(String merchandId) => datasource.addFavorite(merchandId);

  @override
  Future<List<FavMerchant>> getFavorites() => datasource.getFavorites();

  @override
  Future<List<Merchant>> search(String query) => datasource.search(query);
}
