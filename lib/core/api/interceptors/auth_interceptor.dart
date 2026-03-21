import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_clinic_app/core/config/app_config.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/resources/strings_manager.dart';
import 'package:dental_clinic_app/core/localization/language_service.dart';
import 'package:dental_clinic_app/features/auth/data/endpoints/auth_endpoints.dart';

/// Interceptor that handles authentication token management:
/// - Attaches stored token to outgoing requests
/// - Extracts token from response Authorization header and stores it
/// - Adds Accept-Language header based on cached language
/// - Automatically refreshes expired tokens on 401 responses
@singleton
class AuthInterceptor extends QueuedInterceptor {
  final TokenStorage _tokenStorage;
  final LanguageService _languageService;

  /// Flag to prevent redirect loops
  bool _isRefreshing = false;

  AuthInterceptor(this._tokenStorage, this._languageService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _tokenStorage.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers[StringsManager.authorization] =
          '${StringsManager.bearer}$token';
    }

    final clinicId = _tokenStorage.getClinicId();
    if (clinicId != null && clinicId.isNotEmpty) {
      options.headers['X-Selected-Clinic-id'] = clinicId;
    }

    options.headers['Accept-Language'] = _languageService.currentLanguage;

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _extractAndSaveTokens(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Only attempt refresh on 401 responses
    if (err.response?.statusCode != 401) {
      return super.onError(err, handler);
    }

    // Don't try to refresh if the failing request IS the refresh request
    if (err.requestOptions.path == AuthEndpoints.refresh) {
      _isRefreshing = false;
      await _forceLogout();
      return super.onError(err, handler);
    }

    // Don't try to refresh login requests
    if (err.requestOptions.path == AuthEndpoints.login) {
      return super.onError(err, handler);
    }

    // Prevent concurrent refresh attempts
    if (_isRefreshing) {
      return super.onError(err, handler);
    }

    final refreshToken = _tokenStorage.getRefreshToken();
    if (refreshToken == null) {
      await _forceLogout();
      return super.onError(err, handler);
    }

    _isRefreshing = true;

    try {
      // Use a plain Dio instance to avoid interceptor loops
      final refreshDio = Dio(BaseOptions(
        baseUrl: AppConfig.baseUrl,
        headers: {
          StringsManager.accept: StringsManager.applicationJson,
          StringsManager.contentType: StringsManager.applicationJson,
          'Accept-Language': _languageService.currentLanguage,
        },
      ));

      final refreshResponse = await refreshDio.post(
        AuthEndpoints.refresh,
        data: {'refresh_token': refreshToken},
      );

      _isRefreshing = false;

      // Parse refresh response
      final responseData = refreshResponse.data is String
          ? jsonDecode(refreshResponse.data as String)
          : refreshResponse.data;

      // Save new tokens from response body
      final data = responseData['data'] as Map<String, dynamic>?;
      if (data != null) {
        final newAccessToken = data['access_token'] as String?;
        final newRefreshToken = data['refresh_token'] as String?;
        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          await _tokenStorage.saveToken(newAccessToken);
        }
        if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
          await _tokenStorage.saveRefreshToken(newRefreshToken);
        }
      }

      // Also check Authorization header (server might send token there)
      _extractAndSaveTokensFromHeaders(refreshResponse.headers);

      // Retry the original request with new token and clinic ID
      final opts = err.requestOptions;
      final newToken = _tokenStorage.getToken();
      if (newToken != null) {
        opts.headers[StringsManager.authorization] =
            '${StringsManager.bearer}$newToken';
      }
      final clinicId = _tokenStorage.getClinicId();
      if (clinicId != null && clinicId.isNotEmpty) {
        opts.headers['X-Selected-Clinic-id'] = clinicId;
      }
      opts.headers['Accept-Language'] = _languageService.currentLanguage;

      // Use a plain Dio to retry (avoids interceptor loops)
      final retryDio = Dio(BaseOptions(
        baseUrl: opts.baseUrl,
      ));
      final retryResponse = await retryDio.fetch(opts);
      return handler.resolve(retryResponse);
    } on DioException catch (_) {
      _isRefreshing = false;
      await _forceLogout();
      return super.onError(err, handler);
    } catch (_) {
      _isRefreshing = false;
      await _forceLogout();
      return super.onError(err, handler);
    }
  }

  void _extractAndSaveTokens(Response response) {
    _extractAndSaveTokensFromHeaders(response.headers);
  }

  void _extractAndSaveTokensFromHeaders(Headers headers) {
    final authHeader = headers.value(StringsManager.authorization);
    if (authHeader != null && authHeader.isNotEmpty) {
      String token = authHeader;
      if (token.startsWith(StringsManager.bearer)) {
        token = token.substring(StringsManager.bearer.length);
      }
      if (token.isNotEmpty) {
        _tokenStorage.saveToken(token);
        debugPrint('[AuthInterceptor] Token saved from response header');
      }
    }

    // Check for refresh token in a custom header
    final refreshHeader = headers.value('X-Refresh-Token');
    if (refreshHeader != null && refreshHeader.isNotEmpty) {
      _tokenStorage.saveRefreshToken(refreshHeader);
      debugPrint('[AuthInterceptor] Refresh token saved from response header');
    }
  }

  Future<void> _forceLogout() async {
    debugPrint('[AuthInterceptor] Token refresh failed — forcing logout');
    await _tokenStorage.clearAuthData();
  }
}