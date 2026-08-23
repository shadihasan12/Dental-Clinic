import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Skeleton for the single-scroll patient screen.
///
/// The header keeps its balance and count slots at full size so the layout
/// does not jump the moment real data lands.
class PatientDetailSkeleton extends StatelessWidget {
  const PatientDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _block(c, height: 64.h),
          SizedBox(height: 12.h),
          _block(c, height: 120.h),
          SizedBox(height: 16.h),
          _bar(c, width: 110.w, height: 14.h),
          SizedBox(height: 12.h),
          for (var i = 0; i < 4; i++) ...[
            _block(c, height: 68.h),
            SizedBox(height: 10.h),
          ],
          SizedBox(height: 8.h),
          _block(c, height: 96.h),
        ],
      ),
    );
  }

  Widget _block(AppColors c, {required double height}) => AppShimmer(
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: c.shimmerBase,
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
      );

  Widget _bar(AppColors c, {required double width, required double height}) =>
      AppShimmer(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: c.shimmerBase,
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
      );
}

/// Shared shell for the three "nothing to show" states so they keep one shape.
class PatientDetailPlaceholder extends StatelessWidget {
  const PatientDetailPlaceholder({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.tone,
    this.primaryLabel,
    this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
  });

  final IconData icon;
  final String title;
  final String? message;

  /// Accent for the glyph disc. Defaults to the app primary.
  final Color? tone;

  final String? primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final accent = tone ?? ColorManager.primary;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22.w, color: accent),
          ),
          SizedBox(height: 14.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              fontFamily: family,
              color: c.textPrimary,
            ),
          ),
          if (message != null) ...[
            SizedBox(height: 6.h),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.5.sp,
                height: 1.45,
                fontFamily: family,
                color: c.textSecondary,
              ),
            ),
          ],
          if (primaryLabel != null || secondaryLabel != null) ...[
            SizedBox(height: 18.h),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10.w,
              runSpacing: 8.h,
              children: [
                if (primaryLabel != null)
                  _Action(
                    label: primaryLabel!,
                    onTap: onPrimary,
                    filled: true,
                    tone: accent,
                  ),
                if (secondaryLabel != null)
                  _Action(
                    label: secondaryLabel!,
                    onTap: onSecondary,
                    filled: false,
                    tone: accent,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({
    required this.label,
    required this.onTap,
    required this.filled,
    required this.tone,
  });

  final String label;
  final VoidCallback? onTap;
  final bool filled;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Material(
      color: filled ? tone : Colors.transparent,
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: filled ? null : Border.all(color: c.border),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w600,
              fontFamily: FontHelper.fontFamily(context),
              color: filled ? ColorManager.white : c.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

/// "Could not load this patient" - the whole screen failed.
class PatientDetailErrorState extends StatelessWidget {
  const PatientDetailErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: PatientDetailPlaceholder(
          icon: Icons.cloud_off_rounded,
          tone: ColorManager.error,
          title: l10n.couldNotLoadPatient,
          message: message,
          primaryLabel: l10n.retry,
          onPrimary: onRetry,
        ),
      ),
    );
  }
}
