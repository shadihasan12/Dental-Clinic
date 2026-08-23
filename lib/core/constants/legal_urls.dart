/// Public URLs for the app's legal documents.
///
/// These pages are hosted on Firebase Hosting (project `tech-runbit-denta`)
/// and are deployed from the `legal/` directory at the repo root via
/// `firebase deploy --only hosting`. Hosting serves them without the `.html`
/// suffix, so the clean paths below are the canonical ones.
///
/// The same URLs must be entered in the store listings:
/// - Google Play Console → App content → Privacy policy / Data deletion
/// - App Store Connect → App Privacy → Privacy Policy URL
class LegalUrls {
  LegalUrls._();

  static const String _base = 'https://denta.runbit.tech';

  static const String privacyPolicy = '$_base/privacy';
  static const String termsOfService = '$_base/terms';
  static const String deleteAccount = '$_base/delete-account';
}
