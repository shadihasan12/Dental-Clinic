import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_clinic_app/core/api/interceptors/rate_limit_hold.dart';
import 'package:dental_clinic_app/core/config/app_config.dart';
import 'package:dental_clinic_app/core/constants/app_constants.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/resources/strings_manager.dart';
import 'package:dental_clinic_app/core/localization/language_service.dart';
import 'package:dental_clinic_app/core/session/session_manager.dart';
import 'package:dental_clinic_app/features/auth/data/endpoints/auth_endpoints.dart';
import 'package:dental_clinic_app/services/clinic_access/clinic_access_guard.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard.dart';

/// Interceptor that handles authentication token management:
/// - Attaches stored token to outgoing requests
/// - Extracts token from response Authorization header and stores it
/// - Adds Accept-Language header based on cached language
/// - Automatically refreshes expired tokens on 401 responses - once at a
///   time, with every other call waiting for that renewal
/// - Hands every 402 to the [SubscriptionGuard] - it is neither a 401 (no
///   refresh) nor a 403 (it is recoverable by paying)
/// - Notes every 429 in the [RateLimitHold] - it is neither of those either,
///   and never a logout, even on the renewal itself
/// - Hands every 403 `not_clinic_member` to the [ClinicAccessGuard] - the
///   clinic the request named is no longer the user's, which no screen can
///   put right
@singleton
class AuthInterceptor extends QueuedInterceptor {
  final TokenStorage _tokenStorage;
  final LanguageService _languageService;
  final SessionManager _sessionManager;
  final SubscriptionGuard _subscriptionGuard;
  final ClinicAccessGuard _clinicAccessGuard;

  /// The calls the server answered 429 to, held back until it said to try
  /// again.
  final RateLimitHold _rateLimitHold = RateLimitHold();

  /// The token the holds were collected under.
  String? _heldUnder;

  /// Set for as long as a renewal is on its way. Requests wait on it, so
  /// none goes out carrying the token that is being replaced.
  Completer<void>? _renewal;

  AuthInterceptor(
    this._tokenStorage,
    this._languageService,
    this._sessionManager,
    this._subscriptionGuard,
    this._clinicAccessGuard,
  );

  static const String _clinicHeader = 'X-Selected-Clinic-id';

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await _renewal?.future;

    final token = _tokenStorage.getToken();

    // A hold belongs to the session it was earned in: the next account on
    // this device has limits of its own.
    if (token != _heldUnder) {
      _rateLimitHold.clear();
      _heldUnder = token;
    }

    // Answered 429 a moment ago and told how long to wait: the same call
    // again would only be refused again, and count against the limit. It
    // goes down the error path like the real one, so the caller shows the
    // server's sentence.
    final held = _rateLimitHold.check(options);
    if (held != null) return handler.reject(held, true);

    if (token != null && token.isNotEmpty) {
      options.headers[StringsManager.authorization] =
          '${StringsManager.bearer}$token';
    }

    final clinicId = _tokenStorage.getClinicId();
    if (clinicId != null && clinicId.isNotEmpty) {
      options.headers[_clinicHeader] = clinicId;
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
    // The clinic this request named is no longer the user's. Told apart from
    // a role's 403 by `meta.reason` - never by the message, which follows
    // the language. The error still reaches the caller; the guard starts the
    // one flow that takes the user out of the clinic.
    if (err.response?.statusCode == 403) {
      _reportIfNotMember(err);
      return super.onError(err, handler);
    }

    // The subscription does not allow this right now. Never a refresh and
    // never a logout: update the cached mode and let the error carry on, so
    // the caller still sees it and the one 402 handler can route the user.
    if (err.response?.statusCode == 402) {
      _reportPaymentRequired(err.response);
      return super.onError(err, handler);
    }

    // Called too often. Never a refresh and never a logout: note how long
    // the server said to wait and let the error carry on, so the caller
    // shows its message.
    if (err.response?.statusCode == 429) {
      _rateLimitHold.report(err);
      return super.onError(err, handler);
    }

    // Only attempt refresh on 401 responses
    if (err.response?.statusCode != 401) {
      return super.onError(err, handler);
    }

    // Don't try to refresh if the failing request IS the refresh request
    if (err.requestOptions.path == AuthEndpoints.refresh) {
      await _forceLogout();
      return super.onError(err, handler);
    }

    // Don't try to refresh login requests
    if (err.requestOptions.path == AuthEndpoints.login) {
      return super.onError(err, handler);
    }

    // Signed out: there is no session to renew.
    final token = _tokenStorage.getToken();
    if (token == null) {
      return super.onError(err, handler);
    }

    // The token was renewed while this call was out, or queued behind the
    // call that renewed it - or replaced by a password or email change. Two
    // renewals with the same token fail, so this one only goes again, with
    // the token now in hand.
    if (_tokenSentWith(err.requestOptions) != token) {
      return _replay(err, handler);
    }

    final renewal = _renewal = Completer<void>();
    try {
      await _renew(token);
    } on DioException catch (renewError) {
      // Only a 401 says the session is over. A 429, a timeout or a dropped
      // connection says nothing about it: the user stays signed in, and the
      // caller gets the renewal's own failure to show.
      if (renewError.response?.statusCode == 401) {
        await _forceLogout();
        return super.onError(err, handler);
      }
      _rateLimitHold.report(renewError);
      return super.onError(renewError, handler);
    } catch (_) {
      return super.onError(err, handler);
    } finally {
      _renewal = null;
      renewal.complete();
    }

    return _replay(err, handler);
  }

  /// Renews [token] with `POST /auth/refresh`. The token itself is what
  /// proves the session - expired is fine - and the new one comes back in
  /// the `Authorization` header.
  Future<void> _renew(String token) async {
    // Sent as well when the server ever handed one out.
    final refreshToken = _tokenStorage.getRefreshToken();
    final body = refreshToken == null ? null : {'refresh_token': refreshToken};

    // The renewal has a limit of its own. Told to wait, it waits like any
    // other call instead of being refused again.
    final held = _rateLimitHold.check(
      RequestOptions(path: AuthEndpoints.refresh, method: 'POST', data: body),
    );
    if (held != null) throw held;

    // Use a plain Dio instance to avoid interceptor loops
    final refreshDio = Dio(BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: AppConstants.connectTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: {
        StringsManager.accept: StringsManager.applicationJson,
        StringsManager.contentType: StringsManager.applicationJson,
        StringsManager.authorization: '${StringsManager.bearer}$token',
        'Accept-Language': _languageService.currentLanguage,
      },
    ));

    final refreshResponse = await refreshDio.post(
      AuthEndpoints.refresh,
      data: body,
    );

    // Save new tokens from response body
    try {
      final responseData = refreshResponse.data is String
          ? jsonDecode(refreshResponse.data as String)
          : refreshResponse.data;
      final data = responseData is Map ? responseData['data'] : null;
      if (data is Map) {
        final newAccessToken = data['access_token'];
        final newRefreshToken = data['refresh_token'];
        if (newAccessToken is String && newAccessToken.isNotEmpty) {
          await _tokenStorage.saveToken(newAccessToken);
        }
        if (newRefreshToken is String && newRefreshToken.isNotEmpty) {
          await _tokenStorage.saveRefreshToken(newRefreshToken);
        }
      }
    } catch (_) {
      // The token travels in the header; a body we cannot read loses nothing.
    }

    // The token itself comes in the Authorization header
    _extractAndSaveTokensFromHeaders(refreshResponse.headers);
  }

  /// Sends the failed call once more, with the token now in storage.
  Future<void> _replay(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final opts = err.requestOptions;
    final newToken = _tokenStorage.getToken();
    if (newToken != null) {
      opts.headers[StringsManager.authorization] =
          '${StringsManager.bearer}$newToken';
    }
    final clinicId = _tokenStorage.getClinicId();
    if (clinicId != null && clinicId.isNotEmpty) {
      opts.headers[_clinicHeader] = clinicId;
    }
    opts.headers['Accept-Language'] = _languageService.currentLanguage;

    // Use a plain Dio to retry (avoids interceptor loops)
    final retryDio = Dio(BaseOptions(
      baseUrl: opts.baseUrl,
    ));
    try {
      final retryResponse = await retryDio.fetch(opts);
      _extractAndSaveTokens(retryResponse);
      return handler.resolve(retryResponse);
    } on DioException catch (retryError) {
      // The token was renewed; the retried request simply failed on its
      // own terms (a 402 from a lapsed clinic, a 409, a 404). That is the
      // caller's error to handle, not a reason to end the session.
      if (retryError.response?.statusCode == 402) {
        _reportPaymentRequired(retryError.response);
      }
      if (retryError.response?.statusCode == 403) {
        _reportIfNotMember(retryError);
      }
      _rateLimitHold.report(retryError);
      return handler.next(retryError);
    }
  }

  /// The token [options] went out with, without its `Bearer ` prefix.
  String? _tokenSentWith(RequestOptions options) {
    final header = options.headers[StringsManager.authorization];
    if (header is! String || header.isEmpty) return null;
    return header.startsWith(StringsManager.bearer)
        ? header.substring(StringsManager.bearer.length)
        : header;
  }

  /// Reports a 403 `not_clinic_member` with the clinic the request was *sent*
  /// with - not the one open now. A late answer to a request sent before a
  /// clinic switch must not throw the user out of the clinic they switched
  /// to; the guard's handler compares the two.
  void _reportIfNotMember(DioException err) {
    try {
      final raw = err.response?.data;
      final body = raw is String ? jsonDecode(raw) : raw;
      if (body is! Map) return;
      final meta = body['meta'];
      if (meta is! Map || meta['reason'] != 'not_clinic_member') return;
      final sentFor = _clinicSentWith(err.requestOptions);
      if (sentFor != null) _clinicAccessGuard.reportRefusal(sentFor);
    } catch (_) {
      // Unreadable body: an ordinary 403 for the caller.
    }
  }

  String? _clinicSentWith(RequestOptions options) {
    for (final entry in options.headers.entries) {
      if (entry.key.toLowerCase() == _clinicHeader.toLowerCase()) {
        final value = entry.value?.toString() ?? '';
        return value.isEmpty ? null : value;
      }
    }
    return null;
  }

  /// Hands a 402's `message` and `meta` to the [SubscriptionGuard], which
  /// updates the cached access mode straight away and notifies the handler.
  void _reportPaymentRequired(Response? response) {
    try {
      final raw = response?.data;
      final body = raw is String ? jsonDecode(raw) : raw;
      if (body is! Map) return;
      final meta = body['meta'];
      _subscriptionGuard.reportPaymentRequired(
        message: (body['message'] ?? '').toString(),
        accessMode: meta is Map ? meta['access_mode'] as String? : null,
        status: meta is Map ? meta['subscription_status'] as String? : null,
      );
    } catch (_) {
      // A 402 with a body we cannot read still reaches the caller as an
      // error; only the cached mode goes without an update.
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

  /// The token is dead and cannot be renewed. Wipe the session and bounce the
  /// user to login — otherwise they stay on a signed-in-looking screen while
  /// every request keeps failing with `Unauthenticated`.
  Future<void> _forceLogout() async {
    debugPrint('[AuthInterceptor] Token refresh failed — forcing logout');
    await _sessionManager.endSession(expired: true);
  }
}