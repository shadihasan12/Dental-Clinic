import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

class PatientHeader extends StatelessWidget {
  final String name;
  final VoidCallback onBackPressed;
  final VoidCallback? onEditPressed;
  final TabController tabController;

  const PatientHeader({
    super.key,
    required this.name,
    required this.onBackPressed,
    required this.tabController,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      color: ColorManager.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // App bar row: back + name + edit
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: ColorManager.textPrimary,
                      size: 20.w,
                    ),
                    onPressed: onBackPressed,
                  ),
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: ColorManager.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (onEditPressed != null)
                    IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        color: ColorManager.textSecondary,
                        size: 20.w,
                      ),
                      onPressed: onEditPressed,
                    ),
                ],
              ),
            ),

            // Tab bar
            TabBar(
              controller: tabController,
              labelColor: ColorManager.primary,
              unselectedLabelColor: ColorManager.textTertiary,
              indicatorColor: ColorManager.primary,
              indicatorWeight: 2.5,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: ColorManager.borderLight,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w400,
              ),
              tabs: [
                Tab(text: l10n.info),
                Tab(text: l10n.case_),
                Tab(text: l10n.history),
              ],
            ),
          ],
        ),
      ),
    );
  }
}