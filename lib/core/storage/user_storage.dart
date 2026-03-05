import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for caching user profile and clinic data
@injectable
class UserStorage {
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _clinicNameKey = 'clinic_name';
  static const String _locationIdKey = 'location_id';
  static const String _locationNameKey = 'location_name';
  static const String _locationFullNameKey = 'location_full_name';
  static const String _detailedAddressKey = 'detailed_address';

  final SharedPreferences _prefs;

  UserStorage(this._prefs);

  // ── User name ──

  Future<void> saveUserName(String name) async {
    await _prefs.setString(_userNameKey, name);
  }

  String? getUserName() => _prefs.getString(_userNameKey);

  // ── User email ──

  Future<void> saveUserEmail(String email) async {
    await _prefs.setString(_userEmailKey, email);
  }

  String? getUserEmail() => _prefs.getString(_userEmailKey);

  // ── Clinic name ──

  Future<void> saveClinicName(String name) async {
    await _prefs.setString(_clinicNameKey, name);
  }

  String? getClinicName() => _prefs.getString(_clinicNameKey);

  // ── Location ──

  Future<void> saveLocationId(String id) async {
    await _prefs.setString(_locationIdKey, id);
  }

  String? getLocationId() => _prefs.getString(_locationIdKey);

  Future<void> saveLocationName(String name) async {
    await _prefs.setString(_locationNameKey, name);
  }

  String? getLocationName() => _prefs.getString(_locationNameKey);

  Future<void> saveLocationFullName(String fullName) async {
    await _prefs.setString(_locationFullNameKey, fullName);
  }

  String? getLocationFullName() => _prefs.getString(_locationFullNameKey);

  // ── Detailed address ──

  Future<void> saveDetailedAddress(String address) async {
    await _prefs.setString(_detailedAddressKey, address);
  }

  String? getDetailedAddress() => _prefs.getString(_detailedAddressKey);

  // ── Clear ──

  Future<void> clear() async {
    await _prefs.remove(_userNameKey);
    await _prefs.remove(_userEmailKey);
    await _prefs.remove(_clinicNameKey);
    await _prefs.remove(_locationIdKey);
    await _prefs.remove(_locationNameKey);
    await _prefs.remove(_locationFullNameKey);
    await _prefs.remove(_detailedAddressKey);
  }
}
