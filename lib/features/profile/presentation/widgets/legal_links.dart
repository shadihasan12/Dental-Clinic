import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:dental_clinic_app/custom_widgets/app_snackbar.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';

/// Opens [url] in the device's default browser.
///
/// The legal documents (privacy policy, terms of service, account deletion
/// instructions) are hosted publicly rather than bundled so they can be updated
/// without shipping a new build — the store listings point at the same URLs.
/// Shows a snackbar if no browser can handle the link.
Future<void> openLegalUrl(BuildContext context, String url) async {
  // Resolved before the await — the context may be gone by the time it returns.
  final message = AppLocalizations.of(context)!.couldNotOpenLink;

  final opened = await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  ).catchError((_) => false);

  if (!opened && context.mounted) {
    AppSnackbar.showError(context, title: message);
  }
}
