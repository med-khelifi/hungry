import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/core/utils/response.dart';
import 'package:hungry/features/home/data/product_item_model.dart';

class ProductRepo {
  late ApiService apiService;
  ProductRepo() {
    apiService = ApiService();
  }

  Future<Response<List<ProductItemModel>>> fetchProducts() async {
    try {
      final result = await apiService.get('/products');
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
          .map((e) => ProductItemModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Response.success(products);
    } catch (e) {
      return Response.failure(ApiError(message: e.toString()));
    }
  }
}
