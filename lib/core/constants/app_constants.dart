/// Application-wide constants
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Denta';

  // Pagination
  static const int defaultPageSize = 20;
  static const int initialPage = 0;

  // API Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 60);
  static const Duration sendTimeout = Duration(seconds: 10);

  /// Sending a file, and waiting for the server to store it. The 10 seconds
  /// above cover a JSON body; a phone photo or a PNG screenshot is several
  /// megabytes, and on a clinic connection that takes far longer to go up.
  /// Dio cancels the request once the whole body has not gone out within the
  /// send timeout, so with 10s every real image upload failed while a tiny
  /// one went through. The server accepts up to 50 MB.
  static const Duration uploadTimeout = Duration(minutes: 5);

  // Cache
  static const Duration cacheExpiration = Duration(hours: 24);

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 400);
  static const Duration longAnimationDuration = Duration(milliseconds: 600);
}
