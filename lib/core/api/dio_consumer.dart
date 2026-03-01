import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/config/app_config.dart';
import 'package:dental_clinic_app/core/api/interceptors/error_interceptor.dart';
import 'package:dental_clinic_app/core/api/interceptors/logging_interceptor.dart';
import 'package:dental_clinic_app/core/constants/app_constants.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/strings_manager.dart';

@Singleton(as: ApiConsumer)
class DioConsumer implements ApiConsumer {
  DioConsumer(
    this._client,
    this._errorInterceptor,
    this._loggingInterceptor,
  ) {
    _client.options
      ..sendTimeout = AppConstants.sendTimeout
      ..connectTimeout = AppConstants.connectTimeout
      ..receiveTimeout = AppConstants.receiveTimeout
      ..baseUrl = AppConfig.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = true
      ..headers = {
        StringsManager.accept: StringsManager.applicationJson,
        StringsManager.contentType: StringsManager.applicationJson,
        // TODO: Remove hardcoded token and clinic ID after auth is implemented
        StringsManager.authorization:
            '${StringsManager.bearer}eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2RlbnRlY2guYXlhcy11YWUuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNzcyMzYwNDQ5LCJleHAiOjE3NzI0NDY4NDksIm5iZiI6MTc3MjM2MDQ0OSwianRpIjoiUlQ4ZU1IaEZ6cktPR0JKSSIsInN1YiI6IjAxOWNhMzljLTA1ODktNzBlMS05NzJkLWMxMGU4ZmU3NDU2NiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.t_ppv-rSMI8ZUw2c-V-FTpH8YWj4Ac8KiCiv7L4D-uI',
        'X-Selected-Clinic-id': '019ca39c-0590-72a1-a48d-737996f0bec7',
      };

    // Add error interceptor first (it should process errors before logging)
    _client.interceptors.add(_errorInterceptor);

    // Add logging interceptor only in debug mode
    if (kDebugMode) {
      _client.interceptors.add(_loggingInterceptor);
    }

    // Only bypass certificates in debug mode
    if (kDebugMode && !kIsWeb) {
      (_client.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  final Dio _client;
  final ErrorInterceptor _errorInterceptor;
  final LoggingInterceptor _loggingInterceptor;

  @override
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _client.get(
        path,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return _handleOnlineResponseAsJson(response);
    } catch (error) {
      throw NetworkExceptions.getException(error);
    }
  }

  @override
  Future post(
    String path, {
    Map<String, dynamic>? body,
    String? token,
    FormData? formData,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await _client.post(
        path,
        queryParameters: queryParameters,
        options: Options(
          contentType:
              formData == null ? StringsManager.jsonContentType : null,
        ),
        data: formData ?? body,
      );
      return _handleOnlineResponseAsJson(response);
    } catch (error) {
      throw NetworkExceptions.getException(error);
    }
  }

  @override
  Future patch(
    String path, {
    Map<String, dynamic>? body,
    String? token,
    FormData? formData,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await _client.patch(
        path,
        queryParameters: queryParameters,
        options: Options(
          contentType:
              formData == null ? StringsManager.jsonContentType : null,
        ),
        data: formData ?? body,
      );
      return _handleOnlineResponseAsJson(response);
    } catch (error) {
      throw NetworkExceptions.getException(error);
    }
  }

  @override
  Future put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await _client.put(
        path,
        queryParameters: queryParameters,
        data: body,
        options: Options(
          contentType: StringsManager.jsonContentType,
        ),
      );
      return _handleOnlineResponseAsJson(response);
    } catch (error) {
      throw NetworkExceptions.getException(error);
    }
  }

  @override
  Future delete(String path) async {
    try {
      final Response response = await _client.delete(
        path,
        options: Options(
          contentType: StringsManager.jsonContentType,
        ),
      );
      return _handleOnlineResponseAsJson(response);
    } catch (error) {
      throw NetworkExceptions.getException(error);
    }
  }

  dynamic _handleOnlineResponseAsJson(Response response) {
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }
}
