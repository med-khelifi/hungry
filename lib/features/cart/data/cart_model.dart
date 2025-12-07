import 'package:hungry/core/utils/helpers.dart';
import 'package:hungry/features/cart/data/cart_item_mode.dart';

class CartModel {
  final int id;
   double totalPrice;
  final List<CartItemMode> items;
  CartModel({
    required this.id,
    required this.totalPrice,
    required this.items,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] as int,
      totalPrice:Helpers.parseDouble(json['total_price'] ),
      items: (json['items'] as List)
          .map((e) => CartItemMode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total_price': totalPrice,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}