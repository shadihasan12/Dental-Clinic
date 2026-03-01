import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/resources/strings_manager.dart';

/// Interceptor that handles authentication token management:
/// - Attaches stored token to outgoing requests
/// - Extracts token from response Authorization header and stores it
@singleton
class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;

  AuthInterceptor(this._tokenStorage);

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

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Extract token from Authorization response header
    final authHeader = response.headers.value(StringsManager.authorization);
    if (authHeader != null && authHeader.isNotEmpty) {
      String token = authHeader;
      // Strip "Bearer " prefix if present
      if (token.startsWith(StringsManager.bearer)) {
        token = token.substring(StringsManager.bearer.length);
      }
      if (token.isNotEmpty) {
        _tokenStorage.saveToken(token);
        debugPrint('[AuthInterceptor] Token saved from response header');
      }
    }
    super.onResponse(response, handler);
  }
}
