/// API endpoints for authentication feature
class AuthEndpoints {
  AuthEndpoints._();

  /// GET /specialties - Fetch available dental specialties
  static const String specialties = '/specialties';

  /// GET /locations/search - Search locations by query and country code
  /// Query parameters: query, country_code
  static const String locationSearch = '/locations/search';

  /// GET /plans - Fetch available subscription plans
  static const String plans = '/plans';

  /// POST /auth/register - Register new user with clinic
  static const String register = '/auth/register';

  /// POST /auth/register/request-otp - Request OTP for registration (also used for resend)
  static const String requestOtpForRegister = '/auth/register/request-otp';

  /// POST /auth/verify-otp - Verify OTP and get session token
  static const String verifyOtp = '/auth/verify-otp';

  /// POST /auth/login - Login with email or mobile number
  static const String login = '/auth/login';

  /// POST /auth/refresh - Refresh expired access token
  static const String refresh = '/auth/refresh';

  /// POST /auth/reset-password/request-otp - Request OTP for password reset
  static const String requestOtpForResetPassword = '/auth/reset-password/request-otp';

  /// POST /auth/reset-password - Reset password with session ID
  static const String resetPassword = '/auth/reset-password';

  /// POST /auth/verify-email/request-otp - Request OTP to verify email (requires auth token)
  static const String verifyEmailRequestOtp = '/auth/verify-email/request-otp';

  /// POST /auth/verify-email - Verify email with OTP (requires auth token)
  static const String verifyEmail = '/auth/verify-email';

  /// POST /auth/change-email/request-otp - Request OTP to change email
  static const String changeEmailRequestOtp = '/auth/change-email/request-otp';

  /// POST /auth/change-email - Confirm email change with session ID
  static const String changeEmail = '/auth/change-email';
}
