import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/widgets/clinic_info_models.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/widgets/helpers.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HolidayItem extends StatelessWidget {
  const HolidayItem({
    super.key,
    required this.holiday,
    required this.isLast,
    required this.onEdit,
    required this.onDelete,
  });

  final HolidayEntry holiday;
  final bool isLast;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      decoration: isLast
          ? null
          : BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: c.borderLight, width: 1),
              ),
            ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            // Date badge
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${holiday.date.day}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w700,
                      color: ColorManager.primary,
                      height: 1,
                    ),
                  ),
                  Text(
                    monthAbbr(holiday.date.month),
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w500,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            // Name + recurring tag
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    holiday.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w500,
                      color: c.textPrimary,
                    ),
                  ),
                  if (holiday.recurring) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.repeat_rounded,
                          size: 11.w,
                          color: c.textTertiary,
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          AppLocalizations.of(context)!.recurring,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            color: c.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            // Actions
            GestureDetector(
              onTap: onEdit,
              child: Padding(
                padding: EdgeInsets.all(6.w),
                child: Icon(
                  Icons.edit_outlined,
                  size: 18.w,
                  color: c.textSecondary,
                ),
              ),
            ),
            GestureDetector(
              onTap: onDelete,
              child: Padding(
                padding: EdgeInsets.all(6.w),
                child: Icon(
                  Icons.delete_outline_rounded,
                  size: 18.w,
                  color: ColorManager.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
