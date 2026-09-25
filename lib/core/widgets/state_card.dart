import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The one shape every "nothing to show" and "this failed" state in the app
/// uses, so an empty list looks the same wherever the user meets it.
///
/// A quiet grey disc by default - an empty list is an absence, not a problem.
/// Pass [tone] (usually [ColorManager.error]) and the disc, its ring and the
/// card border take that hue instead, which is what marks a failure apart
/// from an absence at a glance.
class StateCard extends StatelessWidget {
  const StateCard({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.detail,
    this.tone,
    this.actionLabel,
    this.onAction,
    this.minHeight,
  });

  final IconData icon;
  final String title;

  /// One sentence. Says what fills the list, or what failed.
  final String? message;

  /// Optional second line, quieter than [message] - used by error states to
  /// state what was *not* changed.
  final String? detail;

  final Color? tone;
  final String? actionLabel;
  final VoidCallback? onAction;

  /// Floor for the card's height, so a desktop empty state fills the region
  /// it replaces instead of sitting as a short strip at the top of it. The
  /// content stays vertically centred inside whatever height results.
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final isProblem = tone != null;
    final edge = isProblem ? tone!.withValues(alpha: 0.35) : c.borderLight;

    return Container(
      width: double.infinity,
      constraints: minHeight == null
          ? null
          : BoxConstraints(minHeight: minHeight!),
      padding: EdgeInsets.fromLTRB(20.w, 26.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: edge),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: minHeight == null ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: isProblem
                  ? tone!.withValues(alpha: 0.10)
                  : c.cardBgSecondary,
              shape: BoxShape.circle,
              border: Border.all(color: edge),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 24.w, color: tone ?? c.textSubtle),
          ),
          SizedBox(height: 14.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: family,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: c.textPrimary,
            ),
          ),
          if (message != null) ...[
            SizedBox(height: 6.h),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: family,
                fontSize: 11.5.sp,
                height: 1.5,
                color: isProblem ? c.textSecondary : ColorManager.primaryLight,
              ),
            ),
          ],
          if (detail != null) ...[
            SizedBox(height: 6.h),
            Text(
              detail!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: family,
                fontSize: 11.sp,
                height: 1.45,
                color: c.textTertiary,
              ),
            ),
          ],
          if (actionLabel != null) ...[
            SizedBox(height: 18.h),
            // Full width is right on a phone, but stretched across a desktop
            // column the button reads as a banner rather than a control, so
            // it is capped and centred under the message.
            Align(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: Responsive.isDesktop(context) ? 0 : double.infinity,
                  maxWidth: Responsive.isDesktop(context)
                      ? 260
                      : double.infinity,
                ),
                child: Material(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(12.r),
                  child: InkWell(
                    onTap: onAction,
                    borderRadius: BorderRadius.circular(12.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 13.h,
                        horizontal: 20.w,
                      ),
                      child: Text(
                        actionLabel!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: family,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
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
