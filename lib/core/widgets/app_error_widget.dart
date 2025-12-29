import 'package:flutter/material.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

/// Reusable error widget with retry functionality
class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.error,
    this.onRetry,
    this.title,
  });

  final NetworkExceptions error;
  final VoidCallback? onRetry;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final message = NetworkExceptions.getErrorMessage(error);
    final icon = _getErrorIcon(error);
    final isRetryable = _isRetryable(error);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error Icon
            Icon(
              icon,
              size: 64,
              color: ColorManager.error,
            ),
            const SizedBox(height: 16),

            // Error Title
            Text(
              title ?? 'Oops!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Error Message
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorManager.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Retry Button (if retryable and callback provided)
            if (isRetryable && onRetry != null)
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getErrorIcon(NetworkExceptions error) {
    return error.when(
      requestCancelled: () => Icons.cancel_outlined,
      canceledByUser: () => Icons.cancel_outlined,
      badRequest: (_) => Icons.error_outline,
      unauthorizedRequest: (_) => Icons.lock_outline,
      forbidden: () => Icons.block_outlined,
      notFound: (_) => Icons.search_off_outlined,
      methodNotAllowed: () => Icons.not_interested_outlined,
      notAcceptable: () => Icons.do_not_disturb_outlined,
      requestTimeout: () => Icons.timer_off_outlined,
      sendTimeout: () => Icons.timer_off_outlined,
      unprocessableEntity: (_) => Icons.warning_amber_outlined,
      conflict: () => Icons.sync_problem_outlined,
      internalServerError: () => Icons.cloud_off_outlined,
      notImplemented: () => Icons.construction_outlined,
      serviceUnavailable: () => Icons.cloud_off_outlined,
      noInternetConnection: () => Icons.wifi_off_outlined,
      formatException: () => Icons.data_object_outlined,
      unableToProcess: () => Icons.warning_amber_outlined,
      defaultError: (_) => Icons.error_outline,
      unexpectedError: () => Icons.error_outline,
    );
  }

  bool _isRetryable(NetworkExceptions error) {
    return error.when(
      requestCancelled: () => false,
      canceledByUser: () => false,
      badRequest: (_) => false,
      unauthorizedRequest: (_) => false,
      forbidden: () => false,
      notFound: (_) => false,
      methodNotAllowed: () => false,
      notAcceptable: () => false,
      requestTimeout: () => true,
      sendTimeout: () => true,
      unprocessableEntity: (_) => false,
      conflict: () => true,
      internalServerError: () => true,
      notImplemented: () => false,
      serviceUnavailable: () => true,
      noInternetConnection: () => true,
      formatException: () => false,
      unableToProcess: () => true,
      defaultError: (_) => true,
      unexpectedError: () => true,
    );
  }
}
