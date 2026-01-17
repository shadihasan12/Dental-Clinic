import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/gradient_manager.dart';

/// Gradient header for auth pages with logo and app name
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, this.height});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 320.h,
      decoration: BoxDecoration(
        gradient: GradientManager.primaryHeader,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Decorative circles
          Positioned(top: -60.h, right: -40.w, child: _circle(200.w, 0.1)),
          Positioned(top: 80.h, left: -50.w, child: _circle(120.w, 0.08)),
          Positioned(bottom: 60.h, right: 40.w, child: _circle(80.w, 0.06)),
          // Content
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogoContainer(),
                  SizedBox(height: 20.h),
                  Text(
                    'SmylOS Pro',
                    style: TextStyle(
                      color: ColorManager.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                      fontFamily: FontFamily.geist,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Professional Clinic Management',
                    style: TextStyle(
                      color: ColorManager.white.withValues(alpha: 0.9),
                      fontSize: 16.sp,
                      fontFamily: FontFamily.geist,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorManager.white.withValues(alpha: opacity),
      ),
    );
  }

  Widget _buildLogoContainer() {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Text('\u{1F9B7}', style: TextStyle(fontSize: 40.sp)),
      ),
    );
  }
}
