import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/core/utils/response.dart';
import 'order_item_model.dart';

class OrderHistoryRepo {
  late ApiService _apiService;

  OrderHistoryRepo() {
    _apiService = ApiService();
  }
  Future<Response<List<OrderItemModel>>> getOrderHistory() async {
    try {
      final result = await _apiService.get("/orders");

      if (result is ApiError) {
        return Response.failure(result);
      }

      final data = result.data;

      if (data == null || data is! Map) {
        return Response.failure(ApiError(message: 'Invalid backend response'));
      }

      int code = int.tryParse(data["code"].toString()) ?? 500;

      if (code < 200 || code > 299) {
        return Response.failure(
          ApiError(message: data["message"] ?? "Unknown backend error"),
        );
      }

      final orders = data["data"] as List<dynamic>;

      final parsedOrders = orders
          .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return Response.success(parsedOrders);
    } catch (e) {
      return Response.failure(ApiError(message: e.toString()));
    }
  }

}