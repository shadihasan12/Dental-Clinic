import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:go_router/go_router.dart';

/// Dashboard header with gradient background and user welcome message
class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
    required this.userName,
    required this.clinicName,
    this.onSearchTap,
    this.onNotificationTap,
  });

  final String userName;
  final String clinicName;
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF70B2B2), Color(0xFF5A9999), Color(0xFF4A8888)],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Decorative circles
          Positioned(
            top: -32.h,
            right: -32.w,
            child: Container(
              width: 160.w,
              height: 160.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            top: 80.h,
            left: -24.w,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          // Content
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopRow(),
                  SizedBox(height: 16.h),
                  _buildClinicBadge(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back,',
              style: TextStyle(
                fontFamily: FontFamily.geist,
                fontSize: 14.sp,
                color: ColorManager.white.withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              userName,
              style: TextStyle(
                fontFamily: FontFamily.geist,
                fontSize: 20.sp,
                color: ColorManager.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            _HeaderIconButton(icon: Icons.search, onTap: onSearchTap ?? () {}),
            SizedBox(width: 8.w),
            _NotificationButton(onTap: onNotificationTap ?? () {}),
          ],
        ),
      ],
    );
  }

  Widget _buildClinicBadge(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(AppRoutesNames.myClinics);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: ColorManager.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: const BoxDecoration(
                color: Color(0xFF4ADE80),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              clinicName,
              style: TextStyle(
                fontFamily: FontFamily.geist,
                fontSize: 12.sp,
                color: ColorManager.white.withValues(alpha: 0.9),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: ColorManager.white.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: ColorManager.white, size: 20.w),
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _HeaderIconButton(icon: Icons.notifications_outlined, onTap: onTap),
        Positioned(
          right: 10.w,
          top: 10.h,
          child: Container(
            width: 8.w,
            height: 8.w,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
