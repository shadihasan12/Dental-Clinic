import 'package:flutter/material.dart';

/// Color management class for the dental clinic application
/// Based on the design system with teal theme
class ColorManager {
  ColorManager._();

  // ============================================
  // TRANSPARENT
  // ============================================
  static const Color transparent = Colors.transparent;

  // ============================================
  // PRIMARY COLORS - Teal Theme
  // ============================================
  static const Color primary = Color(0xFF70B2B2);
  static const Color primaryDark = Color(0xFF5A9999);
  static const Color primaryDarker = Color(0xFF4A8888);
  static const Color primaryLight = Color(0xFF8BC9C9);
  static const Color primaryLighter = Color(0xFFA5D6D6);

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
  // NEUTRAL COLORS
  // ============================================
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

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
  // SEMANTIC / STATUS COLORS
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
  // BACKGROUND COLORS
  // ============================================
  static const Color background = gray50;
  static const Color backgroundSecondary = gray100;
  static const Color surface = white;
  static const Color scaffoldBackground = gray50;

  // ============================================
  // TEXT COLORS
  // ============================================
  static const Color textPrimary = gray900;
  static const Color textSecondary = gray600;
  static const Color textTertiary = gray500;
  static const Color textSubtle = gray400;
  static const Color textHint = gray400;
  static const Color textOnPrimary = white;
  static const Color textOnDark = white;

  // ============================================
  // DENTAL SPECIFIC COLORS
  // ============================================
  static const Color toothWhite = Color(0xFFFFFDE7);
  static const Color dentalBlue = Color(0xFF0288D1);
  static const Color healthGreen = Color(0xFF43A047);
  static const Color medicalTeal = primary;

  // ============================================
  // CARD & CONTAINER COLORS
  // ============================================
  static const Color cardBackground = white;
  static const Color cardBackgroundSecondary = gray50;
  static const Color divider = gray200;
  static const Color border = gray300;
  static const Color borderLight = gray200;

  // ============================================
  // INPUT FIELD COLORS
  // ============================================
  static const Color inputBackground = gray50;
  static const Color inputBorder = gray300;
  static const Color inputBorderFocused = primary;
  static const Color inputPlaceholder = gray400;

  // ============================================
  // SHIMMER / LOADING
  // ============================================
  static const Color shimmerBase = gray200;
  static const Color shimmerHighlight = gray100;

  // ============================================
  // OVERLAY COLORS
  // ============================================
  static Color get overlay => black.withValues(alpha: 0.5);
  static Color get overlayLight => black.withValues(alpha: 0.3);
  static Color get glassmorphism => white.withValues(alpha: 0.2);
}
