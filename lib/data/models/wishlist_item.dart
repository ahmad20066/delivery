// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:deliveryapp/data/models/product_model.dart';

class WishlistItem {
  int id;
  ProductModel product;
  WishlistItem({
    required this.id,
    required this.product,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product': product.toMap(),
    };
  }

  factory WishlistItem.fromMap(Map<String, dynamic> map) {
    return WishlistItem(
      id: map['id'] as int,
      product: ProductModel.fromMap(map['product'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory WishlistItem.fromJson(String source) =>
      WishlistItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
