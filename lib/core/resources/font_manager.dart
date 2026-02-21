import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Font weight management
class FontWeightManager {
  FontWeightManager._();

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
}

/// Font size management using flutter_screenutil for responsiveness
class FontSizesManager {
  FontSizesManager._();

  // Extra Small
  static double get s10 => 10.sp;

  // Small - Captions, timestamps
  static double get s12 => 12.sp;
  static double get s13 => 13.sp;

  // Body Small - Secondary text, labels
  static double get s14 => 14.sp;
  static double get s15 => 15.sp;

  // Body - Default body text, buttons
  static double get s16 => 16.sp;
  static double get s17 => 17.sp;

  // Subtitle - Subsection headings
  static double get s18 => 18.sp;

  // Heading 1 - Card titles
  static double get s20 => 20.sp;
  static double get s22 => 22.sp;

  // Display - Section headings
  static double get s24 => 24.sp;
  static double get s28 => 28.sp;

  // Large Display - Main page headings
  static double get s30 => 30.sp;
  static double get s32 => 32.sp;
  static double get s36 => 36.sp;
  static double get s40 => 40.sp;
  static double get s48 => 48.sp;

  // Semantic aliases
  static double get caption => s12;
  static double get bodySmall => s14;
  static double get body => s16;
  static double get subtitle => s18;
  static double get title => s20;
  static double get headline => s24;
  static double get display => s30;
  static double get displayLarge => s36;
}

/// Line height management
class FontHeightsManager {
  FontHeightsManager._();

  /// Tight - For headings
  static const double tight = 1.0;

  /// Snug - For subheadings
  static const double snug = 1.25;

  /// Normal - Default for body text
  static const double normal = 1.5;

  /// Relaxed - For descriptions
  static const double relaxed = 1.625;

  /// Loose - For large text blocks
  static const double loose = 2.0;

  // Legacy aliases
  static const double h100 = tight;
  static const double h120 = 1.2;
  static const double h130 = 1.3;
  static const double h140 = 1.4;
  static const double h150 = normal;
}

/// Letter spacing management
class FontLetterSpacingManager {
  FontLetterSpacingManager._();

  /// Tighter - For large headings
  static const double tighter = -1.0;

  /// Tight - For medium headings
  static const double tight = -0.5;

  /// Normal - Default
  static const double normal = 0.0;

  /// Wide - For small caps or labels
  static const double wide = 0.5;

  /// Wider - For buttons or tags
  static const double wider = 1.0;

  // Legacy aliases
  static const double lMinus1 = tighter;
  static const double lMinus05 = tight;
  static const double lZero = normal;
  static const double l05 = wide;
  static const double l1 = wider;
}

/// Text style presets for common use cases
/// Uses Google Fonts Inter for consistent cross-platform typography
class TextStyleManager {
  TextStyleManager._();

  // Display styles
  static TextStyle get displayLarge => TextStyle(
        fontSize: FontSizesManager.s36,
        fontWeight: FontWeightManager.bold,
        height: FontHeightsManager.tight,
        letterSpacing: FontLetterSpacingManager.tighter,
        fontFamily: FontFamily.geist
      );

  static TextStyle get displayMedium => TextStyle(
        fontSize: FontSizesManager.s30,
        fontWeight: FontWeightManager.bold,
        height: FontHeightsManager.snug,
        letterSpacing: FontLetterSpacingManager.tight,
        fontFamily: FontFamily.geist
      );

  static TextStyle get displaySmall => TextStyle(
        fontSize: FontSizesManager.s24,
        fontWeight: FontWeightManager.semiBold,
        height: FontHeightsManager.snug,
        fontFamily: FontFamily.geist
      );

  // Headline styles
  static TextStyle get headlineLarge => TextStyle(
        fontSize: FontSizesManager.s22,
        fontWeight: FontWeightManager.semiBold,
        height: FontHeightsManager.snug,
        fontFamily: FontFamily.geist
      );

  static TextStyle get headlineMedium => TextStyle(
        fontSize: FontSizesManager.s20,
        fontWeight: FontWeightManager.semiBold,
        height: FontHeightsManager.snug,
        fontFamily: FontFamily.geist
      );

  static TextStyle get headlineSmall => TextStyle(
        fontSize: FontSizesManager.s18,
        fontWeight: FontWeightManager.medium,
        height: FontHeightsManager.snug,
        fontFamily: FontFamily.geist
      );

  // Title styles
  static TextStyle get titleLarge => TextStyle(
        fontSize: FontSizesManager.s18,
        fontWeight: FontWeightManager.semiBold,
        height: FontHeightsManager.normal,
        fontFamily: FontFamily.geist
      );

  static TextStyle get titleMedium => TextStyle(
        fontSize: FontSizesManager.s16,
        fontWeight: FontWeightManager.medium,
        height: FontHeightsManager.normal,
        fontFamily: FontFamily.geist
      );

  static TextStyle get titleSmall => TextStyle(
        fontSize: FontSizesManager.s14,
        fontWeight: FontWeightManager.medium,
        height: FontHeightsManager.normal,
        fontFamily: FontFamily.geist
      );

  // Body styles
  static TextStyle get bodyLarge => TextStyle(
        fontSize: FontSizesManager.s16,
        fontWeight: FontWeightManager.regular,
        height: FontHeightsManager.normal,
        fontFamily: FontFamily.geist
      );

  static TextStyle get bodyMedium => TextStyle(
        fontSize: FontSizesManager.s14,
        fontWeight: FontWeightManager.regular,
        height: FontHeightsManager.normal,
        fontFamily: FontFamily.geist
      );

  static TextStyle get bodySmall => TextStyle(
        fontSize: FontSizesManager.s12,
        fontWeight: FontWeightManager.regular,
        height: FontHeightsManager.normal,
        fontFamily: FontFamily.geist
      );

  // Label styles
  static TextStyle get labelLarge => TextStyle(
        fontSize: FontSizesManager.s14,
        fontWeight: FontWeightManager.medium,
        height: FontHeightsManager.normal,
        letterSpacing: FontLetterSpacingManager.wide,
        fontFamily: FontFamily.geist
      );

  static TextStyle get labelMedium => TextStyle(
        fontSize: FontSizesManager.s12,
        fontWeight: FontWeightManager.medium,
        height: FontHeightsManager.normal,
        letterSpacing: FontLetterSpacingManager.wide,
        fontFamily: FontFamily.geist
      );

  static TextStyle get labelSmall => TextStyle(
        fontSize: FontSizesManager.s10,
        fontWeight: FontWeightManager.medium,
        height: FontHeightsManager.normal,
        letterSpacing: FontLetterSpacingManager.wide,
        fontFamily: FontFamily.geist
      );

  // Button text style
  static TextStyle get button => TextStyle(
        fontSize: FontSizesManager.s16,
        fontWeight: FontWeightManager.semiBold,
        height: FontHeightsManager.normal,
        fontFamily: FontFamily.geist
      );

  // Caption style
  static TextStyle get caption => TextStyle(
        fontSize: FontSizesManager.s12,
        fontWeight: FontWeightManager.regular,
        height: FontHeightsManager.normal,
        fontFamily: FontFamily.geist
      );
}


class FontHelper {
  static String fontFamily(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return locale.languageCode == 'ar' ? FontFamily.cairo : FontFamily.geist;
  }
}