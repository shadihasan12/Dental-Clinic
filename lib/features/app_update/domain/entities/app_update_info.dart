/// What the backend decided about the running build.
enum AppUpdateRequirement {
  /// Current enough. Nothing is shown.
  none,

  /// A newer build exists. The user is offered it and may decline.
  optional,

  /// This build is below the supported floor. The app is unusable until it
  /// is updated.
  forced,
}

/// The answer from `GET /app/version`.
///
/// The *decision* is the server's, not the app's. A client that compared
/// version strings itself could only ever apply the rule it shipped with -
/// and the whole point of a force-update switch is to change the rule after
/// the build is in users' hands, for a build whose bug you did not know
/// about when you shipped it.
class AppUpdateInfo {
  const AppUpdateInfo({
    required this.requirement,
    this.latestVersion,
    this.storeUrl,
    this.releaseNotes,
  });

  const AppUpdateInfo.none()
    : requirement = AppUpdateRequirement.none,
      latestVersion = null,
      storeUrl = null,
      releaseNotes = null;

  final AppUpdateRequirement requirement;

  /// The version being offered. Used to remember which one the user
  /// declined, so an optional prompt is not shown twice for the same build.
  final String? latestVersion;

  /// Where to send the user. Null when the server did not say, which is the
  /// one case a forced prompt cannot resolve - see [isActionable].
  final String? storeUrl;

  final String? releaseNotes;

  bool get isForced => requirement == AppUpdateRequirement.forced;
  bool get isOptional => requirement == AppUpdateRequirement.optional;

  /// Whether there is an update the app can actually send the user to.
  ///
  /// A prompt with no store URL is a dead end, and a *forced* one would be a
  /// dead end the user cannot leave - it would brick the app for everyone it
  /// reached. So a decision with nowhere to go is treated as no decision.
  bool get isActionable =>
      requirement != AppUpdateRequirement.none &&
      storeUrl != null &&
      storeUrl!.isNotEmpty;
}
