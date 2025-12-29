import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';

/// Interceptor to handle and transform API errors
@singleton
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final networkException = NetworkExceptions.getException(err);

    // Transform DioException to NetworkExceptions
    final transformedError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: networkException,
      stackTrace: err.stackTrace,
    );

    super.onError(transformedError, handler);
  }
}
