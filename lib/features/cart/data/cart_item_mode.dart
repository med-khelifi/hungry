import 'package:hungry/core/utils/helpers.dart';
import 'package:hungry/features/productDetails/data/topping_option_model.dart';

class CartItemMode {
  final int itemId;
  final int productId;
  final String name;
  final String image;
  final int quantity;
  final double price;
  final double spicy;
  final List<ToppingOptionModel> toppings;
  final List<ToppingOptionModel> sideOptions;
  CartItemMode({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  factory CartItemMode.fromJson(Map<String, dynamic> json) {
    return CartItemMode(
      itemId: json['item_id'] as int,
      productId: json['product_id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      quantity: json['quantity'] as int,
      price: Helpers.parseDouble(json['price']),
      spicy: Helpers.parseDouble(json['spicy']),
      toppings: (json['toppings'] as List)
          .map((e) => ToppingOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sideOptions: (json['side_options'] as List)
          .map((e) => ToppingOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'product_id': productId,
      'name': name,
      'image': image,
      'quantity': quantity,
      'price': price,
      'spicy': spicy,
      'toppings': toppings.map((e) => e.toJson()).toList(),
      'side_options': sideOptions.map((e) => e.toJson()).toList(),
    };
  }
}