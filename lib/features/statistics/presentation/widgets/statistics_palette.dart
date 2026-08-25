import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

/// Stable, contrast-balanced palette for charts.
///
/// Charts re-use colors by index, so this list is the single source of
/// truth — change one entry here and every donut slice, legend dot and
/// progress bar stays in sync.
class StatisticsPalette {
  StatisticsPalette._();

  static const List<Color> chartColors = [
    ColorManager.primary,
    ColorManager.info,
    ColorManager.purple,
    ColorManager.warning,
    Color(0xFF14B8A6),
    Color(0xFFEC4899),
    Color(0xFF6366F1),
    Color(0xFF84CC16),
  ];

  static Color colorAt(int index) =>
      chartColors[index % chartColors.length];
}

/// Tiny helpers used by every chart card — kept here so we don't import
/// `intl` from the data layer.
class StatisticsFormat {
  StatisticsFormat._();

  /// Compact money formatter. Doesn't pretend to handle every locale —
  /// once a real currency service is wired, swap this for it.
  static String money(double value, String currency) {
    final symbol = _symbol(currency);
    if (value.abs() >= 1000000) {
      return '$symbol${(value / 1000000).toStringAsFixed(1)}M';
    }
    if (value.abs() >= 1000) {
      return '$symbol${(value / 1000).toStringAsFixed(1)}K';
    }
    return '$symbol${value.toStringAsFixed(0)}';
  }

  /// Full-precision money for tooltips & list rows.
  static String moneyFull(double value, String currency) {
    final symbol = _symbol(currency);
    final whole = value.toStringAsFixed(0);
    final withCommas = whole.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    return '$symbol$withCommas';
  }

  static String _symbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'USD':
        return r'$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'SYP':
        return 'SYP ';
      default:
        return '$currency ';
    }
  }

  static String percent(double value, {int fractionDigits = 1}) {
    final sign = value > 0 ? '+' : '';
    return '$sign${value.toStringAsFixed(fractionDigits)}%';
  }
}
