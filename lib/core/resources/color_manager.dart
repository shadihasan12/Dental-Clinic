import 'package:flutter/material.dart';

/// Color management class for the dental clinic application
/// Based on the design system, keyed to the Denta brand blue
///
/// Static colors remain for use in non-context situations (theme definitions).
/// Use [of(context)] for theme-aware colors in widgets.
class ColorManager {
  ColorManager._();

  // ============================================
  // TRANSPARENT
  // ============================================
  static const Color transparent = Colors.transparent;

  // ============================================
  // PRIMARY COLORS - Denta Blue (same in both themes)
  // ============================================
  // The logo blue (#199ED9) at full strength was too loud for large UI areas,
// so the ramp keeps its hue but softens it to S62% L62%. The logo artwork
// itself keeps the vivid original - this ramp is for UI surfaces only.
// Swap these five values to retune; everything else derives from them.
// The ramp keeps the
  // lightness relationships of the previous teal palette, so every existing
  // use of primaryLight/Dark/etc. holds its relative weight.
  static const Color primary = Color(0xFF62B4DA);
  static const Color primaryDark = Color(0xFF3DA2D1);
  static const Color primaryDarker = Color(0xFF2D90BE);
  static const Color primaryLight = Color(0xFF8BC8E4);
  static const Color primaryLighter = Color(0xFFA8D6EB);

  // Primary with opacity variants
  static Color get primary5 => primary.withValues(alpha: 0.05);
  static Color get primary10 => primary.withValues(alpha: 0.10);
  static Color get primary20 => primary.withValues(alpha: 0.20);
  static Color get primary30 => primary.withValues(alpha: 0.30);

  // ============================================
  // SECONDARY COLORS
  // ============================================
  static const Color secondary = Color(0xFF26A69A);
  static const Color secondaryLight = Color(0xFF80CBC4);

  // ============================================
  // NEUTRAL COLORS (light palette — used as base)
  // ============================================
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color textDark = Color(0xFF2D2D2D);

  // Gray Scale (Tailwind-inspired)
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  // Legacy neutral aliases
  static const Color lightGrey = gray100;
  static const Color grey = gray400;
  static const Color darkGrey = gray600;
  static const Color veryDarkGrey = gray700;

  // ============================================
  // SEMANTIC / STATUS COLORS (same in both themes)
  // ============================================

  // Success - Green
  static const Color success = Color(0xFF16A34A);
  static const Color successLight = Color(0xFF22C55E);
  static const Color successBackground = Color(0xFFDCFCE7);
  static const Color successBorder = Color(0xFFBBF7D0);

  // Warning - Orange
  static const Color warning = Color(0xFFEA580C);
  static const Color warningLight = Color(0xFFF97316);
  static const Color warningBackground = Color(0xFFFFEDD5);
  static const Color warningBorder = Color(0xFFFED7AA);

  // Error / Destructive - Red
  static const Color error = Color(0xFFDC2626);
  static const Color errorLight = Color(0xFFEF4444);
  static const Color errorBackground = Color(0xFFFEE2E2);
  static const Color errorBorder = Color(0xFFFECACA);
  static const Color destructive = Color(0xFFD4183D);

  // Info - Blue
  static const Color info = Color(0xFF2563EB);
  static const Color infoLight = Color(0xFF3B82F6);
  static const Color infoExtraLight = Color.fromARGB(255, 79, 134, 207);
  static const Color infoBackground = Color(0xFFDBEAFE);
  static const Color infoBorder = Color(0xFFBFDBFE);

  // Pending / In-Progress - Blue variant
  static const Color pending = Color(0xFFEA580C);
  static const Color pendingBackground = Color(0xFFFFEDD5);
  static const Color inProgress = Color(0xFF2563EB);
  static const Color inProgressBackground = Color(0xFFDBEAFE);

  // Purple - Accent
  static const Color purple = Color(0xFF9333EA);
  static const Color purpleLight = Color(0xFFA855F7);
  static const Color purpleBackground = Color(0xFFF3E8FF);
  static const Color purpleBorder = Color(0xFFE9D5FF);

  // ============================================
  // DENTAL SPECIFIC COLORS
  // ============================================
  static const Color toothWhite = Color(0xFFFFFDE7);
  static const Color dentalBlue = Color(0xFF0288D1);
  static const Color healthGreen = Color(0xFF43A047);
  static const Color medicalTeal = primary;

  // ============================================
  // THEME-AWARE SEMANTIC COLORS
  // These are light-mode defaults. Use [of(context)]
  // in widgets for automatic dark-mode switching.
  // ============================================
  static const Color background = gray50;
  static const Color backgroundSecondary = gray100;
  static const Color surface = white;
  static const Color scaffoldBackground = gray50;

  static const Color textPrimary = gray900;
  static const Color textSecondary = gray600;
  static const Color textTertiary = gray500;
  static const Color textSubtle = gray400;
  static const Color textHint = gray400;
  static const Color textOnPrimary = white;
  static const Color textOnDark = white;

  static const Color cardBackground = white;
  static const Color cardBackgroundSecondary = gray50;
  static const Color divider = gray200;
  static const Color border = gray300;
  static const Color borderLight = gray200;

  static const Color inputBackground = gray50;
  static const Color inputBorder = gray300;
  static const Color inputBorderFocused = primary;
  static const Color inputPlaceholder = gray400;

  static const Color shimmerBase = gray200;
  static const Color shimmerHighlight = gray100;

  // ============================================
  // OVERLAY COLORS
  // ============================================
  static Color get overlay => black.withValues(alpha: 0.5);
  static Color get overlayLight => black.withValues(alpha: 0.3);
  static Color get glassmorphism => white.withValues(alpha: 0.2);

  // ============================================
  // CONTEXT-AWARE COLOR RESOLVER
  // ============================================

  /// Returns a theme-aware color set based on the current brightness.
  /// Usage: `final c = ColorManager.of(context);`
  /// Then: `c.scaffoldBg`, `c.textPrimary`, `c.cardBg`, etc.
  static AppColors of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? _dark : _light;
  }

  static const _light = AppColors(
    scaffoldBg: gray50,
    surfaceBg: white,
    cardBg: white,
    cardBgSecondary: gray50,
    textPrimary: gray900,
    textSecondary: gray600,
    textTertiary: gray500,
    textSubtle: gray400,
    textHint: gray400,
    divider: gray200,
    border: gray300,
    borderLight: gray200,
    inputBg: gray50,
    inputBorder: gray300,
    shimmerBase: gray200,
    shimmerHighlight: gray100,
    iconDefault: gray600,
    menuGroupBg: gray50,
    menuIconBg: white,
    successBg: Color(0xFFDCFCE7),
    warningBg: Color(0xFFFFEDD5),
    errorBg: Color(0xFFFEE2E2),
    infoBg: Color(0xFFDBEAFE),
    purpleBg: Color(0xFFF3E8FF),
  );

  static const _dark = AppColors(
    scaffoldBg: Color(0xFF121212),
    surfaceBg: Color(0xFF1E1E1E),
    cardBg: Color(0xFF1E1E1E),
    cardBgSecondary: Color(0xFF252525),
    textPrimary: Color(0xFFE8E8E8),
    textSecondary: Color(0xFFB0B0B0),
    textTertiary: Color(0xFF8A8A8A),
    textSubtle: Color(0xFF6A6A6A),
    textHint: Color(0xFF6A6A6A),
    divider: Color(0xFF2E2E2E),
    border: Color(0xFF3A3A3A),
    borderLight: Color(0xFF2E2E2E),
    inputBg: Color(0xFF2A2A2A),
    inputBorder: Color(0xFF3A3A3A),
    shimmerBase: Color(0xFF2A2A2A),
    shimmerHighlight: Color(0xFF333333),
    iconDefault: Color(0xFFB0B0B0),
    menuGroupBg: Color(0xFF1E1E1E),
    menuIconBg: Color(0xFF2A2A2A),
    successBg: Color(0xFF1A3A2A),
    warningBg: Color(0xFF3A2A1A),
    errorBg: Color(0xFF3A1A1A),
    infoBg: Color(0xFF1A2A3A),
    purpleBg: Color(0xFF2A1A3A),
  );
}

/// Immutable set of theme-aware colors resolved from context.
class AppColors {
  final Color scaffoldBg;
  final Color surfaceBg;
  final Color cardBg;
  final Color cardBgSecondary;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textSubtle;
  final Color textHint;
  final Color divider;
  final Color border;
  final Color borderLight;
  final Color inputBg;
  final Color inputBorder;
  final Color shimmerBase;
  final Color shimmerHighlight;
  final Color iconDefault;
  final Color menuGroupBg;
  final Color menuIconBg;
  final Color successBg;
  final Color warningBg;
  final Color errorBg;
  final Color infoBg;
  final Color purpleBg;

  const AppColors({
    required this.scaffoldBg,
    required this.surfaceBg,
    required this.cardBg,
    required this.cardBgSecondary,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textSubtle,
    required this.textHint,
    required this.divider,
    required this.border,
    required this.borderLight,
    required this.inputBg,
    required this.inputBorder,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.iconDefault,
    required this.menuGroupBg,
    required this.menuIconBg,
    required this.successBg,
    required this.warningBg,
    required this.errorBg,
    required this.infoBg,
    required this.purpleBg,
  });
}
