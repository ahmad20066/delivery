import 'dart:convert';

import 'package:deliveryapp/data/models/product_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StoreModel {
  final int id;
  final String name;
  final String description;
  final String image;
  List<ProductModel> products;
  StoreModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      products: List<ProductModel>.from(
        (map['products'] as List<int>).map<ProductModel>(
          (x) => ProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreModel.fromJson(String source) =>
      StoreModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
