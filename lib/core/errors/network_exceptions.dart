import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions implements Exception {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;
  const factory NetworkExceptions.canceledByUser() = CanceledByUser;

  /// [fieldErrors] is the API's `error_list` keyed by field, for a form that
  /// puts each message under its own input. [reason] already carries the
  /// same messages joined, for everywhere else.
  const factory NetworkExceptions.badRequest(
    String reason, [
    Map<String, String>? fieldErrors,
  ]) = BadRequest;
  const factory NetworkExceptions.unauthorizedRequest(String reason) =
      UnauthorizedRequest;
  const factory NetworkExceptions.forbidden(String reason) = Forbidden;

  /// 402: the clinic's subscription does not allow this *right now*.
  ///
  /// Unlike a 403 it is recoverable by paying, so it carries what the backend
  /// says about the subscription - `meta.access_mode` and
  /// `meta.subscription_status` - for the one handler that routes the user
  /// to the subscription screen.
  const factory NetworkExceptions.paymentRequired(
    String reason, {
    String? accessMode,
    String? subscriptionStatus,
  }) = PaymentRequired;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.tooManyRequests(String message) =
      TooManyRequests;

  const factory NetworkExceptions.unprocessableEntity(String reason) =
      UnprocessableEntity;

  /// Carries the server's sentence rather than a bare status.
  ///
  /// 409 is the app's "you cannot do that *yet*" - deleting an account while
  /// you are the last owner of a clinic, say. The only thing that tells the
  /// user what to do about it is the backend's own explanation, and a generic
  /// "there was a conflict" throws exactly that away.
  const factory NetworkExceptions.conflict(String reason) = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  /// Extracts the `message` field from the API error response body.
  /// API format: { "result": "error", "message": "...", "error_list": {...}, "code": 400 }
  static String _extractMessage(Response? response, String fallback) {
    try {
      final data = response?.data;
      Map<String, dynamic>? body;

      if (data is Map<String, dynamic>) {
        body = data;
      } else if (data is String && data.isNotEmpty) {
        final decoded = jsonDecode(data);
        if (decoded is Map<String, dynamic>) body = decoded;
      }

      if (body != null) {
        final message = body['message'] as String? ?? fallback;
        final errorList = body['error_list'];
        if (errorList is Map<String, dynamic> && errorList.isNotEmpty) {
          final details = errorList.values.join('\n');
          return '$message\n$details';
        }
        return message;
      }
    } catch (_) {}
    return fallback;
  }

  static Map<String, dynamic>? _decodeBody(Response? response) {
    try {
      final data = response?.data;
      if (data is Map<String, dynamic>) return data;
      if (data is String && data.isNotEmpty) {
        final decoded = jsonDecode(data);
        if (decoded is Map<String, dynamic>) return decoded;
      }
    } catch (_) {}
    return null;
  }

  /// `error_list` as field -> message, or null when it is not an object.
  static Map<String, String>? _extractFieldErrors(Response? response) {
    final errorList = _decodeBody(response)?['error_list'];
    if (errorList is! Map<String, dynamic> || errorList.isEmpty) return null;
    return errorList.map(
      (key, value) =>
          MapEntry(key, value is List ? value.join('\n') : value.toString()),
    );
  }

  static NetworkExceptions handleResponse(Response? response) {
    final int statusCode = response?.statusCode ?? 0;

    switch (statusCode) {
      case 400:
        return NetworkExceptions.badRequest(
          _extractMessage(response, 'Bad request'),
          _extractFieldErrors(response),
        );
      case 402:
        final meta = _decodeBody(response)?['meta'];
        return NetworkExceptions.paymentRequired(
          _extractMessage(response, ''),
          accessMode: meta is Map ? meta['access_mode'] as String? : null,
          subscriptionStatus:
              meta is Map ? meta['subscription_status'] as String? : null,
        );
      case 401:
        return NetworkExceptions.unauthorizedRequest(
          _extractMessage(response, 'Unauthorized'),
        );
      case 403:
        // Same treatment as 400/401/422: the backend explains *why* access
        // was refused (wrong clinic, disabled account, plan expired), and
        // that sentence is the only useful thing to put in front of the
        // user. The bare word "Forbidden" told them nothing.
        return NetworkExceptions.forbidden(
          _extractMessage(response, 'Forbidden'),
        );
      case 404:
        return NetworkExceptions.notFound(
          _extractMessage(response, 'Not found'),
        );
      case 405:
        return const NetworkExceptions.methodNotAllowed();
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 409:
        // Empty rather than a word: the caller falls back to a translated
        // sentence when the server sent none, and a hard-coded 'Conflict'
        // would beat it to it and put English in front of an Arabic user.
        return NetworkExceptions.conflict(_extractMessage(response, ''));
      case 422:
        return NetworkExceptions.unprocessableEntity(
          _extractMessage(response, 'Invalid data'),
        );
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      default:
        return NetworkExceptions.defaultError(
          _extractMessage(
            response,
            'Received invalid status code: $statusCode',
          ),
        );
    }
  }

  static NetworkExceptions getException(Object error) {
    // Already converted — return as-is
    if (error is NetworkExceptions) return error;

    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;

        if (error is DioException) {
          // If ErrorInterceptor already wrapped it, use that directly
          if (error.error is NetworkExceptions) {
            return error.error as NetworkExceptions;
          }
          switch (error.type) {
            case DioExceptionType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioExceptionType.connectionTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioExceptionType.unknown:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
            case DioExceptionType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.badResponse:
              networkExceptions = NetworkExceptions.handleResponse(
                error.response,
              );
              break;
            case DioExceptionType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.badCertificate:
              networkExceptions = const NetworkExceptions.unableToProcess();
              break;
            case DioExceptionType.connectionError:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  /// The user-facing text for [exception], in the app's language.
  ///
  /// Prefer this over [getErrorMessage] anywhere the string is shown on
  /// screen: [getErrorMessage] is context-free and therefore hardcoded
  /// English, which is how "Connection request timeout" ended up inside an
  /// Arabic error card.
  ///
  /// The cases carrying a `String` are passed through untouched. Those are
  /// the server's own words - a validation message, a 403 reason - and the
  /// API is the only thing that knows what they say; replacing them with a
  /// generic local string would throw away the only specific information the
  /// user gets. Only the fixed client-side messages are translated here.
  static String localizedMessage(
    BuildContext context,
    NetworkExceptions exception,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return exception.when(
      notImplemented: () => l10n.errorNotImplemented,
      requestCancelled: () => l10n.errorRequestCancelled,
      internalServerError: () => l10n.errorInternalServer,
      notFound: (reason) => reason,
      serviceUnavailable: () => l10n.errorServiceUnavailable,
      methodNotAllowed: () => l10n.errorMethodNotAllowed,
      badRequest: (message, _) => message,
      paymentRequired: (reason, _, _) =>
          reason.isEmpty ? l10n.subscriptionInactiveMessage : reason,
      unauthorizedRequest: (error) => error,
      unprocessableEntity: (error) => error,
      unexpectedError: () => l10n.errorUnexpected,
      requestTimeout: () => l10n.errorRequestTimeout,
      noInternetConnection: () => l10n.errorNoInternet,
      conflict: (reason) => reason.isEmpty ? l10n.errorConflict : reason,
      tooManyRequests: (message) => message,
      sendTimeout: () => l10n.errorSendTimeout,
      unableToProcess: () => l10n.errorUnableToProcess,
      defaultError: (error) => error,
      formatException: () => l10n.errorUnexpected,
      notAcceptable: () => l10n.errorNotAcceptable,
      forbidden: (reason) => reason,
      canceledByUser: () => l10n.errorCanceledByUser,
    );
  }

  /// Context-free English. Use it for logs and for the handful of call sites
  /// with no [BuildContext]; anything the user reads wants
  /// [localizedMessage].
  static String getErrorMessage(NetworkExceptions networkExceptions) {
    String errorMessage = '';
    networkExceptions.when(
      notImplemented: () {
        errorMessage = 'Not Implemented';
      },
      requestCancelled: () {
        errorMessage = 'Request Cancelled';
      },
      internalServerError: () {
        errorMessage = 'Internal Server Error';
      },
      notFound: (String reason) {
        errorMessage = reason;
      },
      serviceUnavailable: () {
        errorMessage = 'Service unavailable';
      },
      methodNotAllowed: () {
        errorMessage = 'Method Not Allowed';
      },
      badRequest: (String message, _) {
        errorMessage = message;
      },
      paymentRequired: (String reason, _, _) {
        errorMessage = reason.isEmpty ? 'Subscription required' : reason;
      },
      unauthorizedRequest: (String error) {
        errorMessage = error;
      },
      unprocessableEntity: (String error) {
        errorMessage = error;
      },
      unexpectedError: () {
        errorMessage = 'Unexpected error occurred';
      },
      requestTimeout: () {
        errorMessage = 'Connection request timeout';
      },
      noInternetConnection: () {
        errorMessage = 'No internet connection';
      },
      conflict: (String reason) {
        errorMessage = reason.isEmpty ? 'Error due to a conflict' : reason;
      },
      tooManyRequests: (String message) {
        errorMessage = message;
      },
      sendTimeout: () {
        errorMessage = 'Send timeout in connection with API server';
      },
      unableToProcess: () {
        errorMessage = 'Unable to process the data';
      },
      defaultError: (String error) {
        errorMessage = error;
      },
      formatException: () {
        errorMessage = 'Unexpected error occurred';
      },
      notAcceptable: () {
        errorMessage = 'Not acceptable';
      },
      forbidden: (String reason) {
        errorMessage = reason;
      },
      canceledByUser: () {
        errorMessage = 'Canceled by the user';
      },
    );
    return errorMessage;
  }
}
