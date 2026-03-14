import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for storing and retrieving authentication tokens
@injectable
class TokenStorage {
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';
  static const String _clinicIdKey = 'selected_clinic_id';

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

  /// Clear all stored authentication data
  Future<void> clearAuthData() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_refreshTokenKey);
    await _prefs.remove(_userIdKey);
    await _prefs.remove(_clinicIdKey);
  }

  /// Clear all data (including other app preferences)
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
