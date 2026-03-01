import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/gradient_manager.dart';

/// Gradient header widget with decorative circles
/// Used for authentication pages and hero sections
class GradientHeader extends StatelessWidget {
  const GradientHeader({
    super.key,
    this.title,
    this.subtitle,
    this.height,
    this.showBackButton = false,
    this.onBackPressed,
    this.child,
    this.bottomPadding,
  });

  final String? title;
  final String? subtitle;
  final double? height;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget? child;
  final double? bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 280.h,
      decoration: BoxDecoration(
        gradient: GradientManager.primaryHeader,
      ),
      child: Stack(
        children: [
          // Decorative circles
          _buildDecorativeCircles(),

          // Back button at top
          if (showBackButton)
            Positioned(
              top: MediaQuery.of(context).padding.top + 12.h,
              left: 20.w,
              child: _buildBackButton(),
            ),
          // Title and subtitle at bottom
          Positioned(
            left: 20.w,
            right: 20.w,
            bottom: bottomPadding ?? 20.h,
            child: child ??
                Builder(
                  builder: (context) {
                    final fontFamily = FontHelper.fontFamily(context);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null)
                          Text(
                            title!,
                            style: TextStyle(
                              color: ColorManager.white,
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSizesManager.s22,
                              fontFamily: fontFamily,
                            ),
                          ),
                        if (subtitle != null) ...[
                          SizedBox(height: 4.h),
                          Text(
                            subtitle!,
                            style: TextStyle(
                              color: ColorManager.white.withValues(alpha: 0.9),
                              fontSize: FontSizesManager.s16,
                              fontFamily: fontFamily,
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: onBackPressed,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: ColorManager.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: ColorManager.white,
          size: 20.w,
        ),
      ),
    );
  }

  Widget _buildDecorativeCircles() {
    return Stack(
      children: [
        // Top right large circle
        Positioned(
          top: -50.h,
          right: -50.w,
          child: Container(
            width: 200.w,
            height: 200.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorManager.white.withValues(alpha: 0.1),
            ),
          ),
        ),
        // Top left small circle
        Positioned(
          top: 60.h,
          left: -30.w,
          child: Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorManager.white.withValues(alpha: 0.08),
            ),
          ),
        ),
        // Bottom right medium circle
        Positioned(
          bottom: 20.h,
          right: 60.w,
          child: Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorManager.white.withValues(alpha: 0.06),
            ),
          ),
        ),
      ],
    );
  }
}

/// Simple gradient background container
class GradientBackground extends StatelessWidget {
  const GradientBackground({
    super.key,
    required this.child,
    this.gradient,
  });

  final Widget child;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient ?? GradientManager.backgroundSubtle,
      ),
      child: child,
    );
  }
}
