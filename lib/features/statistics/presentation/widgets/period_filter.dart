import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/statistics_period.dart';

class PeriodFilter extends StatelessWidget {
  const PeriodFilter({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final StatisticsPeriod selected;
  final ValueChanged<StatisticsPeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: StatisticsPeriod.values
            .map((p) => Expanded(
                  child: _Segment(
                    label: _labelFor(p),
                    selected: p == selected,
                    onTap: () => onChanged(p),
                  ),
                ))
            .toList(growable: false),
      ),
    );
  }

  String _labelFor(StatisticsPeriod p) {
    switch (p) {
      case StatisticsPeriod.week:
        return 'Week';
      case StatisticsPeriod.month:
        return 'Month';
      case StatisticsPeriod.year:
        return 'Year';
    }
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      child: Material(
        color: selected ? c.cardBg : Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
        elevation: selected ? 1 : 0,
        shadowColor: Colors.black.withValues(alpha: 0.06),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 13.sp,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  color: selected ? c.textPrimary : c.textTertiary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
