import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/features/home/presentation/theme/home_tokens.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The things started most often from home, as a strip of wide tiles.
///
/// Side by side rather than stacked: three of these used to cost three
/// full-width rows and most of the fold, pushing the day's schedule under it.
/// Position is what the hand learns - the tiles keep their order - while
/// colour stays reserved for meaning, as everywhere else in the app.
///
/// Icon and label share a line inside each tile, and the tiles take their
/// height from that line, so the strip is one band of the page rather than
/// three squares with captions hanging off them.
class QuickActions extends StatelessWidget {
  const QuickActions({
    super.key,
    required this.onAddPatient,
    required this.onScheduleVisit,
    this.onRecordPayment,
  });

  final VoidCallback onAddPatient;
  final VoidCallback onScheduleVisit;

  /// Null for a user with no expenses permission - the tile is dropped rather
  /// than left to jump at a tab that isn't there.
  final VoidCallback? onRecordPayment;

  /// Gap between tiles. Tighter than it was when these were squares: each
  /// tile now has a word to fit as well as a glyph, and every point of gutter
  /// is a point the word does not get.
  static double get _gap => 8;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // All three in the brand hue, like every other icon tile in the app.
    // A hue per action read as three unrelated buttons, and it spent colours
    // that mean something elsewhere: green is a settled payment, red is
    // destructive. Nothing about adding a patient is "info blue".
    final actions = <_QuickAction>[
      _QuickAction(
        icon: Icons.person_add_alt_1_outlined,
        label: l10n.patient,
        onTap: onAddPatient,
      ),
      _QuickAction(
        icon: Icons.calendar_month_outlined,
        label: l10n.appointment,
        onTap: onScheduleVisit,
      ),
      if (onRecordPayment != null)
        _QuickAction(
          icon: Icons.payments_outlined,
          label: l10n.payment,
          onTap: onRecordPayment!,
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
            _ActionRow(action: actions[i]),
          ],
        ],
      );
    }

    // Equal thirds: the strip reaches both gutters like every card above and
    // below it, and the three targets stay the same size whatever their
    // labels happen to be.
    return Row(
      children: [
        for (var i = 0; i < actions.length; i++) ...[
          if (i > 0) SizedBox(width: _gap.w),
          Expanded(child: _ActionTile(action: actions[i])),
        ],
      ],
    );
  }
}

/// One tile's content, so the list above reads as three declarations rather
/// than three widget trees.
class _QuickAction {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
}

/// The desktop shape: one row per action, icon tile leading the label, with
/// the hover feedback a pointer target is expected to have.
class _ActionRow extends StatefulWidget {
  const _ActionRow({required this.action});

  final _QuickAction action;

  @override
  State<_ActionRow> createState() => _ActionRowState();
}

class _ActionRowState extends State<_ActionRow> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final a = widget.action;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: a.onTap,
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
                  a.icon,
                  color: ColorManager.primaryDarker,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  a.label,
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

class _ActionTile extends StatefulWidget {
  const _ActionTile({required this.action});

  final _QuickAction action;

  @override
  State<_ActionTile> createState() => _ActionTileState();
}

class _ActionTileState extends State<_ActionTile> {
  bool _down = false;

  void _set(bool down) => setState(() => _down = down);

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);
    final a = widget.action;

    return GestureDetector(
      onTap: a.onTap,
      onTapDown: (_) => _set(true),
      onTapCancel: () => _set(false),
      onTapUp: (_) => _set(false),
      behavior: HitTestBehavior.opaque,
      // A press shrinks the tile rather than nudging it sideways, which on a
      // box this small only looks like a wobble.
      child: AnimatedScale(
        scale: _down ? 0.97 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 10.h),
          // A 16px card with a hairline edge, taking 1.5px in the brand hue
          // while pressed - the style's rule for a focused element.
          decoration: BoxDecoration(
            color: t.card,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: _down ? t.focusBorder : t.hairline,
              width: _down ? 1.5 : 1,
            ),
          ),
          // Icon above the label rather than beside it: side by side, a third
          // of a phone left "Appointment" room only at a smaller size than its
          // neighbours, and the row of tiles read as three different fonts.
          // Stacked, each label gets the tile's full width.
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // No tone: IconTile falls back to the brand hue, the same
              // tinted tile the settings rows and every other list use.
              IconTile(icon: a.icon, size: 30.w),
              SizedBox(height: 6.h),
              // Still scaled down rather than truncated as a last resort, for
              // a longer translation on a narrow phone.
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  a.label,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 12.5.sp,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                    color: t.ink,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
