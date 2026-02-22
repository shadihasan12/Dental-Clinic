import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'clinic_info_models.dart';

// ─── Format helpers ──────────────────────────────────────────────────────────

String formatTime(TimeOfDay time) {
  final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
  final minute = time.minute.toString().padLeft(2, '0');
  final period = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hour:$minute $period';
}

String monthAbbr(int month) {
  const abbrs = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return abbrs[month - 1];
}

String formatDate(DateTime date) =>
    '${monthAbbr(date.month)} ${date.day}, ${date.year}';

// ─── DayToggle ───────────────────────────────────────────────────────────────

class DayToggle extends StatelessWidget {
  const DayToggle({super.key, required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 40.w,
      height: 24.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: enabled ? ColorManager.primary : ColorManager.gray100,
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 200),
        alignment: enabled ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.all(2.w),
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorManager.white,
            boxShadow: [
              BoxShadow(
                color: ColorManager.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── TimePickerField ─────────────────────────────────────────────────────────

class TimePickerField extends StatelessWidget {
  const TimePickerField({
    super.key,
    required this.label,
    required this.time,
    required this.onTap,
  });

  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontFamily: FontHelper.fontFamily(context),
              color: ColorManager.textTertiary,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: ColorManager.gray50,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: ColorManager.borderLight),
            ),
            child: Text(
              formatTime(time),
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── ShiftCountControl ───────────────────────────────────────────────────────

class ShiftCountControl extends StatelessWidget {
  const ShiftCountControl({
    super.key,
    required this.count,
    required this.canDecrement,
    required this.canIncrement,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int count;
  final bool canDecrement;
  final bool canIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      decoration: BoxDecoration(
        color: ColorManager.gray50,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorManager.borderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: canDecrement ? onDecrement : null,
            child: Container(
              width: 32.w,
              height: 32.h,
              alignment: Alignment.center,
              child: Icon(
                Icons.remove,
                size: 16.w,
                color: canDecrement
                    ? ColorManager.textPrimary
                    : ColorManager.textTertiary,
              ),
            ),
          ),
          Container(width: 1, height: 18.h, color: ColorManager.borderLight),
          SizedBox(
            width: 32.w,
            child: Text(
              '$count',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w600,
                color: ColorManager.textPrimary,
              ),
            ),
          ),
          Container(width: 1, height: 18.h, color: ColorManager.borderLight),
          GestureDetector(
            onTap: canIncrement ? onIncrement : null,
            child: Container(
              width: 32.w,
              height: 32.h,
              alignment: Alignment.center,
              child: Icon(
                Icons.add,
                size: 16.w,
                color: canIncrement
                    ? ColorManager.primary
                    : ColorManager.textTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── HolidayItem ─────────────────────────────────────────────────────────────

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
    return Container(
      decoration: isLast
          ? null
          : BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: ColorManager.borderLight, width: 1),
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
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  if (holiday.recurring) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.repeat_rounded,
                          size: 11.w,
                          color: ColorManager.textTertiary,
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          AppLocalizations.of(context)!.recurring,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            color: ColorManager.textTertiary,
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
                  color: ColorManager.textSecondary,
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
