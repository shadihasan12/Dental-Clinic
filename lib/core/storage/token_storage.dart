import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for storing and retrieving authentication tokens
@injectable
class TokenStorage {
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';

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

  /// Clear all stored authentication data
  Future<void> clearAuthData() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userIdKey);
  }

  /// Clear all data (including other app preferences)
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
