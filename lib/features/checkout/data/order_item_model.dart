import 'package:hungry/core/utils/helpers.dart';
import 'package:hungry/features/productDetails/data/topping_option_model.dart';

class OrderItemModel {
  final int itemId;
  final int quantity;
  final double spicy;
  final List<ToppingOptionModel> toppings;
  final List<ToppingOptionModel> sideOptions;

  OrderItemModel({
    required this.itemId,
    required this.quantity,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      itemId: json['item_id'] as int,
      quantity: json['quantity'] as int,
      spicy: Helpers.parseDouble(json['spicy']),
      toppings: (json['toppings'] as List<dynamic>)
          .map((e) => ToppingOptionModel.fromJson(e))
          .toList(),
      sideOptions: (json['side_options'] as List<dynamic>)
          .map((e) => ToppingOptionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'quantity': quantity,
      'spicy': spicy,
      'toppings': toppings.map((e) => e.toJson()).toList(),
      'side_options': sideOptions.map((e) => e.toJson()).toList(),
    };
  }

  Map<String, dynamic> toJsonWithToppingsIds() {
    return {
      'product_id': itemId,
      'quantity': quantity,
      'spicy': spicy,
      'toppings': toppings.map((e) => e.id).toList(),
      'side_options': sideOptions.map((e) => e.id).toList(),
    };
  }

}
