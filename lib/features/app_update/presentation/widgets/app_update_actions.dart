import 'package:dental_clinic_app/custom_widgets/app_snackbar.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Sends the user to the store listing the backend named.
///
/// The URL is never built here. Play and the App Store address the same app
/// by different ids, and a store link assembled client-side is a link that
/// breaks the day a bundle id changes - in a build that is, by definition,
/// already the one users cannot update past.
Future<void> openStore(BuildContext context, String url) async {
  final failed = AppLocalizations.of(context)!.updateStoreUnavailable;

  final opened = await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  ).catchError((_) => false);

  if (!opened && context.mounted) {
    AppSnackbar.showError(context, title: failed);
  }
}
