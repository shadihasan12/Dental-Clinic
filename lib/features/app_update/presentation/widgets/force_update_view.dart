import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/app_update/domain/entities/app_update_info.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_update_actions.dart';

/// The whole app, replaced.
///
/// Not a dialog over the app and not a route: it is returned in place of the
/// router itself, so there is no screen underneath to reach, nothing to
/// dismiss, and no back gesture that lands somewhere unexpected. That is the
/// difference between "forced" and "very insistent".
class ForceUpdateView extends StatelessWidget {
  const ForceUpdateView({super.key, required this.info});

  final AppUpdateInfo info;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    final notes = info.releaseNotes;

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 72.w,
                  height: 72.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Icon(
                    Icons.system_update,
                    size: 34.w,
                    color: ColorManager.primaryDarker,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  l10n.updateRequiredTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  l10n.updateForcedBody,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 12.sp,
                    height: 1.6,
                    color: c.textSecondary,
                  ),
                ),
                if (info.latestVersion != null) ...[
                  SizedBox(height: 12.h),
                  _VersionPill(version: info.latestVersion!),
                ],
                if (notes != null) ...[
                  SizedBox(height: 18.h),
                  _ReleaseNotes(notes: notes),
                ],
                SizedBox(height: 24.h),
                _UpdateButton(url: info.storeUrl!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VersionPill extends StatelessWidget {
  const _VersionPill({required this.version});

  final String version;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        l10n.updateVersionLabel(version),
        style: TextStyle(
          fontFamily: family,
          fontSize: 10.5.sp,
          fontWeight: FontWeight.w600,
          color: ColorManager.primaryDarker,
        ),
      ),
    );
  }
}

/// The server's own words about the build, shown as sent.
class _ReleaseNotes extends StatelessWidget {
  const _ReleaseNotes({required this.notes});

  final String notes;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: c.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.updateWhatsNew,
            style: TextStyle(
              fontFamily: family,
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w600,
              color: c.textPrimary,
            ),
          ),
          SizedBox(height: 7.h),
          Text(
            notes,
            style: TextStyle(
              fontFamily: family,
              fontSize: 11.5.sp,
              height: 1.55,
              color: c.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _UpdateButton extends StatelessWidget {
  const _UpdateButton({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    final radius = BorderRadius.circular(13.r);

    return Material(
      color: ColorManager.primary,
      borderRadius: radius,
      child: InkWell(
        onTap: () => openStore(context, url),
        borderRadius: radius,
        child: Container(
          width: double.infinity,
          height: 48.h,
          alignment: Alignment.center,
          child: Text(
            l10n.updateNow,
            style: TextStyle(
              fontFamily: family,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: ColorManager.white,
            ),
          ),
        ),
      ),
    );
  }
}
