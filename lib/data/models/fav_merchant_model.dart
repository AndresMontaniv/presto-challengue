import 'dart:convert';

import '../../domain/domain.dart';

class FavMerchantModel {
  final String id;
  final String merchant;
  final String merchantId;
  final int paymentAmount;
  final int v;

  FavMerchantModel({
    required this.id,
    required this.merchant,
    required this.merchantId,
    this.paymentAmount = 10,
    this.v = 0,
  });

  FavMerchantModel copyWith({
    String? id,
    String? merchant,
    int? paymentAmount,
    String? merchantId,
    int? v,
  }) =>
      FavMerchantModel(
        id: id ?? this.id,
        merchant: merchant ?? this.merchant,
        paymentAmount: paymentAmount ?? this.paymentAmount,
        merchantId: merchantId ?? this.merchantId,
        v: v ?? this.v,
      );

  factory FavMerchantModel.fromJson(String str) => FavMerchantModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavMerchantModel.fromMap(Map<String, dynamic> json) => FavMerchantModel(
        id: json["_id"],
        merchant: json["merchant"],
        merchantId: json["merchant_id"],
        paymentAmount: json["payment_amount"] ?? 10,
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "merchant": merchant,
        "merchant_id": merchantId,
        "payment_amount": paymentAmount,
        "__v": v,
      };

  FavMerchant toFavMerchantEntity() => FavMerchant(
        id: id,
        merchant: merchant,
        merchantId: merchantId,
      );
}
