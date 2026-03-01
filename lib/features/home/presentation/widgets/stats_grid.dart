import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatTile(value: '248', label: 'Patients', trend: '+12'),
        SizedBox(width: 12.w),
        _StatTile(value: '8', label: "Visits", trend: 'today'),
        SizedBox(width: 12.w),
        _StatTile(value: '\$12.4k', label: 'Revenue', trend: '+8%'),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.value,
    required this.label,
    this.trend,
  });

  final String value;
  final String label;
  final String? trend;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontFamily: FontFamily.geist,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: TextStyle(
                fontFamily: FontFamily.geist,
                fontSize: 11.sp,
                color: Colors.black45,
              ),
            ),
            if (trend != null) ...[
              SizedBox(height: 6.h),
              Text(
                trend!,
                style: TextStyle(
                  fontFamily: FontFamily.geist,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}