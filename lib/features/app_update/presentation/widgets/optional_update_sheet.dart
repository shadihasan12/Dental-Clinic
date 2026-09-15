import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/app_update/domain/entities/app_update_info.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The soft version of the same message.
///
/// Dismissible in every way a sheet normally is - the barrier, the drag, the
/// "Not now" button - and every one of those routes counts as declining it,
/// so the caller records the skip on whatever comes back rather than only on
/// the button.
class OptionalUpdateSheet extends StatelessWidget {
  const OptionalUpdateSheet({super.key, required this.info});

  final AppUpdateInfo info;

  /// Resolves true only when the user chose to update. Anything else - the
  /// button, the drag, the barrier tap, a back gesture - resolves false,
  /// which the gate reads as "declined this version".
  ///
  /// Opening the store is the caller's job. Doing it here would mean using
  /// this sheet's context immediately after popping it, which is a context
  /// that no longer has a place in the tree to read localisations from.
  static Future<bool> show(BuildContext context, AppUpdateInfo info) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => OptionalUpdateSheet(info: info),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    final notes = info.releaseNotes;

    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(
        20.w,
        10.h,
        20.w,
        20.h + MediaQuery.viewPaddingOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 38.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: c.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 18.h),
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(13.r),
                ),
                child: Icon(
                  Icons.system_update,
                  size: 20.w,
                  color: ColorManager.primaryDarker,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.updateAvailableTitle,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
                      ),
                    ),
                    if (info.latestVersion != null) ...[
                      SizedBox(height: 2.h),
                      Text(
                        l10n.updateVersionLabel(info.latestVersion!),
                        style: TextStyle(
                          fontFamily: family,
                          fontSize: 11.sp,
                          color: c.textSubtle,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Text(
            l10n.updateOptionalBody,
            style: TextStyle(
              fontFamily: family,
              fontSize: 11.5.sp,
              height: 1.55,
              color: c.textSecondary,
            ),
          ),
          if (notes != null) ...[
            SizedBox(height: 14.h),
            Text(
              l10n.updateWhatsNew,
              style: TextStyle(
                fontFamily: family,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
                color: c.textPrimary,
              ),
            ),
            SizedBox(height: 6.h),
            // Bounded: release notes are free text from the server and a long
            // changelog must not push the buttons off the screen.
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 140.h),
              child: SingleChildScrollView(
                child: Text(
                  notes,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 11.5.sp,
                    height: 1.55,
                    color: c.textSecondary,
                  ),
                ),
              ),
            ),
          ],
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _SheetButton(
                  label: l10n.updateLater,
                  onTap: () => Navigator.of(context).pop(false),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 2,
                child: _SheetButton(
                  label: l10n.updateNow,
                  filled: true,
                  onTap: () => Navigator.of(context).pop(true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SheetButton extends StatelessWidget {
  const _SheetButton({
    required this.label,
    required this.onTap,
    this.filled = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final radius = BorderRadius.circular(13.r);

    return Material(
      color: filled ? ColorManager.primary : c.cardBg,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          height: 46.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: radius,
            border: filled ? null : Border.all(color: c.border),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: family,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: filled ? ColorManager.white : c.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
