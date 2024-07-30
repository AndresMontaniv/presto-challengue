import 'dart:convert';

import 'package:flutter/material.dart' show debugPrint;
import 'package:http/http.dart' as http;

import '../data.dart';
import '../../domain/domain.dart';

class MerchantsDatasourceImpl implements MerchantsDatasource {
  final String baseUrl;
  final String apiUrl;

  MerchantsDatasourceImpl({required this.baseUrl, required this.apiUrl});

  @override
  Future<void> addFavorite(String merchandId) async {
    try {
      final url = Uri.parse('$apiUrl/save/favorite-merchant');
      await http.post(
        url,
        body: {"merchantId": merchandId, "amountPayment": "10"},
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<List<FavMerchant>> getFavorites() async {
    try {
      final url = Uri.parse('$apiUrl/favorites/merchant');
      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final listJson = json.decode(resp.body) as List;
        return listJson.map((item) => FavMerchantModel.fromMap(item).toFavMerchantEntity()).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  @override
  Future<List<Merchant>> search(String query) async {
    try {
      final url = Uri.https(
        baseUrl,
        'challengue/search/merchant',
        {'searchTerm': query},
      );
      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final respJson = json.decode(resp.body)['data'] as List;
        return respJson.map((item) => MerchantModel.fromMap(item).toMerchantEntity()).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }
}
