import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for storing and retrieving authentication tokens
@injectable
class TokenStorage {
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';
  static const String _clinicIdKey = 'selected_clinic_id';
  static const String _fcmTokenKey = 'fcm_token';
  static const String _fcmTokenSyncedKey = 'fcm_token_synced';

  final SharedPreferences _prefs;

  TokenStorage(this._prefs);

  /// Save authentication token
  Future<void> saveToken(String token) async {
    if (token.isEmpty) {
      throw ArgumentError('Token cannot be empty');
    }
    await _prefs.setString(_tokenKey, token);
  }

  /// Get stored authentication token
  String? getToken() {
    final token = _prefs.getString(_tokenKey);
    return (token?.isEmpty ?? true) ? null : token;
  }

  /// Check if token exists and is valid
  bool hasToken() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  /// Save refresh token
  Future<void> saveRefreshToken(String token) async {
    if (token.isEmpty) {
      throw ArgumentError('Refresh token cannot be empty');
    }
    await _prefs.setString(_refreshTokenKey, token);
  }

  /// Get stored refresh token
  String? getRefreshToken() {
    final token = _prefs.getString(_refreshTokenKey);
    return (token?.isEmpty ?? true) ? null : token;
  }

  /// Save user ID
  Future<void> saveUserId(String userId) async {
    if (userId.isEmpty) {
      throw ArgumentError('User ID cannot be empty');
    }
    await _prefs.setString(_userIdKey, userId);
  }

  /// Get stored user ID
  String? getUserId() {
    return _prefs.getString(_userIdKey);
  }

  /// Save selected clinic ID
  Future<void> saveClinicId(String clinicId) async {
    if (clinicId.isEmpty) {
      throw ArgumentError('Clinic ID cannot be empty');
    }
    await _prefs.setString(_clinicIdKey, clinicId);
  }

  /// Get stored clinic ID
  String? getClinicId() {
    final clinicId = _prefs.getString(_clinicIdKey);
    return (clinicId?.isEmpty ?? true) ? null : clinicId;
  }

  /// Save the current FCM device token (the value FirebaseMessaging hands us).
  Future<void> saveFcmToken(String token) async {
    if (token.isEmpty) {
      throw ArgumentError('FCM token cannot be empty');
    }
    await _prefs.setString(_fcmTokenKey, token);
  }

  String? getFcmToken() {
    final token = _prefs.getString(_fcmTokenKey);
    return (token?.isEmpty ?? true) ? null : token;
  }

  /// Tracks whether the current FCM token has been POSTed to the backend.
  /// Lets us avoid re-syncing on every cold start.
  Future<void> setFcmTokenSynced(String token) async {
    await _prefs.setString(_fcmTokenSyncedKey, token);
  }

  bool isFcmTokenSynced(String token) {
    return _prefs.getString(_fcmTokenSyncedKey) == token;
  }

  /// Drops the cached FCM token and its synced marker. Called on logout, right
  /// after FirebaseMessaging.deleteToken() invalidates the token server-side.
  Future<void> clearFcmToken() async {
    await _prefs.remove(_fcmTokenKey);
    await _prefs.remove(_fcmTokenSyncedKey);
  }

  /// Clear all stored authentication data
  Future<void> clearAuthData() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_refreshTokenKey);
    await _prefs.remove(_userIdKey);
    await _prefs.remove(_clinicIdKey);
    // FCM token intentionally NOT cleared on logout — the device is the same
    // device. We only invalidate the "synced" marker so the next login re-POSTs
    // it under the new user.
    await _prefs.remove(_fcmTokenSyncedKey);
  }

  /// Clear all data (including other app preferences)
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
