import 'dart:math' as math;

import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Skeleton for the reports list.
///
/// Mirrors [IssueCard]'s slots — icon tile, two text lines, pill — so the
/// list does not jump when the real rows arrive.
class IssuesSkeleton extends StatelessWidget {
  const IssuesSkeleton({super.key, this.rows = 3});

  final int rows;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Column(
      children: [
        for (var i = 0; i < rows; i++) ...[
          if (i > 0) SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.all(13.w),
            decoration: BoxDecoration(
              color: c.cardBg,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: c.borderLight),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(
                  width: 30.w,
                  height: 30.w,
                  radius: BorderRadius.circular(10.r),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: ShimmerBox(height: 12.h)),
                          SizedBox(width: 8.w),
                          ShimmerBox(width: 54.w, height: 16.h),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      ShimmerBox(height: 10.h),
                      SizedBox(height: 6.h),
                      ShimmerBox(width: 160.w, height: 10.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// Nothing filed yet. Dashed rather than solid so it reads as a slot
/// waiting to be filled, not as a card that failed to load.
class IssuesEmptyState extends StatelessWidget {
  const IssuesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    return CustomPaint(
      painter: _DashedBorderPainter(color: c.borderLight, radius: 16.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 26.h),
        child: Column(
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 26.w,
              color: c.textTertiary,
            ),
            SizedBox(height: 10.h),
            Text(
              l10n.noReportsYet,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
                fontFamily: FontHelper.fontFamily(context),
                color: c.textSecondary,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              l10n.noReportsYetHint,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: c.textTertiary,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The list could not be loaded. States what failed and offers Retry; the
/// compose form above stays usable either way.
class IssuesErrorState extends StatelessWidget {
  const IssuesErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorManager.error.withValues(alpha: isDark ? 0.4 : 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.cloud_off_rounded,
                size: 18.w,
                color: ColorManager.error,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  l10n.couldNotLoadReports,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontHelper.fontFamily(context),
                    color: c.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            message,
            style: TextStyle(
              fontSize: 11.sp,
              fontFamily: FontHelper.fontFamily(context),
              color: c.textSecondary,
              height: 1.35,
            ),
          ),
          SizedBox(height: 12.h),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: OutlinedButton(
              onPressed: onRetry,
              // padding and minimumSize are set explicitly rather than
              // inherited: the app's outlinedButtonTheme asks for 16px of
              // vertical padding and a 56px minimum, which a compact card
              // like this cannot give it. Constraining the button from the
              // outside instead squeezes the label to zero height and the
              // button renders blank.
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorManager.primary,
                side: const BorderSide(
                  color: ColorManager.primary,
                  width: 1.5,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                  vertical: 9.h,
                ),
                minimumSize: Size(0, 36.h),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11.r),
                ),
              ),
              child: Text(
                l10n.retry,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontHelper.fontFamily(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 1px dashed rounded rectangle. Flutter has no dashed BorderSide, so the
/// outline is walked with a path metric and drawn in segments.
class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  static const double _dash = 5;
  static const double _gap = 4;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(radius),
        ),
      );

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = math.min(distance + _dash, metric.length);
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance = next + _gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}
