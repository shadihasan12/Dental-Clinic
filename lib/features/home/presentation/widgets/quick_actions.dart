import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/directional_chevron.dart';
import 'package:dental_clinic_app/features/home/presentation/theme/home_tokens.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The three things started most often from home.
///
/// Handoff section 4: full-width rows rather than a tile strip, each with a
/// coloured chip and a chevron. Each action owns a hue and keeps it, so
/// after a day or two the user is aiming at a colour and a position rather
/// than reading three labels every time.
class QuickActions extends StatelessWidget {
  const QuickActions({
    super.key,
    required this.onAddPatient,
    required this.onScheduleVisit,
    this.onRecordPayment,
  });

  final VoidCallback onAddPatient;
  final VoidCallback onScheduleVisit;

  /// Null for a user with no expenses permission - the row is dropped rather
  /// than left to jump at a tab that isn't there.
  final VoidCallback? onRecordPayment;

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        _ActionRow(
          icon: Icons.person_add_alt_1_outlined,
          label: l10n.patient,
          chip: t.patientChip,
          tone: t.patientIcon,
          onTap: onAddPatient,
        ),
        SizedBox(height: 8.h),
        _ActionRow(
          icon: Icons.calendar_month_outlined,
          label: l10n.appointment,
          chip: t.tint,
          tone: t.primaryDark,
          onTap: onScheduleVisit,
        ),
        if (onRecordPayment != null) ...[
          SizedBox(height: 8.h),
          _ActionRow(
            icon: Icons.payments_outlined,
            label: l10n.payment,
            chip: t.paymentChip,
            tone: t.paymentIcon,
            onTap: onRecordPayment!,
          ),
        ],
      ],
    );
  }
}

class _ActionRow extends StatefulWidget {
  const _ActionRow({
    required this.icon,
    required this.label,
    required this.chip,
    required this.tone,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color chip;
  final Color tone;
  final VoidCallback onTap;

  @override
  State<_ActionRow> createState() => _ActionRowState();
}

class _ActionRowState extends State<_ActionRow> {
  bool _down = false;

  void _set(bool down) => setState(() => _down = down);

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _set(true),
      onTapCancel: () => _set(false),
      onTapUp: (_) => _set(false),
      // Nudged along the reading direction, so the press leans the same way
      // in Arabic as it does in English.
      child: AnimatedSlide(
        offset: _down ? const Offset(0.006, 0) : Offset.zero,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: t.card,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: _down ? t.focusBorder : t.hairline),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: widget.chip,
                  borderRadius: BorderRadius.circular(13.r),
                ),
                child: Icon(widget.icon, size: 19.w, color: widget.tone),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  widget.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 14.5.sp,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: t.ink,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              DirectionalChevron(size: 16.w, color: t.chevron),
            ],
          ),
        ),
      ),
    );
  }
}
