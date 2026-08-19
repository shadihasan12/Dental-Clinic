import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:dental_clinic_app/core/constants/legal_urls.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';

/// Opens [url] in the device's default browser.
///
/// The legal documents are hosted publicly rather than bundled so they can be
/// updated without shipping a new build — the store listings point at the same
/// URLs. Shows a snackbar if no browser can handle the link.
Future<void> openLegalUrl(BuildContext context, String url) async {
  final l10n = AppLocalizations.of(context)!;
  final messenger = ScaffoldMessenger.of(context);

  final opened = await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  ).catchError((_) => false);

  if (!opened) {
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          l10n.couldNotOpenLink,
          style: TextStyle(fontFamily: FontHelper.fontFamily(context)),
        ),
      ),
    );
  }
}

/// Bottom sheet offering the Terms of Service and Privacy Policy.
///
/// Both stores require the policies to be reachable from inside the app, not
/// just from the store listing.
void showLegalLinksSheet(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  final c = ColorManager.of(context);

  showModalBottomSheet<void>(
    context: context,
    backgroundColor: c.scaffoldBg,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (sheetContext) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: c.divider,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 16.h),
          _LegalTile(
            icon: Icons.description_outlined,
            label: l10n.termsOfService,
            onTap: () {
              Navigator.pop(sheetContext);
              openLegalUrl(context, LegalUrls.termsOfService);
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 56.w),
            child: Divider(height: 1, color: c.divider),
          ),
          _LegalTile(
            icon: Icons.privacy_tip_outlined,
            label: l10n.privacyPolicy,
            onTap: () {
              Navigator.pop(sheetContext);
              openLegalUrl(context, LegalUrls.privacyPolicy);
            },
          ),
          SizedBox(height: 12.h),
        ],
      ),
    ),
  );
}

class _LegalTile extends StatelessWidget {
  const _LegalTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return ListTile(
      leading: Icon(icon, size: 20.w, color: c.iconDefault),
      title: Text(
        label,
        style: TextStyle(
          fontFamily: FontHelper.fontFamily(context),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: c.textPrimary,
        ),
      ),
      trailing: Icon(Icons.open_in_new, size: 16.w, color: c.textSubtle),
      onTap: onTap,
    );
  }
}
