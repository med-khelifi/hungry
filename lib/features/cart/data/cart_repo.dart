import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/core/utils/response.dart';
import 'package:hungry/features/cart/data/cart_model.dart';

class CartRepo {

  late ApiService _apiService;

  CartRepo(){
    _apiService = ApiService();
  }

  Future<Response<CartModel>> fetchCart() async {
    try {
      final result = await _apiService.get('/cart');
      if (result is ApiError) {
        return Response.failure(result);
      }

      // data section from response
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
      // extract products data
      final cartData = data["data"];
      if (cartData == null) {
        return Response.failure(ApiError(message: "Invalid products object"));
      }
      final cart = CartModel.fromJson(cartData);

      return Response.success(cart);
    } catch (e) {
      return Response.failure(ApiError(message: e.toString()));
    }
  }

  Future<Response<bool>> deleteItemFromCart(int itemId) async {
    try {
      final result = await _apiService.delete(endpoint: '/cart/remove/$itemId');
      if (result is ApiError) {
        return Response.failure(result);
      }

      // data section from response
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

      return Response.success(true);
    } catch (e) {
      return Response.failure(ApiError(message: e.toString()));
    }
  }
}