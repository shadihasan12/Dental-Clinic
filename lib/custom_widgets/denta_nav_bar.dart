import 'dart:math' as math;
import 'dart:ui';

import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The four icons, taken verbatim from the redesign mockup so the shipped bar
/// draws the same geometry rather than an approximate Material lookalike.
///
/// Stroke colour is a placeholder - every icon is re-tinted with a `srcIn`
/// filter at paint time, which keeps one parsed picture per icon instead of
/// one per colour.
class DentaNavIcons {
  DentaNavIcons._();

  static const String home = 'M4 11l8-6.5 8 6.5V20H4z';
  static const String patients =
      'M9 8a3.2 3.2 0 1 0 0-6.4M9 8a3.2 3.2 0 1 1 0-6.4'
      'M3 20c0-3.3 2.7-5.4 6-5.4s6 2.1 6 5.4M17 9.5a2.6 2.6 0 1 0 0-5';
  static const String calendar =
      'M4 8a3 3 0 0 1 3-3h10a3 3 0 0 1 3 3v10a3 3 0 0 1-3 3H7a3 3 0 0 1-3-3z'
      'M8 3v4M16 3v4M4 11h16';
  static const String payments =
      'M3 9a3 3 0 0 1 3-3h12a3 3 0 0 1 3 3v6a3 3 0 0 1-3 3H6a3 3 0 0 1-3-3z'
      'M16 12h.01';

  static String wrap(String path) =>
      '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" '
      'stroke="#000000" stroke-width="1.8" stroke-linecap="round" '
      'stroke-linejoin="round"><path d="$path"/></svg>';
}

/// One destination in [DentaNavBar].
class DentaNavItem {
  const DentaNavItem({required this.label, required this.iconPath});

  final String label;

  /// An SVG path `d` string - see [DentaNavIcons].
  final String iconPath;
}

/// The redesign's nav bar: a floating pill inset from the screen edges, with a
/// blurred translucent surface and a hairline.
///
/// Only the active item carries a label; it widens into a soft primary capsule
/// while the other three stay as bare 48dp icon targets. That is the whole
/// affordance - there is no separate indicator to keep in sync.
class DentaNavBar extends StatelessWidget {
  const DentaNavBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<DentaNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  static const double _itemHeight = 48;
  static const double _pillPadding = 8;
  static const double _gap = 4;
  static const double _sideInset = 14;

  /// The active item takes this many width units, every other item takes one.
  static const int _activeFlex = 2;

  /// How far the pill floats above the bottom edge. It never sits closer to
  /// the edge than the system inset, so it clears a home indicator or a
  /// gesture bar without an extra platform check.
  static double bottomOffset(BuildContext context) =>
      math.max(16.h, MediaQuery.viewPaddingOf(context).bottom);

  /// Vertical space a page must leave free so the pill never covers content.
  static double reservedHeight(BuildContext context) =>
      _itemHeight.h + (_pillPadding * 2).h + bottomOffset(context) + 8.h;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeFg = isDark ? ColorManager.primary : ColorManager.primaryDarker;

    return PositionedDirectional(
      start: _sideInset.w,
      end: _sideInset.w,
      bottom: bottomOffset(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            padding: EdgeInsets.all(_pillPadding.w),
            decoration: BoxDecoration(
              color: c.surfaceBg.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: c.borderLight),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.gray900.withValues(alpha: 0.10),
                  blurRadius: 24.r,
                  offset: Offset(0, 6.h),
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Mirrors the mockup's `flex: active ? 2 : 1`: the active item
                // is two units wide, the rest one, which is what lets the
                // label appear without the icons drifting off centre.
                final units = items.length - 1 + _activeFlex;
                final available =
                    constraints.maxWidth - _gap.w * (items.length - 1);
                final unit = available / units;

                return Row(
                  children: [
                    for (var i = 0; i < items.length; i++) ...[
                      if (i > 0) SizedBox(width: _gap.w),
                      _NavItem(
                        item: items[i],
                        active: i == selectedIndex,
                        collapsedWidth: unit,
                        expandedWidth: unit * _activeFlex,
                        activeForeground: activeFg,
                        inactiveForeground: c.textSubtle,
                        onTap: () => onTap(i),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.active,
    required this.collapsedWidth,
    required this.expandedWidth,
    required this.activeForeground,
    required this.inactiveForeground,
    required this.onTap,
  });

  final DentaNavItem item;
  final bool active;
  final double collapsedWidth;
  final double expandedWidth;
  final Color activeForeground;
  final Color inactiveForeground;
  final VoidCallback onTap;

  /// Long enough to read as a movement rather than a jump. The capsule, the
  /// tint, the icon colour and the label reveal all ride the same value, so
  /// they cannot drift out of step the way parallel implicit animations can.
  static const Duration _duration = Duration(milliseconds: 320);

  @override
  Widget build(BuildContext context) {
    final target = active ? 1.0 : 0.0;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: target, end: target),
      duration: _duration,
      curve: Curves.easeOutCubic,
      builder: (context, t, _) {
        final fg = Color.lerp(inactiveForeground, activeForeground, t)!;

        return Container(
          width: lerpDouble(collapsedWidth, expandedWidth, t),
          height: DentaNavBar._itemHeight.h,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: ColorManager.primary.withValues(alpha: 0.15 * t),
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Semantics(
                selected: active,
                button: true,
                label: item.label,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.string(
                      DentaNavIcons.wrap(item.iconPath),
                      width: 21.w,
                      height: 21.w,
                      colorFilter: ColorFilter.mode(fg, BlendMode.srcIn),
                    ),
                    // Widened from zero rather than inserted, so the icon
                    // slides off centre at the same rate the capsule opens.
                    if (t > 0)
                      ClipRect(
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          widthFactor: t,
                          child: Opacity(
                            opacity: t,
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(start: 7.w),
                              child: Text(
                                item.label,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 12.5.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: FontHelper.fontFamily(context),
                                  color: fg,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
