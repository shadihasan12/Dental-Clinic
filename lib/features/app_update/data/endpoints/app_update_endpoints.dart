/// Endpoints for the startup version check.
class AppUpdateEndpoints {
  AppUpdateEndpoints._();

  /// GET /app/version — asks the backend what this build should do.
  ///
  /// Deliberately public: a forced update has to be able to stop a user who
  /// is sitting on the login page with an expired token, and a route behind
  /// the bearer token could not.
  static const String version = '/app/version';
}
