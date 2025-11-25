import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dioClient.dio.get(endpoint);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleException(e);
    }
  }

  Future<dynamic> post(String endpoint, dynamic data) async {
    try {
      final response = await _dioClient.dio.post(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleException(e);
    }
  }

  Future<dynamic> put(String endpoint, dynamic data) async {
    try {
      final response = await _dioClient.dio.put(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleException(e);
    }
  }

  Future<dynamic> delete(String endpoint, dynamic data) async {
    try {
      final response = await _dioClient.dio.delete(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleException(e);
    }
  }
}
