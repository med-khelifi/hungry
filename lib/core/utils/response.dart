import 'package:hungry/core/network/api_error.dart';

class Response<T> {
  final T? data;
  final ApiError? error;

  Response._({this.data, this.error});

  factory Response.success(T data) => Response._(data: data);
  factory Response.failure(ApiError error) => Response._(error: error);

  bool get isSuccess => data != null;
  bool get isFailure => error != null;
}
