import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

class PatientsListHeader extends StatelessWidget {
  const PatientsListHeader({
    super.key,
    required this.patientCount,
    required this.searchController,
    required this.onAddTap,
    required this.onSearchChanged,
  });

  final int patientCount;
  final TextEditingController searchController;
  final VoidCallback onAddTap;
  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.patients,
                        style: TextStyle(
                          fontFamily: FontHelper.fontFamily(context),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '$patientCount ${l10n.total.toLowerCase()}',
                        style: TextStyle(
                          fontFamily: FontHelper.fontFamily(context),
                          fontSize: 13.sp,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onAddTap,
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 20.w),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Search bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: TextField(
                controller: searchController,
                onChanged: onSearchChanged,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 14.sp,
                ),
                decoration: InputDecoration(
                  hintText: l10n.search + ' ' + l10n.patients.toLowerCase() + '...',
                  hintStyle: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 14.sp,
                    color: Colors.grey.shade400,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20.w,
                    color: Colors.grey.shade400,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}