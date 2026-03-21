import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:go_router/go_router.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.userName,
    required this.clinicName,
    this.profileImageUrl,
    this.onNotificationTap,
  });

  final String userName;
  final String clinicName;
  final String? profileImageUrl;
  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left: greeting + clinic
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.welcomeBack,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 14.sp,
                  color: c.textTertiary,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                userName,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 20.sp,
                  color: c.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.h),
              GestureDetector(
                onTap: () => context.pushNamed(AppRoutesNames.myClinics),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7.w,
                      height: 7.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4ADE80),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      clinicName,
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 13.sp,
                        color: ColorManager.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.chevron_right,
                      size: 16.w,
                      color: ColorManager.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Right: notification bell
        GestureDetector(
          onTap: onNotificationTap,
          child: Stack(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: c.cardBgSecondary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_outlined,
                  color: c.textSecondary,
                  size: 20.w,
                ),
              ),
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
          ),
        ),
      ],
    );
  }
}