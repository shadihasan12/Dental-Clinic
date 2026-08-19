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

  // Cache
  static const Duration cacheExpiration = Duration(hours: 24);

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 400);
  static const Duration longAnimationDuration = Duration(milliseconds: 600);
}
