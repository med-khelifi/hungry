import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/core/utils/response.dart';
import 'package:hungry/features/productDetails/data/topping_option_model.dart';

class ProductDetailsRepo {

  ProductDetailsRepo(){
    _apiService = ApiService();
  }
  late ApiService _apiService;
  Future<Response<List<ToppingOptionModel>>> fetchToppings() async {
    try {
      final result = await _apiService.get('/toppings');
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
      final productsData = data["data"];
      if (productsData == null || productsData is! List) {
        return Response.failure(ApiError(message: "Invalid products object"));
      }
      final products = productsData
          .map((e) => ToppingOptionModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Response.success(products);
    } catch (e) {
      return Response.failure(ApiError(message: e.toString()));
    }
  }

  Future<Response<List<ToppingOptionModel>>> fetchSideOptions() async {
    try {
      final result = await _apiService.get('/side-options');
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
      final productsData = data["data"];
      if (productsData == null || productsData is! List) {
        return Response.failure(ApiError(message: "Invalid products object"));
      }
      final products = productsData
          .map((e) => ToppingOptionModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Response.success(products);
    } catch (e) {
      return Response.failure(ApiError(message: e.toString()));
    }
  }

    Future<Response<bool>> addToCart(Map<String,dynamic> itemData) async {
    try {
      final result = await _apiService.post('/cart/add',itemData);
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
      return Response.success(true);
    } catch (e) {
      return Response.failure(ApiError(message: e.toString()));
    }
  }
}