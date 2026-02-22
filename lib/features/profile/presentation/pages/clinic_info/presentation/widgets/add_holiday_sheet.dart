import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'clinic_info_models.dart';
import 'clinic_info_widgets.dart';
import 'cupertino_picker_sheet.dart';

void showAddHolidaySheet(
  BuildContext context, {
  HolidayEntry? existing,
  int? index,
  required void Function(HolidayEntry entry, int? index) onSave,
}) {
  final l10n = AppLocalizations.of(context)!;
  final nameController = TextEditingController(text: existing?.name ?? '');
  DateTime selectedDate = existing?.date ?? DateTime.now();
  bool recurring = existing?.recurring ?? false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return StatefulBuilder(
        builder: (ctx, setSheetState) {
          return Container(
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            padding: EdgeInsets.fromLTRB(
              20.w,
              16.h,
              20.w,
              MediaQuery.of(ctx).viewInsets.bottom + 24.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 36.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: ColorManager.borderLight,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  existing == null ? l10n.addHoliday : l10n.editHoliday,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.textPrimary,
                  ),
                ),
                SizedBox(height: 20.h),
                // Name field
                Text(
                  l10n.holidayName,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: ColorManager.textTertiary,
                  ),
                ),
                SizedBox(height: 6.h),
                TextField(
                  controller: nameController,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: ColorManager.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: l10n.holidayNameHint,
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: ColorManager.textTertiary,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: ColorManager.borderLight),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: ColorManager.borderLight),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: ColorManager.primary),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                // Date picker
                Text(
                  l10n.date,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: ColorManager.textTertiary,
                  ),
                ),
                SizedBox(height: 6.h),
                GestureDetector(
                  onTap: () => showCupertinoPickerSheet(
                    context: ctx,
                    cancelLabel: l10n.cancel,
                    doneLabel: l10n.done,
                    picker: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: selectedDate,
                      onDateTimeChanged: (dt) =>
                          setSheetState(() => selectedDate = dt),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.gray50,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: ColorManager.borderLight),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 16.w,
                          color: ColorManager.textSecondary,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          formatDate(selectedDate),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            color: ColorManager.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                // Recurring toggle
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.recurring,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              color: ColorManager.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            l10n.recurringDescription,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontFamily: FontHelper.fontFamily(context),
                              color: ColorManager.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: recurring,
                      onChanged: (v) => setSheetState(() => recurring = v),
                      activeThumbColor: ColorManager.white,
                      activeTrackColor: ColorManager.primary,
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                // Save button
                GestureDetector(
                  onTap: () {
                    final name = nameController.text.trim();
                    if (name.isEmpty) return;
                    onSave(
                      HolidayEntry(
                        name: name,
                        date: selectedDate,
                        recurring: recurring,
                      ),
                      index,
                    );
                    Navigator.pop(sheetContext);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadiusManager.lg,
                    ),
                    child: Text(
                      existing == null ? l10n.addHoliday : l10n.saveChanges,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
