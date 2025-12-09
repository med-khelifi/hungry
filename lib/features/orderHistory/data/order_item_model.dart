class OrderItemModel {
  final int id;
  final String status;
  final String totalPrice;
  final String createdAt;
  final String productImage;

  OrderItemModel({
    required this.id,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
    required this.productImage,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] as int,
      status: json['status'] as String,
      totalPrice: json['total_price'] as String,
      createdAt: json['created_at'] as String,
      productImage: json['product_image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'total_price': totalPrice,
      'created_at': createdAt,
      'product_image': productImage,
    };
  }
}
