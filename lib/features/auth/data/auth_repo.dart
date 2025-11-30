
import 'dart:io';

import 'package:dio/dio.dart' show FormData, MultipartFile;
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

      final userData = data["data"];

      if (userData == null || userData is! Map) {
        return Response.failure(ApiError(message: "Invalid user object"));
      }

      final user = UserModel.fromJson(userData as Map<String, dynamic>);

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
      var result = await _apiService.post('/register', {
        'name': name,
        'email': email,
        'password': password,
      });

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

      // extract user data
      final userData = data["data"];

      if (userData == null || userData is! Map) {
        return Response.failure(ApiError(message: "Invalid user object"));
      }

      final user = UserModel.fromJson(userData as Map<String, dynamic>);

      if (user.token != null && user.token!.isNotEmpty) {
        await PrefHelper.saveToken(user.token!);
      }

      return Response.success(user);
    } catch (e) {
      return Response.failure(ApiError(message: e.toString()));
    }
  }

  Future<Response<UserModel>> getCurrentUserInfo() async {
    try {
      var result = await _apiService.get('/profile');

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

      // extract user data
      final userData = data["data"];

      if (userData == null || userData is! Map) {
        return Response.failure(ApiError(message: "Invalid user object"));
      }

      final user = UserModel.fromJson(userData as Map<String, dynamic>);

      return Response.success(user);
    } catch (e) {
      return Response.failure(ApiError(message: e.toString()));
    }
  }


  Future<Response<UserModel>> updateUserInfo({
    required String name,
    required String email,
    required String address,
    String? viza,
    String? imagePath,
  }) async {
    MultipartFile? imageFile;
    if (imagePath != null) {
      imageFile = await MultipartFile.fromFile(
    imagePath,
    filename: imagePath.split('/').last,
    );
    }
    try {

      FormData formData = FormData.fromMap({
        "name": name,
        "email": email,
        "address": address,
        "Viza": viza,
        "image": imageFile ?? null,
      });

      var result = await _apiService.post(
        '/update-profile',
        formData,

      );

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

      final userData = data["data"];

      if (userData == null || userData is! Map) {
        return Response.failure(ApiError(message: "Invalid user object"));
      }

      final user = UserModel.fromJson(userData as Map<String, dynamic>);

      return Response.success(user);
    } catch (e) {
      return Response.failure(ApiError(message: e.toString()));
    }
  }

  Future<Response<bool>> logout() async {
    try {

      var result = await _apiService.post(
        '/logout',null);

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

      final userData = data["data"];

    //  if (userData == null || userData is! Map) {
    //      return Response.failure(ApiError(message: "Invalid user object"));
    //    }

      //final user = UserModel.fromJson(userData as Map<String, dynamic>);
     await PrefHelper.clearToken();
      return Response.success(true);
    } catch (e) {
      return Response.failure(ApiError(message: e.toString()));
    }
  }
}
