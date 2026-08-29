import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
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
    required this.onRecordPayment,
  });

  final VoidCallback onAddPatient;
  final VoidCallback onScheduleVisit;
  final VoidCallback onNewCase;
  final VoidCallback onRecordPayment;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final actions = <({IconData icon, String label, VoidCallback onTap})>[
      (
        icon: Icons.person_add_alt_1_outlined,
        label: l10n.patient,
        onTap: onAddPatient,
      ),
      (
        icon: Icons.calendar_month_outlined,
        label: l10n.appointment,
        onTap: onScheduleVisit,
      ),
      (
        icon: Icons.payments_outlined,
        label: l10n.payment,
        onTap: onRecordPayment,
      ),
    ];

    // Desktop stacks them as full-width rows with a leading icon. Side by
    // side in a narrow sidebar column each tile would be barely wider than
    // its own icon, and the labels would start truncating.
    if (Responsive.isDesktop(context)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < actions.length; i++) ...[
            if (i > 0) const SizedBox(height: 8),
            _ActionRow(
              icon: actions[i].icon,
              label: actions[i].label,
              onTap: actions[i].onTap,
            ),
          ],
        ],
      );
    }

    return Row(
      children: [
        for (var i = 0; i < actions.length; i++) ...[
          if (i > 0) SizedBox(width: 8.w),
          _ActionItem(
            icon: actions[i].icon,
            label: actions[i].label,
            onTap: actions[i].onTap,
          ),
        ],
      ],
    );
  }
}

/// The desktop shape: one row per action, icon tile leading the label, with
/// the hover feedback a pointer target is expected to have.
class _ActionRow extends StatefulWidget {
  const _ActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  State<_ActionRow> createState() => _ActionRowState();
}

class _ActionRowState extends State<_ActionRow> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: c.cardBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hovering
                  ? ColorManager.primary.withValues(alpha: 0.35)
                  : c.borderLight,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(11),
                ),
                alignment: Alignment.center,
                child: Icon(
                  widget.icon,
                  color: ColorManager.primaryDarker,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: _hovering ? ColorManager.primary : c.textTertiary,
              ),
            ],
          ),
        ),
      ),
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
