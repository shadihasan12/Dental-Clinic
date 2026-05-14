import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'statistics_palette.dart';

class KpiCard extends StatelessWidget {
  const KpiCard({
    super.key,
    required this.label,
    required this.value,
    required this.trendPercent,
    required this.icon,
    required this.accent,
  });

  final String label;
  final String value;
  final double trendPercent;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final positive = trendPercent >= 0;
    final trendColor = positive ? ColorManager.success : ColorManager.error;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: c.borderLight, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, size: 18.w, color: accent),
              ),
              const Spacer(),
              _TrendChip(
                positive: positive,
                color: trendColor,
                value: StatisticsFormat.percent(trendPercent),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Text(
            value,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: c.textPrimary,
              height: 1.1,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 12.sp,
              color: c.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendChip extends StatelessWidget {
  const _TrendChip({
    required this.positive,
    required this.color,
    required this.value,
  });

  final bool positive;
  final Color color;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            positive ? Icons.trending_up : Icons.trending_down,
            size: 12.w,
            color: color,
          ),
          SizedBox(width: 2.w),
          Text(
            value,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
