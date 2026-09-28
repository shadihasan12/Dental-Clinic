import 'package:package_info_plus/package_info_plus.dart';

/// The running build's version (pubspec `version:`, e.g. `1.0.2`), read
/// once per launch and shared by every place that shows it.
///
/// Resolves to null when the platform cannot report it, so a label can
/// simply stay empty instead of showing a number that might be wrong.
final Future<String?> appVersion = PackageInfo.fromPlatform()
    .then<String?>((info) => info.version.isEmpty ? null : info.version)
    .catchError((Object _) => null);
