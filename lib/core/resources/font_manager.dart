import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Font family management
class FontFamilyManager {
  FontFamilyManager._();

  /// Primary font - Inter (Modern sans-serif from Google Fonts)
  static const String primary = 'Inter';

  /// Fallback font - System default
  static const String fallback = 'Roboto';

  /// Font family with fallback chain
  static const List<String> fontFamilyFallback = [
    'Inter',
    '-apple-system',
    'BlinkMacSystemFont',
    'Segoe UI',
    'Roboto',
    'Helvetica Neue',
    'Arial',
    'sans-serif',
  ];

  /// Get Inter text theme using Google Fonts
  static TextTheme get interTextTheme => GoogleFonts.interTextTheme();

  /// Get Inter text style with custom properties
  static TextStyle inter({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
    );
  }
}

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
  static TextStyle get displayLarge => GoogleFonts.inter(
        fontSize: FontSizesManager.s36,
        fontWeight: FontWeightManager.bold,
        height: FontHeightsManager.tight,
        letterSpacing: FontLetterSpacingManager.tighter,
      );

  static TextStyle get displayMedium => GoogleFonts.inter(
        fontSize: FontSizesManager.s30,
        fontWeight: FontWeightManager.bold,
        height: FontHeightsManager.snug,
        letterSpacing: FontLetterSpacingManager.tight,
      );

  static TextStyle get displaySmall => GoogleFonts.inter(
        fontSize: FontSizesManager.s24,
        fontWeight: FontWeightManager.semiBold,
        height: FontHeightsManager.snug,
      );

  // Headline styles
  static TextStyle get headlineLarge => GoogleFonts.inter(
        fontSize: FontSizesManager.s22,
        fontWeight: FontWeightManager.semiBold,
        height: FontHeightsManager.snug,
      );

  static TextStyle get headlineMedium => GoogleFonts.inter(
        fontSize: FontSizesManager.s20,
        fontWeight: FontWeightManager.semiBold,
        height: FontHeightsManager.snug,
      );

  static TextStyle get headlineSmall => GoogleFonts.inter(
        fontSize: FontSizesManager.s18,
        fontWeight: FontWeightManager.medium,
        height: FontHeightsManager.snug,
      );

  // Title styles
  static TextStyle get titleLarge => GoogleFonts.inter(
        fontSize: FontSizesManager.s18,
        fontWeight: FontWeightManager.semiBold,
        height: FontHeightsManager.normal,
      );

  static TextStyle get titleMedium => GoogleFonts.inter(
        fontSize: FontSizesManager.s16,
        fontWeight: FontWeightManager.medium,
        height: FontHeightsManager.normal,
      );

  static TextStyle get titleSmall => GoogleFonts.inter(
        fontSize: FontSizesManager.s14,
        fontWeight: FontWeightManager.medium,
        height: FontHeightsManager.normal,
      );

  // Body styles
  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: FontSizesManager.s16,
        fontWeight: FontWeightManager.regular,
        height: FontHeightsManager.normal,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: FontSizesManager.s14,
        fontWeight: FontWeightManager.regular,
        height: FontHeightsManager.normal,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: FontSizesManager.s12,
        fontWeight: FontWeightManager.regular,
        height: FontHeightsManager.normal,
      );

  // Label styles
  static TextStyle get labelLarge => GoogleFonts.inter(
        fontSize: FontSizesManager.s14,
        fontWeight: FontWeightManager.medium,
        height: FontHeightsManager.normal,
        letterSpacing: FontLetterSpacingManager.wide,
      );

  static TextStyle get labelMedium => GoogleFonts.inter(
        fontSize: FontSizesManager.s12,
        fontWeight: FontWeightManager.medium,
        height: FontHeightsManager.normal,
        letterSpacing: FontLetterSpacingManager.wide,
      );

  static TextStyle get labelSmall => GoogleFonts.inter(
        fontSize: FontSizesManager.s10,
        fontWeight: FontWeightManager.medium,
        height: FontHeightsManager.normal,
        letterSpacing: FontLetterSpacingManager.wide,
      );

  // Button text style
  static TextStyle get button => GoogleFonts.inter(
        fontSize: FontSizesManager.s16,
        fontWeight: FontWeightManager.semiBold,
        height: FontHeightsManager.normal,
      );

  // Caption style
  static TextStyle get caption => GoogleFonts.inter(
        fontSize: FontSizesManager.s12,
        fontWeight: FontWeightManager.regular,
        height: FontHeightsManager.normal,
      );
}
