import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../bloc/statistics_dashboard_bloc.dart';

/// Global date-range control. Applies to every metric that accepts a
/// date window; metrics without a date filter ignore it.
class StatisticsFilterBar extends StatelessWidget {
  const StatisticsFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return BlocBuilder<StatisticsDashboardBloc, StatisticsDashboardState>(
      buildWhen: (a, b) =>
          a.startDate != b.startDate || a.endDate != b.endDate,
      builder: (context, state) {
        final fmt = DateFormat('MMM d, y');
        return InkWell(
          onTap: () => _pickRange(context, state),
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
            decoration: BoxDecoration(
              color: c.cardBg,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: c.borderLight),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16.w,
                  color: ColorManager.primaryDarker,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    '${fmt.format(state.startDate)}  —  '
                    '${fmt.format(state.endDate)}',
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w600,
                      color: c.textPrimary,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18.w,
                  color: c.textTertiary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickRange(
    BuildContext context,
    StatisticsDashboardState state,
  ) async {
    // lastDate must sit on/after the initial range end. The default
    // range runs to the *end of the current month*, which is later
    // than "today" — so cap to the end of next year to comfortably
    // cover both the default and any forward selection.
    final now = DateTime.now();
    final lastDate = DateTime(now.year + 1, 12, 31);
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: lastDate,
      initialDateRange: DateTimeRange(
        start: state.startDate,
        end: state.endDate.isAfter(lastDate) ? lastDate : state.endDate,
      ),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: Theme.of(ctx)
              .colorScheme
              .copyWith(primary: ColorManager.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null && context.mounted) {
      context.read<StatisticsDashboardBloc>().add(
            DashboardDateRangeChanged(
              start: picked.start,
              end: picked.end,
            ),
          );
    }
  }
}
