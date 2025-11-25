import 'package:dio/dio.dart' show DioException, DioExceptionType;
import 'package:hungry/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleException(DioException e) {
    if (e.response != null && e.response?.data != null) {
      final msg = e.response?.data['message'];
      if (msg != null) {
        return ApiError(message: msg);
      }
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: "Connection timeout. Please try again.");

      case DioExceptionType.sendTimeout:
        return ApiError(message: "Send timeout. Check your connection.");

      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Receive timeout. Server is not responding.");

      case DioExceptionType.badCertificate:
        return ApiError(message: "Bad certificate. Secure connection failed.");

      case DioExceptionType.cancel:
        return ApiError(message: "Request canceled.");

      case DioExceptionType.badResponse:
        return _handleBadResponse(e);

      case DioExceptionType.connectionError:
        return ApiError(message: "No internet connection.");

      case DioExceptionType.unknown:
      default:
        return ApiError(message: "Unexpected error occurred.");
    }
  }

  static ApiError _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;

    switch (statusCode) {
      case 400:
        return ApiError(message: "Bad request.");
      case 401:
        return ApiError(message: "Unauthorized. Please log in again.");
      case 403:
        return ApiError(message: "Forbidden.");
      case 404:
        return ApiError(message: "Resource not found.");
      case 500:
        return ApiError(message: "Server error. Try again later.");
      case 503:
        return ApiError(message: "Service unavailable.");
      default:
        return ApiError(message: "HTTP error: $statusCode");
    }
  }
}
