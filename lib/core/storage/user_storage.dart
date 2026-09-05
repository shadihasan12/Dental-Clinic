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

  /// Notifier that increments whenever a patient is added, updated, or
  /// detached. The patients list listens to this so multi-step flows (e.g.
  /// add patient → auto-jump to add treatment → back) still refresh.
  static final ValueNotifier<int> patientsChangedNotifier = ValueNotifier<int>(
    0,
  );

  static void notifyPatientsChanged() {
    patientsChangedNotifier.value++;
  }

  /// Notifier that increments whenever an appointment is created, or has its
  /// status changed or cancelled, from anywhere in the app. Home's Today's
  /// Schedule listens to this so a status edited on the Appointments tab is
  /// reflected the moment the user goes back, instead of the section holding
  /// its first load until the app is killed and reopened.
  static final ValueNotifier<int> appointmentsChangedNotifier =
      ValueNotifier<int>(0);

  static void notifyAppointmentsChanged() {
    appointmentsChangedNotifier.value++;
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
  // Whether the user is the *owner* of the active clinic, not merely an
  // admin in it. Billing is the owner's alone, so the menu needs this
  // synchronously and per active clinic, exactly like the cached role.
  static const String _isClinicOwnerKey = 'is_clinic_owner';
  // Snapshot of the user's clinic membership count, persisted on login
  // so the share card can read it synchronously without an extra
  // network round-trip when the share sheet opens.
  static const String _clinicCountKey = 'clinic_count';
  // First time the app saw this account on this device. Used as the
  // "days on platform" anchor for the share card — we can't rely on
  // the backend's created_at being populated for every user.
  static const String _firstSeenAtKey = 'first_seen_at';
  // Which statistics share-card design the doctor picked last. A pure UI
  // preference, so it deliberately survives logout like theme or language.
  static const String _shareCardTemplateKey = 'share_card_template';

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

  /// Cache whether the user owns the active clinic. Saved next to the role
  /// at every point the active clinic can change, so a switch from a clinic
  /// the user owns to one they only work in flips this too.
  Future<void> saveIsClinicOwner(bool isOwner) async =>
      _prefs.setBool(_isClinicOwnerKey, isOwner);
  bool get isClinicOwner => _prefs.getBool(_isClinicOwnerKey) ?? false;

  Future<void> saveClinicCount(int count) async =>
      _prefs.setInt(_clinicCountKey, count);
  int? getClinicCount() => _prefs.getInt(_clinicCountKey);

  /// Returns the first-seen timestamp for this account on this device.
  /// Stamps "now" on the very first call so the value is sticky for
  /// the lifetime of the install — the share card uses the delta to
  /// show "X days providing care" without depending on a backend
  /// `created_at` we can't always trust.
  Future<DateTime> getOrInitFirstSeenAt() async {
    final iso = _prefs.getString(_firstSeenAtKey);
    if (iso != null && iso.isNotEmpty) {
      final parsed = DateTime.tryParse(iso);
      if (parsed != null) return parsed;
    }
    final now = DateTime.now();
    await _prefs.setString(_firstSeenAtKey, now.toIso8601String());
    return now;
  }

  Future<void> saveShareCardTemplate(String id) async =>
      _prefs.setString(_shareCardTemplateKey, id);
  String? getShareCardTemplate() => _prefs.getString(_shareCardTemplateKey);

  DateTime? getFirstSeenAt() {
    final iso = _prefs.getString(_firstSeenAtKey);
    if (iso == null || iso.isEmpty) return null;
    return DateTime.tryParse(iso);
  }

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
    await _prefs.remove(_isClinicOwnerKey);
    await _prefs.remove(_clinicCountKey);
    // Deliberately *not* clearing _firstSeenAtKey on logout — the
    // "days on platform" metric should reflect the install age, not
    // the current session age.
  }
}
