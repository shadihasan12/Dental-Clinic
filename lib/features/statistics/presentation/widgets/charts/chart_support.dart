import 'dart:math' as math;

import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A `{labels: [...], values: [...]}` payload — the shape donut, pie,
/// bar, horizontal-bar and area metrics all share. [tryParse] returns
/// null when the data isn't this shape, so the caller can fall back to
/// an empty state instead of crashing on a surprising payload.
class LabelledSeries {
  const LabelledSeries(this.labels, this.values);

  final List<String> labels;
  final List<double> values;

  bool get isEmpty => values.isEmpty;
  bool get allZero => values.every((v) => v == 0);
  double get total => values.fold(0.0, (a, b) => a + b);
  double get maxValue =>
      values.isEmpty ? 0 : values.reduce((a, b) => math.max(a, b));

  static LabelledSeries? tryParse(Object? data) {
    if (data is! Map) return null;
    final rawLabels = data['labels'];
    final rawValues = data['values'];
    if (rawLabels is! List || rawValues is! List) return null;
    final labels = [
      for (final l in rawLabels) (l ?? '').toString(),
    ];
    final values = [for (final v in rawValues) toDouble(v)];
    return LabelledSeries(labels, values);
  }

  /// Coerces a JSON number/string into a double (the API sometimes
  /// sends money as the string `"500.00"`).
  static double toDouble(Object? v) {
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v) ?? 0;
    return 0;
  }

  /// Humanizes an UPPER_SNAKE API label into "Upper snake".
  static String prettyLabel(String raw) {
    if (raw.isEmpty) return raw;
    final words = raw.replaceAll('_', ' ').toLowerCase().split(' ');
    return words
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }
}

/// Compact placeholder shown inside a metric card for empty / error /
/// unsupported states — keeps every card the same minimum height.
class ChartMessage extends StatelessWidget {
  const ChartMessage({
    super.key,
    required this.icon,
    required this.text,
    this.action,
  });

  final IconData icon;
  final String text;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return SizedBox(
      height: 120.h,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 30.w, color: c.textSubtle),
            SizedBox(height: 8.h),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 12.sp,
                color: c.textTertiary,
              ),
            ),
            if (action != null) ...[
              SizedBox(height: 10.h),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Number formatting shared by every chart (axis ticks, legend values).
class ChartFormat {
  ChartFormat._();

  /// 1234567 → "1.2M", 12300 → "12.3K", 42 → "42".
  static String compact(double value) {
    final v = value.abs();
    if (v >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    if (value == value.roundToDouble()) return value.toStringAsFixed(0);
    return value.toStringAsFixed(1);
  }

  /// 1234567 → "1,234,567".
  static String grouped(double value) {
    final whole = value.toStringAsFixed(0);
    return whole.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }
}
