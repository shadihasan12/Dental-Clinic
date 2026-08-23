import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Safety strip for recorded clinical flags. Never collapsible - the whole
/// point is that a penicillin allergy cannot hide behind a chevron.
///
/// Renders nothing at all when neither allergies nor medical history are on
/// file: the old UI hardcoded "None", which is a clinical hazard because an
/// unrecorded allergy and a confirmed absence looked identical. Staying silent
/// makes no claim either way, and keeps the top of the screen for the case.
class ClinicalAlertsStrip extends StatelessWidget {
  const ClinicalAlertsStrip({
    super.key,
    required this.allergies,
    required this.medicalHistory,
    this.onEditAllergies,
    this.onReviewHistory,
  });

  final String? allergies;
  final String? medicalHistory;
  final VoidCallback? onEditAllergies;
  final VoidCallback? onReviewHistory;

  static bool _blank(String? v) {
    if (v == null) return true;
    final t = v.trim().toLowerCase();
    // The API and the old UI both used these to mean "nothing recorded",
    // which is not the same as a clinician confirming there is nothing.
    return t.isEmpty || t == 'none' || t == 'n/a' || t == '-';
  }

  /// True when there is something recorded worth surfacing. Callers use this
  /// to decide whether to reserve spacing above the case card.
  bool get hasAlerts => !_blank(allergies) || !_blank(medicalHistory);

  @override
  Widget build(BuildContext context) {
    if (!hasAlerts) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;
    final hasAllergies = !_blank(allergies);
    final hasHistory = !_blank(medicalHistory);

    return Column(
      children: [
        if (hasAllergies)
          _AlertRow(
            tone: ColorManager.error,
            icon: Icons.warning_amber_rounded,
            title: '${l10n.allergyPrefix} - ${allergies!.trim()}',
            actionLabel: l10n.edit,
            onAction: onEditAllergies,
          ),
        if (hasHistory) ...[
          if (hasAllergies) SizedBox(height: 8.h),
          _AlertRow(
            tone: null,
            icon: Icons.history_rounded,
            title: '${l10n.medicalHistory} - ${medicalHistory!.trim()}',
            actionLabel: l10n.reviewAction,
            onAction: onReviewHistory,
          ),
        ],
        SizedBox(height: 14.h),
      ],
    );
  }
}

class _AlertRow extends StatelessWidget {
  const _AlertRow({
    required this.tone,
    required this.icon,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  /// null renders the quiet neutral variant used when there is genuinely
  /// nothing to warn about.
  final Color? tone;
  final IconData icon;
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final accent = tone ?? c.textTertiary;
    final bg = tone == null
        ? c.cardBgSecondary
        : tone!.withValues(alpha: 0.10);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: tone == null ? c.borderLight : tone!.withValues(alpha: 0.28),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18.w, color: accent),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.35,
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: family,
                    color: tone == null ? c.textSecondary : c.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            SizedBox(width: 8.w),
            InkWell(
              onTap: onAction,
              borderRadius: BorderRadius.circular(8.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Text(
                  actionLabel!,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: family,
                    color: accent,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
