import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';

/// Interactive teeth diagram for recording dental treatments
class TeethDiagram extends StatelessWidget {
  const TeethDiagram({
    super.key,
    required this.toothTreatments,
    required this.onToothTap,
  });

  final Map<int, String> toothTreatments;
  final void Function(int toothNumber) onToothTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Upper Jaw',
          style: TextStyleManager.bodySmall.copyWith(
            color: ColorManager.textTertiary,
          ),
        ),
        SizedBox(height: 12.h),
        _buildJaw(isUpper: true),
        SizedBox(height: 16.h),
        Container(
          height: 2,
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          color: ColorManager.gray300,
        ),
        SizedBox(height: 16.h),
        _buildJaw(isUpper: false),
        SizedBox(height: 12.h),
        Text(
          'Lower Jaw',
          style: TextStyleManager.bodySmall.copyWith(
            color: ColorManager.textTertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildJaw({required bool isUpper}) {
    final rightNumbers = isUpper
        ? List.generate(8, (i) => 18 - i)
        : List.generate(8, (i) => 48 - i);
    final leftNumbers = isUpper
        ? List.generate(8, (i) => 21 + i)
        : List.generate(8, (i) => 31 + i);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...rightNumbers.map((n) => _ToothWidget(
                number: n,
                isUpper: isUpper,
                hasTreatment: toothTreatments.containsKey(n),
                onTap: () => onToothTap(n),
              )),
          SizedBox(width: 12.w),
          ...leftNumbers.map((n) => _ToothWidget(
                number: n,
                isUpper: isUpper,
                hasTreatment: toothTreatments.containsKey(n),
                onTap: () => onToothTap(n),
              )),
        ],
      ),
    );
  }
}

class _ToothWidget extends StatelessWidget {
  const _ToothWidget({
    required this.number,
    required this.isUpper,
    required this.hasTreatment,
    required this.onTap,
  });

  final int number;
  final bool isUpper;
  final bool hasTreatment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          children: [
            Container(
              width: 26.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: hasTreatment
                    ? const Color(0xFF70B2B2)
                    : ColorManager.white,
                border: Border.all(
                  color: hasTreatment
                      ? const Color(0xFF70B2B2)
                      : ColorManager.gray800,
                  width: 2,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isUpper ? 8.r : 4.r),
                  topRight: Radius.circular(isUpper ? 8.r : 4.r),
                  bottomLeft: Radius.circular(isUpper ? 4.r : 8.r),
                  bottomRight: Radius.circular(isUpper ? 4.r : 8.r),
                ),
              ),
              child: hasTreatment
                  ? Center(
                      child: Icon(
                        Icons.check,
                        color: ColorManager.white,
                        size: 14.w,
                      ),
                    )
                  : null,
            ),
            SizedBox(height: 4.h),
            Text(
              '$number',
              style: TextStyle(
                fontSize: 10.sp,
                color: hasTreatment
                    ? const Color(0xFF70B2B2)
                    : ColorManager.textTertiary,
                fontWeight: hasTreatment ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
