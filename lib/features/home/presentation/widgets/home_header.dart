import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/features/home/presentation/manager/unread_count_cubit.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:go_router/go_router.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.userName,
    required this.clinicName,
    this.profileImageUrl,
    this.isLoading = false,
    this.onNotificationTap,
    this.onMoreTap,
  });

  final String userName;
  final String clinicName;
  final String? profileImageUrl;
  final bool isLoading;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onMoreTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left: greeting + clinic
        Expanded(
          child: isLoading
              ? _HeaderTextSkeleton()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
              // Driven by `unread_count`, which every read/unread/list
              // response carries - so it stays current without a request of
              // its own. No unread mail, no dot.
              Positioned(
                right: 6.w,
                top: 4.h,
                child: BlocBuilder<UnreadCountCubit, int>(
                  bloc: getIt<UnreadCountCubit>(),
                  builder: (context, unreadCount) {
                    if (unreadCount == 0) return const SizedBox.shrink();
                    return Container(
                      constraints: BoxConstraints(minWidth: 16.w),
                      height: 16.w,
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: ColorManager.error,
                        borderRadius: BorderRadius.circular(8.w),
                        border: Border.all(color: c.cardBgSecondary, width: 1.5),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        // Past 99 the pill would outgrow the bell.
                        unreadCount > 99 ? '99+' : '$unreadCount',
                        style: TextStyle(
                          fontFamily: FontHelper.fontFamily(context),
                          fontSize: 9.sp,
                          height: 1,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 8.w),

        // Right: more menu
        GestureDetector(
          onTap: onMoreTap,
          child: Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: c.cardBgSecondary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.settings_outlined,
              color: c.textSecondary,
              size: 20.w,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderTextSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerBox(width: 180.w, height: 22.h),
        SizedBox(height: 8.h),
        ShimmerBox(width: 140.w, height: 13.h),
      ],
    );
  }
}