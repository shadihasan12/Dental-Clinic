import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/statistics_entities.dart';

class AppointmentBreakdownView extends StatelessWidget {
  const AppointmentBreakdownView({super.key, required this.breakdown});

  final AppointmentBreakdown breakdown;

  @override
  Widget build(BuildContext context) {
    final total = breakdown.total;
    final items = <_BreakdownRow>[
      _BreakdownRow(
        label: 'Completed',
        count: breakdown.completed,
        color: ColorManager.success,
      ),
      _BreakdownRow(
        label: 'Upcoming',
        count: breakdown.upcoming,
        color: ColorManager.info,
      ),
      _BreakdownRow(
        label: 'Cancelled',
        count: breakdown.cancelled,
        color: ColorManager.warning,
      ),
      _BreakdownRow(
        label: 'No-Show',
        count: breakdown.noShow,
        color: ColorManager.error,
      ),
    ];

    return Column(
      children: [
        for (var i = 0; i < items.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i == items.length - 1 ? 0 : 14.h),
            child: _BreakdownTile(row: items[i], total: total),
          ),
      ],
    );
  }
}

class _BreakdownRow {
  const _BreakdownRow({
    required this.label,
    required this.count,
    required this.color,
  });
  final String label;
  final int count;
  final Color color;
}

class _BreakdownTile extends StatelessWidget {
  const _BreakdownTile({required this.row, required this.total});

  final _BreakdownRow row;
  final int total;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final ratio = total == 0 ? 0.0 : row.count / total;
    final pct = (ratio * 100).toStringAsFixed(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: row.color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                row.label,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 13.sp,
                  color: c.textSecondary,
                ),
              ),
            ),
            Text(
              '${row.count}',
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: c.textPrimary,
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              '($pct%)',
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 12.sp,
                color: c.textTertiary,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: LinearProgressIndicator(
            value: ratio.clamp(0, 1),
            minHeight: 6.h,
            backgroundColor: c.borderLight,
            valueColor: AlwaysStoppedAnimation<Color>(row.color),
          ),
        ),
      ],
    );
  }
}
