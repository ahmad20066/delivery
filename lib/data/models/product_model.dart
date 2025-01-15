import 'dart:convert';

class ProductModel {
  int id;
  String name;
  String description;
  int amount;
  String price;
  String image;
  int? order_id;
  String? location;
  ProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.amount,
      required this.price,
      required this.image,
      this.location,
      this.order_id});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'amount': amount,
      'price': price,
      'image': image,
      'location': location
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        id: map['id'] as int,
        name: map['name'] as String,
        description: map['description'] as String,
        amount: map['amount'],
        price: map['price'].toString() as String,
        image: map['image'] as String,
        order_id: map['order_id']);
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
