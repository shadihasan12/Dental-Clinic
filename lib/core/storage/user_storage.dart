import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for caching user profile and clinic data
@injectable
class UserStorage {
  /// Notifier that increments whenever the profile is updated.
  /// Listen to this in widgets to refresh after profile edits.
  static final ValueNotifier<int> profileUpdateNotifier = ValueNotifier<int>(0);

  /// Call this after saving profile changes to notify listeners.
  static void notifyProfileUpdated() {
    profileUpdateNotifier.value++;
  }

  /// Notifier that increments whenever the active clinic is switched. The
  /// root page listens to this to refetch permissions and remount each tab
  /// so every clinic-scoped API reloads against the new clinic.
  static final ValueNotifier<int> clinicChangedNotifier = ValueNotifier<int>(0);

  static void notifyClinicChanged() {
    clinicChangedNotifier.value++;
  }

  static const String _userNameKey = 'user_name';
  static const String _firstNameKey = 'first_name';
  static const String _lastNameKey = 'last_name';
  static const String _userEmailKey = 'user_email';
  static const String _clinicNameKey = 'clinic_name';
  static const String _locationIdKey = 'location_id';
  static const String _locationNameKey = 'location_name';
  static const String _locationFullNameKey = 'location_full_name';
  static const String _detailedAddressKey = 'detailed_address';
  static const String _profileImageUrlKey = 'profile_image_url';
  static const String _selectedClinicIdKey = 'selected_clinic_id';
  static const String _userRoleKey = 'user_role';

  final SharedPreferences _prefs;

  UserStorage(this._prefs);

  Future<void> saveUserName(String name) async =>
      _prefs.setString(_userNameKey, name);
  String? getUserName() => _prefs.getString(_userNameKey);

  Future<void> saveFirstName(String name) async =>
      _prefs.setString(_firstNameKey, name);
  String? getFirstName() => _prefs.getString(_firstNameKey);

  Future<void> saveLastName(String name) async =>
      _prefs.setString(_lastNameKey, name);
  String? getLastName() => _prefs.getString(_lastNameKey);

  Future<void> saveUserEmail(String email) async =>
      _prefs.setString(_userEmailKey, email);
  String? getUserEmail() => _prefs.getString(_userEmailKey);

  Future<void> saveClinicName(String name) async =>
      _prefs.setString(_clinicNameKey, name);
  String? getClinicName() => _prefs.getString(_clinicNameKey);

  Future<void> saveLocationId(String id) async =>
      _prefs.setString(_locationIdKey, id);
  String? getLocationId() => _prefs.getString(_locationIdKey);

  Future<void> saveLocationName(String name) async =>
      _prefs.setString(_locationNameKey, name);
  String? getLocationName() => _prefs.getString(_locationNameKey);

  Future<void> saveLocationFullName(String fullName) async =>
      _prefs.setString(_locationFullNameKey, fullName);
  String? getLocationFullName() => _prefs.getString(_locationFullNameKey);

  Future<void> saveDetailedAddress(String address) async =>
      _prefs.setString(_detailedAddressKey, address);
  String? getDetailedAddress() => _prefs.getString(_detailedAddressKey);

  Future<void> saveProfileImageUrl(String url) async =>
      _prefs.setString(_profileImageUrlKey, url);
  String? getProfileImageUrl() => _prefs.getString(_profileImageUrlKey);

  Future<void> saveSelectedClinicId(String id) async =>
      _prefs.setString(_selectedClinicIdKey, id);
  String? getSelectedClinicId() => _prefs.getString(_selectedClinicIdKey);

  /// Cache the current user's role in the active clinic (e.g. "admin",
  /// "dentist"). Used by the menu to gate admin-only sections without a
  /// permissions round-trip.
  Future<void> saveUserRole(String role) async =>
      _prefs.setString(_userRoleKey, role);
  String? getUserRole() => _prefs.getString(_userRoleKey);
  bool get isAdmin => getUserRole() == 'admin';

  Future<void> clear() async {
    await _prefs.remove(_userNameKey);
    await _prefs.remove(_firstNameKey);
    await _prefs.remove(_lastNameKey);
    await _prefs.remove(_userEmailKey);
    await _prefs.remove(_clinicNameKey);
    await _prefs.remove(_locationIdKey);
    await _prefs.remove(_locationNameKey);
    await _prefs.remove(_locationFullNameKey);
    await _prefs.remove(_detailedAddressKey);
    await _prefs.remove(_profileImageUrlKey);
    await _prefs.remove(_selectedClinicIdKey);
    await _prefs.remove(_userRoleKey);
  }
}
