import 'dart:io';

import 'package:dio/dio.dart' show FormData, MultipartFile;
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/core/utils/pref_helper.dart';
import 'package:hungry/core/utils/response.dart';
import 'package:hungry/features/auth/data/user_model.dart';

class AuthRepo {
  // Singleton
  static final AuthRepo _instance = AuthRepo._internal();
  factory AuthRepo() => _instance;
  AuthRepo._internal();

  final ApiService _apiService = ApiService();

  Future<bool> tryAutoLogin() async {
    final token = await PrefHelper.getToken();

    if (token == null || token.isEmpty) {
      _isGuest = true;
      _currentUser = null;
      return false;
    }
    final res = await getCurrentUserInfo();
    if (res.isFailure) {
      return false;
    }
    _currentUser = res.data;
    _isGuest = false;
    return true;
  }

  bool _isGuest = false;
  UserModel? _currentUser;
  get currentUser => _currentUser;
  get isGuest => _isGuest;

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
      _isGuest = false;
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
        "Visa": viza,
        "image": imageFile,
      });

      var result = await _apiService.post('/update-profile', formData);

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
      _currentUser = user;
      return Response.success(user);
    } catch (e) {
      return Response.failure(ApiError(message: e.toString()));
    }
  }

  Future<Response<bool>> logout() async {
    try {
      var result = await _apiService.post('/logout', null);

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
      await PrefHelper.clearToken();
      _currentUser = null;
      _isGuest = true;
      return Response.success(true);
    } catch (e) {
      return Response.failure(ApiError(message: e.toString()));
    }
  }
}
