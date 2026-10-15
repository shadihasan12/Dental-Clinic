import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Application configuration class for environment variables
class AppConfig {
  AppConfig._();

  /// Base URL for API requests
  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'https://api.dentalclinic.com/v1/';

  /// Current environment (development, staging, production)
  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';

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

  // === Feature flags ===

  /// Whether subscriptions, plans and billing are reachable in the build.
  ///
  /// Turned off to ship a version with no payment surface at all: the plan
  /// chooser, the pricing page, the home subscription card, the billing and
  /// invoice screens and the expiry guard all disappear together. It is
  /// deliberately build-wide rather than per-account - showing one user a
  /// different app from another is what App Store guideline 2.3.1 exists to
  /// catch, and doing it for a review account risks the developer account
  /// rather than just the submission.
  ///
  /// Signup still sends a `plan_version_id` because /auth/register requires
  /// one; see AuthBloc, which picks the entry plan silently when this is off.
  static const bool billingEnabled = false;

  /// Whether a clinic can be registered from inside the app.
  ///
  /// Off on the Apple builds. App Review reads the sign-up flow - which ends
  /// by creating the clinic itself, with its name, type, location and
  /// specialty - as "an account registration feature for businesses and
  /// organizations", and so as access to a subscription bought outside the
  /// app; it is what 1.0.3 was rejected for under guideline 3.1.1 on
  /// 2026-10-14. The iOS and macOS builds are therefore sign-in only: the
  /// sign-up link disappears from the login page and every step of the flow
  /// is closed off in RoutesManager.
  ///
  /// Unlike [billingEnabled] this is per platform rather than build-wide,
  /// and that is the point: the binary Apple reviews genuinely has no
  /// registration in it, so there is no 2.3.1 question of a reviewer being
  /// shown a different app from everyone else. Android and the web keep
  /// self-serve onboarding.
  ///
  /// Email verification is deliberately not gated with it: an existing user
  /// whose email is unverified still reaches the OTP screens from the login
  /// page, which is the only way such an account can get in.
  static bool get selfSignupEnabled =>
      kIsWeb ||
      (defaultTargetPlatform != TargetPlatform.iOS &&
          defaultTargetPlatform != TargetPlatform.macOS);

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
  static const String copyrightText =
      '© 2024 DentalCare Pro. All rights reserved.';
}
