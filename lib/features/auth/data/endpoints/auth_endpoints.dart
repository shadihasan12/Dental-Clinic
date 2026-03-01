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
}
