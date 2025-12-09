import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/core/utils/response.dart';

class CheckoutRepo {
  late ApiService _apiService;

  CheckoutRepo() {
    _apiService = ApiService();
  }

  Future<Response<bool>> checkout(Map<String, dynamic> orderItems) async {
    try {
      final result = await _apiService.post("/orders", orderItems);
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