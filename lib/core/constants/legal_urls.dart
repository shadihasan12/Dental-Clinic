/// Public URLs for the app's legal documents.
///
/// These pages are hosted on Firebase Hosting (project `tech-runbit-denta`)
/// and are deployed from the `legal/` directory at the repo root via
/// `firebase deploy --only hosting`.
///
/// The same URLs must be entered in the store listings:
/// - Google Play Console → App content → Privacy policy / Data deletion
/// - App Store Connect → App Privacy → Privacy Policy URL
class LegalUrls {
  LegalUrls._();

  static const String _base = 'https://tech-runbit-denta.web.app';

  static const String privacyPolicy = '$_base/privacy.html';
  static const String termsOfService = '$_base/terms.html';
  static const String deleteAccount = '$_base/delete-account.html';
}
