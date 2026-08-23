import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

export 'package:dental_clinic_app/core/widgets/directional_chevron.dart';
export 'package:dental_clinic_app/core/widgets/state_card.dart';

/// The pieces every Denta screen is assembled from, in one place so a screen
/// converted next month still matches the ones converted today.
///
/// The rules these encode, from DENTA_STYLE.md: 14px screen gutters, 16px
/// cards with a 1px hairline instead of a shadow, 13px/600 section headings,
/// 11px icon tiles tinted in their own hue, buttons at 11-13px, and 8px
/// between stacked cards.

/// Standard screen gutter.
double get dentaGutter => 14.w;

/// 13px/600 heading that names a group of cards.
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.title, {super.key, this.trailing});

  final String title;

  /// Optional action or count on the far side of the row.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final label = Text(
      title,
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        fontFamily: FontHelper.fontFamily(context),
        color: c.textPrimary,
      ),
    );

    if (trailing == null) return label;
    return Row(
      children: [
        Expanded(child: label),
        SizedBox(width: 8.w),
        trailing!,
      ],
    );
  }
}

/// A white surface with a hairline edge. Elevation is the border, never a
/// shadow. Pass [tone] to mark the card as a problem surface, or
/// [statusTone] to carry a status on the leading edge.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.tone,
    this.radius,
    this.statusTone,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? tone;
  final double? radius;

  /// Paints the 3px status strip down the leading edge - the style's way of
  /// marking state on a list card. Null leaves the card unmarked. It is a
  /// painted strip rather than a `Border` because a non-uniform border
  /// cannot take a radius, and it is directional so Arabic gets it on the
  /// right.
  final Color? statusTone;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final r = BorderRadius.circular(radius ?? 16.r);
    final edge = tone == null ? c.borderLight : tone!.withValues(alpha: 0.35);
    final body = Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: r,
        border: Border.all(color: edge),
      ),
      child: child,
    );

    final Widget surface = onTap == null
        ? DecoratedBox(
            decoration: BoxDecoration(color: c.cardBg, borderRadius: r),
            child: body,
          )
        : Material(
            color: c.cardBg,
            borderRadius: r,
            child: InkWell(onTap: onTap, borderRadius: r, child: body),
          );

    if (statusTone == null) return surface;
    return ClipRRect(
      borderRadius: r,
      child: Stack(
        children: [
          surface,
          PositionedDirectional(
            start: 0,
            top: 0,
            bottom: 0,
            width: 3,
            child: ColoredBox(color: statusTone!),
          ),
        ],
      ),
    );
  }
}

/// A tinted square holding one glyph. 11px radius, hue at 12%.
class IconTile extends StatelessWidget {
  const IconTile({
    super.key,
    required this.icon,
    this.tone,
    this.size,
    this.iconSize,
  });

  final IconData icon;
  final Color? tone;
  final double? size;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final accent = tone ?? ColorManager.primary;
    final box = size ?? 32.w;
    return Container(
      width: box,
      height: box,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: Icon(
        icon,
        size: iconSize ?? box * 0.53,
        color: accent == ColorManager.primary
            ? ColorManager.primaryDarker
            : accent,
      ),
    );
  }
}

/// The small count that sits beside a screen title or a section heading.
class CountPill extends StatelessWidget {
  const CountPill(this.count, {super.key, this.tone}) : label = null;

  /// The same pill carrying a short phrase instead of a bare number - "3 of
  /// 5 on" and the like, where the count alone would not say what it counts.
  const CountPill.label(this.label, {super.key, this.tone}) : count = null;

  final int? count;
  final String? label;
  final Color? tone;

  @override
  Widget build(BuildContext context) {
    final accent = tone ?? ColorManager.primary;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label ?? '$count',
        style: TextStyle(
          fontFamily: FontHelper.fontFamily(context),
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          height: 1.3,
          color: accent == ColorManager.primary
              ? ColorManager.primaryDarker
              : accent,
        ),
      ),
    );
  }
}

/// Filled action in the brand hue. [icon] renders ahead of the label; set
/// [expand] for the full-width form a sheet or an empty state wants.
class DentaButton extends StatelessWidget {
  const DentaButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.expand = false,
    this.tone,
    this.busy = false,
  });

  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool expand;
  final Color? tone;

  /// Swaps the label for a spinner and blocks the tap.
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12.r);
    final accent = tone ?? ColorManager.primary;
    final enabled = onTap != null && !busy;

    final content = busy
        ? SizedBox(
            width: 16.w,
            height: 16.w,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(ColorManager.white),
            ),
          )
        : Row(
            mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16.w, color: ColorManager.white),
                SizedBox(width: 6.w),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.white,
                  ),
                ),
              ),
            ],
          );

    final button = Material(
      color: enabled ? accent : accent.withValues(alpha: 0.45),
      borderRadius: radius,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: radius,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: expand ? 16.w : 14.w,
            vertical: expand ? 13.h : 9.h,
          ),
          child: content,
        ),
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// White with a 1px border in its own hue. The action beside a primary one.
class DentaOutlineButton extends StatelessWidget {
  const DentaOutlineButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.expand = false,
    this.tone,
  });

  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool expand;

  /// Colours the border and the label. Defaults to a neutral outline.
  final Color? tone;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final radius = BorderRadius.circular(12.r);
    final accent = tone ?? ColorManager.primary;
    final edge = tone == null
        ? c.border
        : (accent == ColorManager.primary
            ? ColorManager.primaryLighter
            : accent.withValues(alpha: 0.45));
    final labelColor = tone == null
        ? c.textSecondary
        : (accent == ColorManager.primary
            ? ColorManager.primaryDarker
            : accent);

    final button = Material(
      color: c.cardBg,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: expand ? 16.w : 14.w,
            vertical: expand ? 13.h : 9.h,
          ),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: edge),
          ),
          child: Row(
            mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16.w, color: labelColor),
                SizedBox(width: 6.w),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    color: labelColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// One labelled value inside a card: 9.5px uppercase micro-label above, the
/// value below. The shape the reference uses for every number it pins.
class ValueTile extends StatelessWidget {
  const ValueTile({
    super.key,
    required this.label,
    required this.value,
    this.tone,
    this.valueSize,
  });

  final String label;
  final String value;

  /// Tints the tile when the value is a problem rather than a fact.
  final Color? tone;
  final double? valueSize;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final problem = tone != null;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: problem ? tone!.withValues(alpha: 0.10) : c.cardBgSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: problem ? tone!.withValues(alpha: 0.35) : c.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 9.5.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
              height: 1.3,
              fontFamily: family,
              color: c.textTertiary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: valueSize ?? 15.sp,
              height: 1.1,
              fontWeight: FontWeight.w700,
              fontFamily: family,
              color: problem ? tone : c.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
