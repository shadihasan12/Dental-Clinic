import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Border radius management class for the dental clinic application
/// Based on the design system corner radius specifications
class BorderRadiusManager {
  BorderRadiusManager._();

  // ============================================
  // RADIUS VALUES (Raw doubles)
  // ============================================

  /// No radius
  static const double radiusNone = 0;

  /// Extra small radius - 4px
  static const double radiusXs = 4;

  /// Small radius - 6px
  static const double radiusSm = 6;

  /// Medium radius - 8px
  static const double radiusMd = 8;

  /// Large radius - 12px (Tailwind rounded-xl)
  static const double radiusLg = 12;

  /// Extra large radius - 16px (Tailwind rounded-2xl)
  static const double radiusXl = 16;

  /// 2X large radius - 20px
  static const double radius2xl = 20;

  /// 3X large radius - 24px (Tailwind rounded-3xl)
  static const double radius3xl = 24;

  /// Full/Pill radius - 9999px (creates pill shape)
  static const double radiusFull = 9999;

  // ============================================
  // BORDER RADIUS - Circular (All corners same)
  // ============================================

  /// No border radius
  static BorderRadius get none => BorderRadius.zero;

  /// Extra small - 4px
  static BorderRadius get xs => BorderRadius.circular(radiusXs.r);

  /// Small - 6px
  static BorderRadius get sm => BorderRadius.circular(radiusSm.r);

  /// Medium - 8px (default for inputs, buttons)
  static BorderRadius get md => BorderRadius.circular(radiusMd.r);

  /// Large - 12px (Tailwind rounded-xl, for cards)
  static BorderRadius get lg => BorderRadius.circular(radiusLg.r);

  /// Extra large - 16px (Tailwind rounded-2xl)
  static BorderRadius get xl => BorderRadius.circular(radiusXl.r);

  /// 2X large - 20px
  static BorderRadius get xxl => BorderRadius.circular(radius2xl.r);

  /// 3X large - 24px (Tailwind rounded-3xl, for large cards)
  static BorderRadius get xxxl => BorderRadius.circular(radius3xl.r);

  /// Full/Pill - creates pill shape
  static BorderRadius get full => BorderRadius.circular(radiusFull.r);

  // ============================================
  // COMPONENT-SPECIFIC BORDER RADIUS
  // ============================================

  /// Button border radius - 8px
  static BorderRadius get button => md;

  /// Button large border radius - 12px
  static BorderRadius get buttonLg => lg;

  /// Card border radius - 16px
  static BorderRadius get card => xl;

  /// Card large border radius - 24px
  static BorderRadius get cardLg => xxxl;

  /// Input field border radius - 8px
  static BorderRadius get input => md;

  /// Input field large border radius - 16px
  static BorderRadius get inputLg => xl;

  /// Badge/Chip border radius - pill shape
  static BorderRadius get badge => full;

  /// Avatar border radius - circle
  static BorderRadius get avatar => full;

  /// Icon container border radius - 12px
  static BorderRadius get iconContainer => lg;

  /// Bottom sheet border radius (top corners only)
  static BorderRadius get bottomSheet => BorderRadius.only(
        topLeft: Radius.circular(radius2xl.r),
        topRight: Radius.circular(radius2xl.r),
      );

  /// Modal border radius - 16px
  static BorderRadius get modal => xl;

  /// Tooltip border radius - 8px
  static BorderRadius get tooltip => md;

  /// Snackbar border radius - 12px
  static BorderRadius get snackbar => lg;

  /// Image border radius - 16px
  static BorderRadius get image => xl;

  /// Thumbnail border radius - 12px
  static BorderRadius get thumbnail => lg;

  // ============================================
  // TOP CORNERS ONLY
  // ============================================

  /// Top corners large - 16px
  static BorderRadius get topLg => BorderRadius.only(
        topLeft: Radius.circular(radiusXl.r),
        topRight: Radius.circular(radiusXl.r),
      );

  /// Top corners extra large - 24px
  static BorderRadius get topXl => BorderRadius.only(
        topLeft: Radius.circular(radius3xl.r),
        topRight: Radius.circular(radius3xl.r),
      );

  // ============================================
  // BOTTOM CORNERS ONLY
  // ============================================

  /// Bottom corners large - 16px
  static BorderRadius get bottomLg => BorderRadius.only(
        bottomLeft: Radius.circular(radiusXl.r),
        bottomRight: Radius.circular(radiusXl.r),
      );

  /// Bottom corners extra large - 24px
  static BorderRadius get bottomXl => BorderRadius.only(
        bottomLeft: Radius.circular(radius3xl.r),
        bottomRight: Radius.circular(radius3xl.r),
      );

  // ============================================
  // LEFT CORNERS ONLY
  // ============================================

  /// Left corners large - 16px
  static BorderRadius get leftLg => BorderRadius.only(
        topLeft: Radius.circular(radiusXl.r),
        bottomLeft: Radius.circular(radiusXl.r),
      );

  // ============================================
  // RIGHT CORNERS ONLY
  // ============================================

  /// Right corners large - 16px
  static BorderRadius get rightLg => BorderRadius.only(
        topRight: Radius.circular(radiusXl.r),
        bottomRight: Radius.circular(radiusXl.r),
      );

  // ============================================
  // HELPER METHODS
  // ============================================

  /// Create a custom circular border radius
  static BorderRadius circular(double radius) => BorderRadius.circular(radius.r);

  /// Create a custom border radius with different values for each corner
  static BorderRadius only({
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) =>
      BorderRadius.only(
        topLeft: Radius.circular(topLeft.r),
        topRight: Radius.circular(topRight.r),
        bottomLeft: Radius.circular(bottomLeft.r),
        bottomRight: Radius.circular(bottomRight.r),
      );

  /// Create a horizontal border radius (left and right sides rounded)
  static BorderRadius horizontal(double radius) => BorderRadius.horizontal(
        left: Radius.circular(radius.r),
        right: Radius.circular(radius.r),
      );

  /// Create a vertical border radius (top and bottom sides rounded)
  static BorderRadius vertical(double radius) => BorderRadius.vertical(
        top: Radius.circular(radius.r),
        bottom: Radius.circular(radius.r),
      );
}

/// Shape border configurations for use with Material widgets
class ShapeBorderManager {
  ShapeBorderManager._();

  /// Rounded rectangle - small
  static RoundedRectangleBorder get roundedSm => RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.sm,
      );

  /// Rounded rectangle - medium
  static RoundedRectangleBorder get roundedMd => RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.md,
      );

  /// Rounded rectangle - large
  static RoundedRectangleBorder get roundedLg => RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.lg,
      );

  /// Rounded rectangle - extra large
  static RoundedRectangleBorder get roundedXl => RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.xl,
      );

  /// Rounded rectangle - 2x large
  static RoundedRectangleBorder get rounded2xl => RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.xxl,
      );

  /// Rounded rectangle - 3x large
  static RoundedRectangleBorder get rounded3xl => RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.xxxl,
      );

  /// Stadium/Pill shape
  static StadiumBorder get stadium => const StadiumBorder();

  /// Circle shape
  static CircleBorder get circle => const CircleBorder();

  /// Bottom sheet shape
  static RoundedRectangleBorder get bottomSheet => RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.bottomSheet,
      );
}
