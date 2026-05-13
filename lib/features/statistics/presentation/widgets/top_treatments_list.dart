import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/statistics_entities.dart';
import 'statistics_palette.dart';

class TopTreatmentsList extends StatelessWidget {
  const TopTreatmentsList({
    super.key,
    required this.treatments,
    required this.currency,
  });

  final List<TopTreatment> treatments;
  final String currency;

  @override
  Widget build(BuildContext context) {
    if (treatments.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        for (var i = 0; i < treatments.length; i++)
          Padding(
            padding: EdgeInsets.only(
              bottom: i == treatments.length - 1 ? 0 : 12.h,
            ),
            child: _Row(
              index: i,
              treatment: treatments[i],
              currency: currency,
            ),
          ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.index,
    required this.treatment,
    required this.currency,
  });

  final int index;
  final TopTreatment treatment;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final accent = StatisticsPalette.colorAt(index);

    return Row(
      children: [
        Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: accent,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                treatment.name,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: c.textPrimary,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                '${treatment.count} procedures',
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 12.sp,
                  color: c.textTertiary,
                ),
              ),
            ],
          ),
        ),
        Text(
          StatisticsFormat.moneyFull(treatment.revenue, currency),
          style: TextStyle(
            fontFamily: FontHelper.fontFamily(context),
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: ColorManager.success,
          ),
        ),
      ],
    );
  }
}
