import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  });
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    FormData? formData,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> patch(
    String path, {
    Map<String, dynamic>? body,
    FormData? formData,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? headers,
  });
}
