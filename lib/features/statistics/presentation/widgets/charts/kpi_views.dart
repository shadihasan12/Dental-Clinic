import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/statistic_result.dart';
import 'chart_support.dart';

/// Headline KPI: a big number plus an optional trend chip comparing it
/// to the previous period.
///
/// The exact payload keys aren't pinned down server-side yet, so the
/// value / previous / change are picked defensively from `data` first
/// then `meta`, tolerating both numeric and string-encoded numbers.
class KpiCardView extends StatelessWidget {
  const KpiCardView({super.key, required this.result});

  final StatisticResult result;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final kpi = _KpiValues.from(result);

    if (kpi.value == null) {
      return ChartMessage(
        icon: Icons.insights_outlined,
        text: 'No data for this period',
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ChartFormat.grouped(kpi.value!),
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                  color: c.textPrimary,
                  height: 1.0,
                ),
              ),
              if (kpi.previous != null) ...[
                SizedBox(height: 6.h),
                Text(
                  'vs ${ChartFormat.grouped(kpi.previous!)} last period',
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 11.sp,
                    color: c.textTertiary,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (kpi.changePercent != null) _TrendChip(percent: kpi.changePercent!),
      ],
    );
  }
}

class _TrendChip extends StatelessWidget {
  const _TrendChip({required this.percent});
  final double percent;

  @override
  Widget build(BuildContext context) {
    final isUp = percent >= 0;
    final color = isUp ? ColorManager.success : ColorManager.error;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUp ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
            size: 12.w,
            color: color,
          ),
          SizedBox(width: 2.w),
          Text(
            '${percent.abs().toStringAsFixed(1)}%',
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// KPI plus a short breakdown list (e.g. outstanding balances: a total
/// plus the patients who owe it).
class KpiWithListView extends StatelessWidget {
  const KpiWithListView({super.key, required this.result});

  final StatisticResult result;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final kpi = _KpiValues.from(result);
    final items = _listItems(result);

    if (kpi.value == null && items.isEmpty) {
      return ChartMessage(
        icon: Icons.account_balance_wallet_outlined,
        text: 'No data for this period',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (kpi.value != null)
          Text(
            ChartFormat.grouped(kpi.value!),
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 30.sp,
              fontWeight: FontWeight.w800,
              color: c.textPrimary,
              height: 1.0,
            ),
          ),
        if (items.isNotEmpty) ...[
          SizedBox(height: 14.h),
          for (final item in items)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 12.sp,
                        color: c.textSecondary,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    ChartFormat.grouped(item.amount),
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: c.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ],
    );
  }

  static List<({String label, double amount})> _listItems(
    StatisticResult result,
  ) {
    // The list can live under several keys depending on the metric.
    Object? raw = result.dataMap['items'] ??
        result.dataMap['list'] ??
        result.dataMap['balances'] ??
        result.dataMap['patients'];
    raw ??= result.data is List ? result.data : null;
    if (raw is! List) return const [];

    return [
      for (final entry in raw)
        if (entry is Map)
          (
            label: (entry['name'] ??
                    entry['patient_name'] ??
                    entry['label'] ??
                    entry['title'] ??
                    '—')
                .toString(),
            amount: LabelledSeries.toDouble(
              entry['amount'] ?? entry['balance'] ?? entry['value'] ?? 0,
            ),
          ),
    ];
  }
}

/// Defensive value/previous/change extraction shared by both KPI views.
class _KpiValues {
  const _KpiValues({this.value, this.previous, this.changePercent});

  final double? value;
  final double? previous;
  final double? changePercent;

  factory _KpiValues.from(StatisticResult result) {
    final sources = <Map<String, dynamic>>[result.dataMap, result.meta];

    double? pick(List<String> keys) {
      for (final src in sources) {
        for (final k in keys) {
          final v = src[k];
          if (v is num) return v.toDouble();
          if (v is String) {
            final parsed = double.tryParse(v);
            if (parsed != null) return parsed;
          }
        }
      }
      return null;
    }

    return _KpiValues(
      value: pick(const [
        'value',
        'current',
        'current_value',
        'total',
        'amount',
        'count',
      ]),
      previous: pick(const [
        'previous',
        'previous_value',
        'previous_period',
        'comparison',
      ]),
      changePercent: pick(const [
        'change_percentage',
        'change_percent',
        'percentage',
        'growth',
        'change',
      ]),
    );
  }
}
