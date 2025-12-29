import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Application configuration class for environment variables
class AppConfig {
  AppConfig._();

  /// Base URL for API requests
  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'https://api.dentalclinic.com/v1/';

  /// Current environment (development, staging, production)
  static String get environment =>
      dotenv.env['ENVIRONMENT'] ?? 'development';

  /// API timeout in seconds
  static String get apiTimeout => dotenv.env['API_TIMEOUT'] ?? '30';

  /// Check if running in development mode
  static bool get isDevelopment => environment == 'development';

  /// Check if running in production mode
  static bool get isProduction => environment == 'production';

  /// Check if running in staging mode
  static bool get isStaging => environment == 'staging';

  /// Get timeout duration
  static Duration get timeoutDuration =>
      Duration(seconds: int.tryParse(apiTimeout) ?? 30);

  // === Subscription Configuration ===

  /// Free trial duration in days
  static const int freeTrialDays = 30;

  /// Yearly billing discount percentage
  static const int yearlyDiscountPercent = 17;

  /// Subscription-related strings
  static const String yearlyBadgeText = 'Save $yearlyDiscountPercent%';
  static const String freeTrialText = '$freeTrialDays days free';
  static const String noCreditCardText = 'No credit card required';
  static const String cancelAnytimeText = 'Cancel anytime. No hidden fees.';

  // === Copyright & Legal ===

  /// Copyright text
  static const String copyrightText = '© 2024 DentalCare Pro. All rights reserved.';
}
