import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'treatment_type_grid.dart';

/// Bottom sheet that appears when a tooth is tapped on the chart.
/// Shows tooth number and treatment options to pick from.
Future<List<TreatmentTypeInfo>?> showToothTreatmentSheet(
  BuildContext context, {
  required String toothNumber,
  List<String> existingTreatmentIds = const [],
  List<TreatmentTypeInfo> toothSpecificTypes = const [],
}) {
  return showModalBottomSheet<List<TreatmentTypeInfo>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return _ToothTreatmentSheetContent(
        toothNumber: toothNumber,
        existingTreatmentIds: existingTreatmentIds,
        toothSpecificTypes: toothSpecificTypes,
      );
    },
  );
}

class _ToothTreatmentSheetContent extends StatefulWidget {
  final String toothNumber;
  final List<String> existingTreatmentIds;
  final List<TreatmentTypeInfo> toothSpecificTypes;

  const _ToothTreatmentSheetContent({
    required this.toothNumber,
    required this.existingTreatmentIds,
    required this.toothSpecificTypes,
  });

  @override
  State<_ToothTreatmentSheetContent> createState() =>
      _ToothTreatmentSheetContentState();
}

class _ToothTreatmentSheetContentState
    extends State<_ToothTreatmentSheetContent> {
  final Set<String> _selectedIds = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: ColorManager.of(context).borderLight,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Tooth header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Center(
                    child: Text(
                      widget.toothNumber,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w700,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.toothLabel(widget.toothNumber),
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: ColorManager.of(context).textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _toothName(widget.toothNumber),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        color: ColorManager.of(context).textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Treatment grid
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.selectTreatments,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w500,
                      color: ColorManager.of(context).textSecondary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TreatmentTypeGrid(
                    types: widget.toothSpecificTypes,
                    selectedIds: _selectedIds,
                    onSelect: (type) {
                      setState(() {
                        if (_selectedIds.contains(type.id)) {
                          _selectedIds.remove(type.id);
                        } else {
                          _selectedIds.add(type.id);
                        }
                      });
                    },
                  ),

                  // Show existing treatments for this tooth
                  if (widget.existingTreatmentIds.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: ColorManager.info.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: ColorManager.info.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 16.w,
                            color: ColorManager.info,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)!.alreadyPlannedForTooth(widget.existingTreatmentIds.length),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: FontHelper.fontFamily(context),
                                color: ColorManager.info,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),

          // Add button
          Padding(
            padding: EdgeInsets.fromLTRB(
              20.w,
              8.h,
              20.w,
              MediaQuery.of(context).padding.bottom + 16.h,
            ),
            child: GestureDetector(
              onTap: _selectedIds.isEmpty
                  ? null
                  : () {
                      final selected = widget.toothSpecificTypes
                          .where((t) => _selectedIds.contains(t.id))
                          .toList();
                      Navigator.pop(context, selected);
                    },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: _selectedIds.isEmpty
                      ? ColorManager.of(context).borderLight
                      : ColorManager.primary,
                  borderRadius: BorderRadiusManager.lg,
                ),
                child: Text(
                  _selectedIds.isEmpty
                      ? AppLocalizations.of(context)!.selectATreatment
                      : AppLocalizations.of(context)!.addNTreatments(_selectedIds.length),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: _selectedIds.isEmpty
                        ? ColorManager.of(context).textTertiary
                        : ColorManager.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _toothName(String number) {
    // Only parse if it looks like a 2-digit FDI code (e.g. "16", "48")
    if (number.length > 2 || int.tryParse(number) == null) return '';
    final quadrant = int.parse(number[0]);
    final tooth = int.parse(number.substring(1));

    final quadrantName = switch (quadrant) {
      1 => 'Upper Right',
      2 => 'Upper Left',
      3 => 'Lower Left',
      4 => 'Lower Right',
      _ => '',
    };

    final toothName = switch (tooth) {
      1 => 'Central Incisor',
      2 => 'Lateral Incisor',
      3 => 'Canine',
      4 => 'First Premolar',
      5 => 'Second Premolar',
      6 => 'First Molar',
      7 => 'Second Molar',
      8 => 'Wisdom Tooth',
      _ => 'Tooth',
    };

    return '$quadrantName $toothName';
  }
}
