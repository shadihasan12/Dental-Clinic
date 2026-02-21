import 'package:dental_clinic_app/core/errors/failures.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';

/// Helper class for error handling and message mapping
class ErrorHelper {
  ErrorHelper._();

  /// Converts NetworkExceptions to user-friendly messages
  static String getUserFriendlyMessage(NetworkExceptions exception) {
    return NetworkExceptions.getErrorMessage(exception);
  }

  /// Converts any error to a user-friendly message
  static String getErrorMessage(dynamic error) {
    if (error is NetworkExceptions) {
      return getUserFriendlyMessage(error);
    }

    if (error is Failure) {
      return error.message;
    }

    if (error is Exception) {
      final networkException = NetworkExceptions.getException(error);
      return getUserFriendlyMessage(networkException);
    }

    return 'An unexpected error occurred. Please try again.';
  }

  /// Converts NetworkExceptions to Failure
  static Failure networkExceptionToFailure(NetworkExceptions exception) {
    final message = getUserFriendlyMessage(exception);

    return exception.when(
      requestCancelled: () => NetworkFailure(message),
      canceledByUser: () => NetworkFailure(message),
      badRequest: (reason) => ValidationFailure(reason),
      unauthorizedRequest: (reason) => NetworkFailure(reason),
      forbidden: () => NetworkFailure(message),
      notFound: (reason) => NetworkFailure(reason),
      methodNotAllowed: () => ServerFailure(message),
      notAcceptable: () => ServerFailure(message),
      requestTimeout: () => NetworkFailure(message),
      sendTimeout: () => NetworkFailure(message),
      tooManyRequests: (msg) => NetworkFailure(msg),
      unprocessableEntity: (reason) => ValidationFailure(reason),
      conflict: () => ServerFailure(message),
      internalServerError: () => ServerFailure(message),
      notImplemented: () => ServerFailure(message),
      serviceUnavailable: () => ServerFailure(message),
      noInternetConnection: () => NetworkFailure(message),
      formatException: () => ValidationFailure(message),
      unableToProcess: () => ServerFailure(message),
      defaultError: (error) => ServerFailure(error),
      unexpectedError: () => UnknownFailure(message),
    );
  }
}
