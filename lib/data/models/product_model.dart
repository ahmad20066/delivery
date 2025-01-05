import 'dart:convert';

class ProductModel {
  int id;
  String name;
  String description;
  String amount;
  String price;
  String image;
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'amount': amount,
      'price': price,
      'image': image,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      amount: map['amount'].toString() as String,
      price: map['price'].toString() as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
