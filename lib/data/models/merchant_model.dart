import 'dart:convert';

import '../../domain/domain.dart';

class MerchantModel {
  final String id;
  final String name;
  final String category;

  MerchantModel({
    required this.id,
    required this.name,
    required this.category,
  });

  MerchantModel copyWith({
    String? id,
    String? name,
    String? category,
  }) =>
      MerchantModel(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
      );

  factory MerchantModel.fromJson(String str) => MerchantModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MerchantModel.fromMap(Map<String, dynamic> json) => MerchantModel(
        id: json["_id"],
        name: json["name"],
        category: json["category"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "category": category,
      };

  Merchant toMerchantEntity() => Merchant(
        id: id,
        name: name,
        category: category,
      );
}
