import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dioClient.dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      return ApiExceptions.handleException(e);
    }catch(e){
      return ApiError(message: e.toString());
    }
  }

  Future<dynamic> post(String endpoint, dynamic data) async {
    try {
      final response = await _dioClient.dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      return ApiExceptions.handleException(e);
    }catch(e){
      return ApiError(message: e.toString());
    }
  }

  Future<dynamic> put(String endpoint, dynamic data) async {
    try {
      final response = await _dioClient.dio.put(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      return ApiExceptions.handleException(e);
    }catch(e){
      return ApiError(message: e.toString());
    }
  }

  Future<dynamic> delete({required String endpoint, Map<String, dynamic>? data,dynamic? query}) async {
    try {
      final response = await _dioClient.dio.delete(endpoint, data: data,queryParameters: query);
      return response;
    } on DioException catch (e) {
      return ApiExceptions.handleException(e);
    }catch(e){
      return ApiError(message: e.toString());
    }
  }
}
