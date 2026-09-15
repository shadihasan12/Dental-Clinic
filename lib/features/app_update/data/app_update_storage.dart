import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Remembers which optional update the user declined.
///
/// Per version, not per launch: someone who said "not now" to 1.2.0 meant it,
/// and asking again every cold start is how a prompt becomes something users
/// dismiss without reading. A newer version is a new question, so 1.3.0 asks
/// again. A *forced* update never consults this - there is nothing to decline.
///
/// Deliberately outside [UserStorage]: it is a fact about the device and the
/// build, not about the account, so it must survive logout.
@injectable
class AppUpdateStorage {
  AppUpdateStorage(this._prefs);

  static const String _skippedVersionKey = 'skipped_update_version';

  final SharedPreferences _prefs;

  String? get skippedVersion => _prefs.getString(_skippedVersionKey);

  Future<void> skipVersion(String version) =>
      _prefs.setString(_skippedVersionKey, version);

  /// True when this exact version has already been declined.
  ///
  /// A null version from the server is never "already skipped": with nothing
  /// to compare, silently swallowing the prompt would hide a real update.
  bool hasSkipped(String? version) =>
      version != null && version.isNotEmpty && skippedVersion == version;
}
