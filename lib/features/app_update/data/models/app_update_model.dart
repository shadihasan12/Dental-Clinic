import '../../domain/entities/app_update_info.dart';

/// Parses `GET /app/version`.
class AppUpdateModel {
  AppUpdateModel._();

  static AppUpdateInfo fromJson(Map<String, dynamic> json) {
    return AppUpdateInfo(
      requirement: _requirement(json['update']),
      latestVersion: _nonEmpty(json['latest_version']),
      storeUrl: _nonEmpty(json['store_url']),
      releaseNotes: _nonEmpty(json['release_notes']),
    );
  }

  /// An unrecognised value reads as "no update".
  ///
  /// This is the safe direction to fail in by a wide margin: a typo in a
  /// server config that read as `forced` would lock every user out of the
  /// app at once, while one that reads as `none` costs a prompt nobody saw.
  static AppUpdateRequirement _requirement(Object? raw) {
    switch (raw is String ? raw.toLowerCase().trim() : '') {
      case 'forced':
      case 'force':
      case 'required':
        return AppUpdateRequirement.forced;
      case 'optional':
      case 'available':
        return AppUpdateRequirement.optional;
      default:
        return AppUpdateRequirement.none;
    }
  }

  static String? _nonEmpty(Object? raw) =>
      raw is String && raw.trim().isNotEmpty ? raw.trim() : null;
}
