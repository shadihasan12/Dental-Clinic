import 'dart:math' as math;
import 'dart:ui';

import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Skeleton for the inbox.
///
/// Keeps the section label and card slots at their final size so nothing
/// jumps when the first page lands.
class NotificationListSkeleton extends StatelessWidget {
  const NotificationListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 24.h),
      children: [
        ShimmerBox(width: 60.w, height: 10.h),
        SizedBox(height: 10.h),
        for (var i = 0; i < 6; i++) ...[
          const _SkeletonCard(),
          SizedBox(height: 8.h),
        ],
      ],
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(
            width: 34.w,
            height: 34.w,
            radius: BorderRadius.circular(10.r),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(width: 150.w, height: 11.h),
                SizedBox(height: 7.h),
                ShimmerBox(width: double.infinity, height: 10.h),
                SizedBox(height: 6.h),
                ShimmerBox(width: 60.w, height: 9.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Nothing to show. Dashed rather than solid so it reads as a slot waiting to
/// be filled, not as a card that failed to load.
class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return CustomPaint(
      painter: _DashedBorderPainter(color: c.borderLight, radius: 16.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 26.h),
        child: Column(
          children: [
            Icon(
              Icons.notifications_none_rounded,
              size: 26.w,
              color: c.textTertiary,
            ),
            SizedBox(height: 10.h),
            Text(
              title,
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
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                height: 1.35,
                fontFamily: FontHelper.fontFamily(context),
                color: c.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The inbox could not be loaded. Names what failed and what that did *not*
/// change, then offers Retry.
class NotificationErrorState extends StatelessWidget {
  const NotificationErrorState({
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
    final family = FontHelper.fontFamily(context);
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
                  l10n.couldNotLoadNotifications,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: family,
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
              height: 1.35,
              fontFamily: family,
              color: c.textSecondary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            l10n.noNotificationsChanged,
            style: TextStyle(
              fontSize: 11.sp,
              height: 1.35,
              fontFamily: family,
              color: c.textTertiary,
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 36.h,
            child: OutlinedButton(
              onPressed: onRetry,
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorManager.primary,
                side: const BorderSide(color: ColorManager.primary, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11.r),
                ),
              ),
              child: Text(
                l10n.retry,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: family,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The single primary action, docked in the thumb arc behind a blur so the
/// last card stays legible under it.
class NotificationActionBar extends StatelessWidget {
  const NotificationActionBar({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  /// The list pads its tail by this much so the bar never covers a card.
  /// Mirrors the padding + button height below; keep the two in step.
  static double height(BuildContext context) =>
      64.h + MediaQuery.viewPaddingOf(context).bottom;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 10.h + bottomInset),
          decoration: BoxDecoration(
            color: c.surfaceBg.withValues(alpha: 0.88),
            border: Border(top: BorderSide(color: c.borderLight)),
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            // Sized by its own padding rather than a fixed box, so a tall
            // Cairo line box grows the button instead of being clipped.
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: ColorManager.white,
              elevation: 0,
              minimumSize: Size(double.infinity, 44.h),
              padding: EdgeInsets.symmetric(vertical: 11.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                height: 1.4,
                fontWeight: FontWeight.w600,
                fontFamily: FontHelper.fontFamily(context),
              ),
            ),
          ),
        ),
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
