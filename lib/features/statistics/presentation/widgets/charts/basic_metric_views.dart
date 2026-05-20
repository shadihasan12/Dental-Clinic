import 'dart:math' as math;

import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/statistic_result.dart';
import '../statistics_palette.dart';
import 'chart_support.dart';

// ─────────────────────────────────────────────────────────────────────
// First-pass ("basic") renderers for the metric types fl_chart can't do
// natively. They parse defensively and degrade to a readable list / grid
// — once the real payloads are confirmed these can be made richer.
// ─────────────────────────────────────────────────────────────────────

/// Peak booking hours/days. Renders a coloured day×hour grid when the
/// payload exposes a `matrix`, otherwise a graceful message.
class HeatmapView extends StatelessWidget {
  const HeatmapView({super.key, required this.result});

  final StatisticResult result;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final map = result.dataMap;
    final rawMatrix = map['matrix'] ?? map['grid'] ?? map['values'];
    final matrix = _toMatrix(rawMatrix);

    if (matrix.isEmpty) {
      return ChartMessage(
        icon: Icons.grid_on_rounded,
        text: 'No booking activity for this period',
      );
    }

    final xLabels = _toLabels(map['x_labels'] ?? map['hours'] ?? map['columns']);
    final yLabels = _toLabels(map['y_labels'] ?? map['days'] ?? map['rows']);
    var maxValue = 0.0;
    for (final row in matrix) {
      for (final v in row) {
        maxValue = math.max(maxValue, v);
      }
    }
    if (maxValue == 0) maxValue = 1;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var r = 0; r < matrix.length; r++)
            Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Row(
                children: [
                  SizedBox(
                    width: 44.w,
                    child: Text(
                      r < yLabels.length ? yLabels[r] : 'Row ${r + 1}',
                      style:
                          TextStyle(fontSize: 9.sp, color: c.textTertiary),
                    ),
                  ),
                  for (final value in matrix[r])
                    Container(
                      width: 26.w,
                      height: 26.w,
                      margin: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: ColorManager.primary
                            .withValues(alpha: 0.12 + (value / maxValue) * 0.78),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                ],
              ),
            ),
          if (xLabels.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 44.w, top: 2.h),
              child: Row(
                children: [
                  for (final label in xLabels)
                    SizedBox(
                      width: 30.w,
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 8.sp, color: c.textTertiary),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  static List<List<double>> _toMatrix(Object? raw) {
    if (raw is! List) return const [];
    final result = <List<double>>[];
    for (final row in raw) {
      if (row is List) {
        result.add([for (final v in row) LabelledSeries.toDouble(v)]);
      }
    }
    return result;
  }

  static List<String> _toLabels(Object? raw) {
    if (raw is! List) return const [];
    return [for (final l in raw) (l ?? '').toString()];
  }
}

/// Most-treated teeth. Rendered as a ranked list of tooth → count.
class DentalHeatmapView extends StatelessWidget {
  const DentalHeatmapView({super.key, required this.result});

  final StatisticResult result;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final entries = _entries(result);

    if (entries.isEmpty) {
      return ChartMessage(
        icon: Icons.healing_outlined,
        text: 'No treated teeth for this period',
      );
    }

    entries.sort((a, b) => b.count.compareTo(a.count));
    final top = entries.take(8).toList();
    final maxCount = top.first.count == 0 ? 1.0 : top.first.count;

    return Column(
      children: [
        for (final e in top)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Row(
              children: [
                Container(
                  width: 38.w,
                  height: 38.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    e.tooth,
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: LinearProgressIndicator(
                      value: e.count / maxCount,
                      minHeight: 14.h,
                      backgroundColor: c.borderLight,
                      valueColor:
                          const AlwaysStoppedAnimation(ColorManager.primary),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  e.count.toStringAsFixed(0),
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
    );
  }

  static List<({String tooth, double count})> _entries(
    StatisticResult result,
  ) {
    // Shape A: `{labels: [...], values: [...]}`.
    final series = LabelledSeries.tryParse(result.data);
    if (series != null && !series.isEmpty) {
      return [
        for (var i = 0; i < series.labels.length; i++)
          (tooth: series.labels[i], count: series.values[i]),
      ];
    }
    // Shape B: a list of `{tooth/code, count}` objects.
    Object? raw = result.dataMap['teeth'] ?? result.dataMap['items'];
    raw ??= result.data is List ? result.data : null;
    if (raw is! List) return const [];
    return [
      for (final entry in raw)
        if (entry is Map)
          (
            tooth: (entry['tooth'] ??
                    entry['code'] ??
                    entry['universal_code'] ??
                    entry['label'] ??
                    '—')
                .toString(),
            count: LabelledSeries.toDouble(
              entry['count'] ?? entry['value'] ?? entry['frequency'] ?? 0,
            ),
          ),
    ];
  }
}

/// Patient demographics — renders each `label → number` sub-map found
/// in the payload (gender, age brackets, …) as its own labelled bars.
class DemographicsView extends StatelessWidget {
  const DemographicsView({super.key, required this.result});

  final StatisticResult result;

  @override
  Widget build(BuildContext context) {
    final sections = _sections(result);
    if (sections.isEmpty) {
      return ChartMessage(
        icon: Icons.people_outline_rounded,
        text: 'No demographic data yet',
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var s = 0; s < sections.length; s++) ...[
          if (s > 0) SizedBox(height: 16.h),
          _DemographicSection(
            title: sections[s].title,
            entries: sections[s].entries,
          ),
        ],
      ],
    );
  }

  static List<({String title, Map<String, double> entries})> _sections(
    StatisticResult result,
  ) {
    final out = <({String title, Map<String, double> entries})>[];
    result.dataMap.forEach((key, value) {
      final entries = <String, double>{};
      if (value is Map) {
        value.forEach((k, v) {
          if (v is num || v is String) {
            entries[k.toString()] = LabelledSeries.toDouble(v);
          }
        });
      } else if (value is List) {
        for (final item in value) {
          if (item is Map) {
            final label = (item['label'] ?? item['name'] ?? item['range'] ?? '')
                .toString();
            entries[label] = LabelledSeries.toDouble(
              item['count'] ?? item['value'] ?? 0,
            );
          }
        }
      }
      if (entries.isNotEmpty) {
        out.add((title: LabelledSeries.prettyLabel(key), entries: entries));
      }
    });
    return out;
  }
}

class _DemographicSection extends StatelessWidget {
  const _DemographicSection({required this.title, required this.entries});

  final String title;
  final Map<String, double> entries;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final total = entries.values.fold(0.0, (a, b) => a + b);
    final keys = entries.keys.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: FontHelper.fontFamily(context),
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: c.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        for (var i = 0; i < keys.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              children: [
                SizedBox(
                  width: 80.w,
                  child: Text(
                    LabelledSeries.prettyLabel(keys[i]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 11.sp,
                      color: c.textSecondary,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: LinearProgressIndicator(
                      value: total == 0 ? 0 : entries[keys[i]]! / total,
                      minHeight: 14.h,
                      backgroundColor: c.borderLight,
                      valueColor:
                          AlwaysStoppedAnimation(StatisticsPalette.colorAt(i)),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  ChartFormat.compact(entries[keys[i]]!),
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
