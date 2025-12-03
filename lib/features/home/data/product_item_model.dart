import 'package:dio/dio.dart';
import 'package:hungry/core/utils/helpers.dart';

class ProductItemModel {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final double price;

  ProductItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.price,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    return ProductItemModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['image'] as String,
      rating: Helpers.parseDouble(json['rating']),
      price: Helpers.parseDouble(json['price']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': imageUrl,
      'rating': rating,
      'price': price,
    };
  }
}
