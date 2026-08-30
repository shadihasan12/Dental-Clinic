import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Anchor targets on the single-scroll patient screen. These replaced the old
/// three-tab TabBar: same groupings, but positions on one surface rather than
/// separate destinations.
enum PatientAnchor { caseSection, treatments, files, info }

/// Identity row: back, avatar, name + meta, edit.
///
/// Fixed at the top, above [PatientVitalsBar]. Between them they hold the
/// patient's name, the money and the rail - what the dentist reads
/// mid-appointment - so none of it is allowed to scroll away.
class PatientIdentityBar extends StatelessWidget {
  const PatientIdentityBar({
    super.key,
    required this.name,
    required this.subtitle,
    required this.onBack,
    this.onEdit,
  });

  final String name;
  final String subtitle;
  final VoidCallback onBack;
  final VoidCallback? onEdit;

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '?';
    return parts.take(2).map((p) => p.characters.first).join().toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return Container(
      color: c.surfaceBg,
      padding: EdgeInsets.fromLTRB(4.w, 4.h, 12.w, 12.h),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 20.w,
              color: c.textPrimary,
            ),
          ),
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              _initials,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                fontFamily: family,
                color: ColorManager.primaryDarker,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: family,
                    color: c.textPrimary,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: family,
                      color: c.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          if (onEdit != null)
            IconButton(
              onPressed: onEdit,
              icon: Icon(
                Icons.edit_outlined,
                size: 20.w,
                color: c.textSecondary,
              ),
            ),
        ],
      ),
    );
  }
}

/// Fixed strip carrying the two numbers that used to sit two taps apart: what
/// is owed, and how much work is left. The anchor rail rides underneath.
///
/// This was a pinned [SliverPersistentHeaderDelegate] inside the page's scroll
/// view. It is a plain box now so the pull-to-refresh band opens *below* the
/// rail rather than above it - and since its min and max extents were always
/// equal it never actually shrank, so nothing about how it looks changed.
class PatientVitalsBar extends StatelessWidget {
  const PatientVitalsBar({
    super.key,
    required this.outstandingLabel,
    required this.outstandingValue,
    required this.remainingLabel,
    required this.remainingValue,
    required this.anchors,
    required this.activeAnchor,
    required this.onAnchorTap,
    this.showVitals = true,
  });

  final String outstandingLabel;
  final String outstandingValue;
  final String remainingLabel;
  final String remainingValue;
  final List<({PatientAnchor anchor, String label})> anchors;
  final PatientAnchor activeAnchor;
  final ValueChanged<PatientAnchor> onAnchorTap;

  /// False when there is no open case. Both figures describe a case, so with
  /// none they would read "-" and "0" - two tiles claiming a state the
  /// patient is not in. The rail alone is kept in that case.
  final bool showVitals;

  /// Generous on purpose: the chips sit in a centred [Expanded] slot, so the
  /// slack absorbs the extra line height when the OS text scale is turned up
  /// rather than overflowing the bar by a fraction of a pixel.
  double get _height => showVitals ? 108.h : 44.h;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return Container(
      height: _height,
      decoration: BoxDecoration(
        color: c.surfaceBg,
        border: Border(bottom: BorderSide(color: c.borderLight)),
      ),
      child: Column(
        children: [
          if (showVitals)
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 2.h, 16.w, 6.h),
                child: Row(
                  children: [
                    Flexible(
                      child: _VitalChip(
                        label: outstandingLabel,
                        value: outstandingValue,
                        emphasise: true,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Flexible(
                      child: _VitalChip(
                        label: remainingLabel,
                        value: remainingValue,
                        emphasise: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          SizedBox(
            height: 38.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              itemCount: anchors.length,
              separatorBuilder: (_, __) => SizedBox(width: 6.w),
              itemBuilder: (_, i) {
                final a = anchors[i];
                final active = a.anchor == activeAnchor;
                return Center(
                  child: Material(
                    color: active
                        ? ColorManager.primary.withValues(alpha: 0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(999.r),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999.r),
                      onTap: () => onAnchorTap(a.anchor),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 7.h,
                        ),
                        child: Text(
                          a.label,
                          style: TextStyle(
                            fontSize: 11.5.sp,
                            fontWeight: active
                                ? FontWeight.w600
                                : FontWeight.w500,
                            fontFamily: family,
                            color: active
                                ? ColorManager.primaryDarker
                                : c.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// One pinned figure. The outstanding balance is tinted amber so it reads as
/// something owed at a glance; remaining work stays neutral.
class _VitalChip extends StatelessWidget {
  const _VitalChip({
    required this.label,
    required this.value,
    required this.emphasise,
  });

  final String label;
  final String value;
  final bool emphasise;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: emphasise
            ? ColorManager.warning.withValues(alpha: 0.10)
            : c.cardBgSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: emphasise
              ? ColorManager.warning.withValues(alpha: 0.35)
              : c.borderLight,
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
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4,
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
              fontSize: 17.sp,
              height: 1.1,
              fontWeight: FontWeight.w700,
              fontFamily: family,
              color: emphasise ? ColorManager.warning : c.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
