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
}
