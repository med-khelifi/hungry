import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/core/utils/pref_helper.dart';
import 'package:hungry/core/utils/response.dart';
import 'package:hungry/features/auth/data/user_model.dart';

class AuthRepo {
  final ApiService _apiService = ApiService();

  Future<Response<UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _apiService.post('/login', {
        'email': email,
        'password': password,
      });

      if (result is ApiError) {
        return Response.failure(result);
      }

      if (result == null) {
        return Response.failure(ApiError(message: 'Unknown error'));
      }
      int code = result["code"] ?? 500;
      if (code < 200 || code > 299) {
        return Response.failure(
          ApiError(message: result["message"] ?? "Unknown backend error"),
        );
      }

      final user = UserModel.fromJson(result["data"]);

      if (user.token != null && user.token!.isNotEmpty) {
        await PrefHelper.saveToken(user.token!);
      }
      return Response.success(user);
    } catch (e) {
      return Response.failure(ApiError(message: e.toString()));
    }
  }

  Future<Response<UserModel>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _apiService.post('/register', {
        'name': name,
        'email': email,
        'password': password,
      });

      if (result is ApiError) {
        return Response.failure(result);
      }

      if (result == null) {
        return Response.failure(ApiError(message: 'Unknown error'));
      }
      int code = result["code"] ?? 500;
      if (code < 200 || code > 299) {
        return Response.failure(
          ApiError(message: result["message"] ?? "Unknown backend error"),
        );
      }

      final user = UserModel.fromJson(result["data"]);

      if (user.token != null && user.token!.isNotEmpty) {
        await PrefHelper.saveToken(user.token!);
      }
      return Response.success(user);
    } catch (e) {
      return Response.failure(ApiError(message: e.toString()));
    }
  }
}
