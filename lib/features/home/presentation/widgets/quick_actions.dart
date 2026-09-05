import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

/// The three things started most often from home. Cards, not tinted blocks:
/// elevation is a hairline border, and the primary hue is spent on the icon
/// tile alone so the schedule above stays the loudest thing on the screen.
class QuickActions extends StatelessWidget {
  const QuickActions({
    super.key,
    required this.onAddPatient,
    required this.onScheduleVisit,
    required this.onNewCase,
    this.onRecordPayment,
  });

  final VoidCallback onAddPatient;
  final VoidCallback onScheduleVisit;
  final VoidCallback onNewCase;
  /// Null for a user with no expenses permission — the tile is dropped
  /// rather than left to jump at a tab that isn't there.
  final VoidCallback? onRecordPayment;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        _ActionItem(
          icon: Icons.person_add_alt_1_outlined,
          label: l10n.patient,
          onTap: onAddPatient,
        ),
        SizedBox(width: 8.w),
        _ActionItem(
          icon: Icons.calendar_month_outlined,
          label: l10n.appointment,
          onTap: onScheduleVisit,
        ),
        if (onRecordPayment != null) ...[
          SizedBox(width: 8.w),
          _ActionItem(
            icon: Icons.payments_outlined,
            label: l10n.payment,
            onTap: onRecordPayment!,
          ),
        ],
      ],
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
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
    return Expanded(
      child: Material(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 6.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: c.borderLight),
            ),
            child: Column(
              children: [
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    color: ColorManager.primaryDarker,
                    size: 17.w,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
