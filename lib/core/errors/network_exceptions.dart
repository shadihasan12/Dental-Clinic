import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions implements Exception {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;
  const factory NetworkExceptions.canceledByUser() = CanceledByUser;

  const factory NetworkExceptions.badRequest(String reason) = BadRequest;
  const factory NetworkExceptions.unauthorizedRequest(String reason) =
      UnauthorizedRequest;
  const factory NetworkExceptions.forbidden() = Forbidden;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.tooManyRequests(String message) = TooManyRequests;

  const factory NetworkExceptions.unprocessableEntity(String reason) =
      UnprocessableEntity;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions handleResponse(Response? response) {
    int statusCode = response?.statusCode ?? 0;

    // Try to extract error message from response body
    String? errorMessage;
    try {
      if (response?.data != null) {
        final dynamic data = response!.data;
        Map<String, dynamic>? jsonData;

        if (data is Map<String, dynamic>) {
          jsonData = data;
        } else if (data is String) {
          // Try to parse JSON string
          try {
            jsonData = jsonDecode(data) as Map<String, dynamic>;
          } catch (_) {
            // Keep jsonData as null if parsing fails
          }
        }

        // Extract message from parsed data
        if (jsonData != null) {
          errorMessage = jsonData['message'] as String?;
        }
      }
    } catch (_) {
      // Keep errorMessage as null
    }

    switch (statusCode) {
      case 400:
        return NetworkExceptions.badRequest(errorMessage ?? 'Bad request');
      case 401:
        return NetworkExceptions.unauthorizedRequest(errorMessage ?? 'Unauthorized');
      case 403:
        return const NetworkExceptions.forbidden();
      case 404:
        return NetworkExceptions.notFound(errorMessage ?? 'Not found');
      case 405:
        return const NetworkExceptions.methodNotAllowed();
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 409:
        return const NetworkExceptions.conflict();
      case 422:
        return NetworkExceptions.unprocessableEntity(errorMessage ?? 'Invalid data');
      case 429:
        return NetworkExceptions.tooManyRequests(errorMessage ?? 'Too many requests');
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      default:
        return NetworkExceptions.defaultError(
          errorMessage ?? 'Received invalid status code: $statusCode',
        );
    }
  }

  static NetworkExceptions getException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;

        if (error is DioException) {
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
              networkExceptions =
                  NetworkExceptions.handleResponse(error.response);
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
      badRequest: (String message) {
        errorMessage = message;
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
      conflict: () {
        errorMessage = 'Error due to a conflict';
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
      forbidden: () {
        errorMessage = 'Forbidden';
      },
      canceledByUser: () {
        errorMessage = 'Canceled by the user';
      },
    );
    return errorMessage;
  }
}
