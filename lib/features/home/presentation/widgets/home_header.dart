import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/directional_chevron.dart';
import 'package:dental_clinic_app/core/widgets/unread_badge.dart';
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 17.sp,
                        letterSpacing: -0.3,
                        color: c.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // A tinted chip rather than bare text: the clinic
                    // switcher is a real destination, and a 6px-tall line of
                    // 11.5sp text was too small a target to hit reliably.
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Material(
                        color: ColorManager.primary.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(20.r),
                        child: InkWell(
                          onTap: () =>
                              context.pushNamed(AppRoutesNames.myClinics),
                          borderRadius: BorderRadius.circular(20.r),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(9.w, 6.h, 7.w, 6.h),
                            // The chip keeps one physical arrangement in both
                            // languages - dot, name, chevron - so the arrow
                            // never jumps from one side of the name to the
                            // other. Only the glyph mirrors. The clinic name
                            // itself still shapes right-to-left in Arabic.
                            child: DirectionalChevron.pinLtr(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6.w,
                                    height: 6.w,
                                    decoration: const BoxDecoration(
                                      color: ColorManager.success,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Flexible(
                                    child: Text(
                                      clinicName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: FontHelper.fontFamily(
                                          context,
                                        ),
                                        fontSize: 12.5.sp,
                                        height: 1.2,
                                        color: ColorManager.primaryDarker,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  // Points at the clinic name in both
                                  // languages: right in English, and left
                                  // in Arabic because pinLtr kept it on
                                  // the physical right.
                                  DirectionalChevron(
                                    size: 16.w,
                                    color: ColorManager.primaryDarker,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
                width: 38.w,
                height: 38.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // gray200 in light, #2E2E2E in dark - the only neutral that
                  // reads as a disc against both page backgrounds.
                  color: c.divider,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_outlined,
                  color: c.textSecondary,
                  size: 19.w,
                ),
              ),
              // Driven by `unread_count`, which every read/unread/list
              // response carries, plus each Windows poll - so it stays current
              // on both delivery paths without a request of its own.
              Positioned(
                right: 6.w,
                top: 4.h,
                child: UnreadBadge(
                  borderColor: c.cardBgSecondary,
                  size: 16.w,
                  fontSize: 9.sp,
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
            width: 38.w,
            height: 38.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: c.divider, shape: BoxShape.circle),
            child: Icon(
              Icons.settings_outlined,
              color: c.textSecondary,
              size: 19.w,
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
        ShimmerBox(width: 160.w, height: 18.h),
        SizedBox(height: 7.h),
        ShimmerBox(width: 120.w, height: 12.h),
      ],
    );
  }
}
