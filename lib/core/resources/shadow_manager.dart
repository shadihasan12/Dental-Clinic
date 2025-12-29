import 'package:flutter/material.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

/// Shadow and elevation management class for the dental clinic application
/// Based on the design system shadow specifications
class ShadowManager {
  ShadowManager._();

  // ============================================
  // ELEVATION VALUES
  // ============================================

  /// No elevation
  static const double elevationNone = 0;

  /// Extra small elevation - subtle shadow
  static const double elevationXs = 1;

  /// Small elevation - for cards and inputs
  static const double elevationSm = 2;

  /// Medium elevation - for dropdowns and popovers
  static const double elevationMd = 4;

  /// Large elevation - for modals and dialogs
  static const double elevationLg = 8;

  /// Extra large elevation - for floating elements
  static const double elevationXl = 12;

  /// 2X large elevation - for prominent elements
  static const double elevation2xl = 16;

  // ============================================
  // BOX SHADOWS - Matching Tailwind shadow classes
  // ============================================

  /// Shadow XS - Very subtle shadow
  static List<BoxShadow> get shadowXs => [
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.05),
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ];

  /// Shadow SM - Small shadow for cards
  static List<BoxShadow> get shadowSm => [
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.05),
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.05),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  /// Shadow MD - Medium shadow for elevated cards
  static List<BoxShadow> get shadowMd => [
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.1),
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.05),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  /// Shadow LG - Large shadow for dropdowns and popovers
  static List<BoxShadow> get shadowLg => [
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.1),
          blurRadius: 15,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.05),
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ];

  /// Shadow XL - Extra large shadow for modals
  static List<BoxShadow> get shadowXl => [
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.1),
          blurRadius: 25,
          offset: const Offset(0, 20),
        ),
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 8),
        ),
      ];

  /// Shadow 2XL - 2X large shadow for prominent floating elements
  static List<BoxShadow> get shadow2xl => [
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.25),
          blurRadius: 50,
          offset: const Offset(0, 25),
        ),
      ];

  // ============================================
  // COLORED SHADOWS
  // ============================================

  /// Primary color shadow - for primary buttons on hover
  static List<BoxShadow> get shadowPrimary => [
        BoxShadow(
          color: ColorManager.primary.withValues(alpha: 0.3),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  /// Success color shadow
  static List<BoxShadow> get shadowSuccess => [
        BoxShadow(
          color: ColorManager.success.withValues(alpha: 0.3),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  /// Error color shadow
  static List<BoxShadow> get shadowError => [
        BoxShadow(
          color: ColorManager.error.withValues(alpha: 0.3),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  /// Warning color shadow
  static List<BoxShadow> get shadowWarning => [
        BoxShadow(
          color: ColorManager.warning.withValues(alpha: 0.3),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  /// Info color shadow
  static List<BoxShadow> get shadowInfo => [
        BoxShadow(
          color: ColorManager.info.withValues(alpha: 0.3),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  // ============================================
  // INNER SHADOWS
  // ============================================

  /// Inner shadow - for pressed buttons
  static List<BoxShadow> get innerShadow => [
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
          spreadRadius: -1,
        ),
      ];

  // ============================================
  // SPECIAL SHADOWS
  // ============================================

  /// Card shadow - optimized for card components
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.04),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.02),
          blurRadius: 15,
          offset: const Offset(0, 4),
        ),
      ];

  /// Card shadow on hover
  static List<BoxShadow> get cardShadowHover => [
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.08),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.04),
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ];

  /// Button shadow
  static List<BoxShadow> get buttonShadow => [
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  /// Button shadow on hover
  static List<BoxShadow> get buttonShadowHover => [
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.15),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  /// Input focus shadow
  static List<BoxShadow> get inputFocusShadow => [
        BoxShadow(
          color: ColorManager.primary.withValues(alpha: 0.2),
          blurRadius: 0,
          spreadRadius: 3,
        ),
      ];

  /// Bottom navigation shadow
  static List<BoxShadow> get bottomNavShadow => [
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.08),
          blurRadius: 10,
          offset: const Offset(0, -4),
        ),
      ];

  /// App bar shadow
  static List<BoxShadow> get appBarShadow => [
        BoxShadow(
          color: ColorManager.black.withValues(alpha: 0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ];

  /// Floating action button shadow
  static List<BoxShadow> get fabShadow => [
        BoxShadow(
          color: ColorManager.primary.withValues(alpha: 0.4),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ];

  // ============================================
  // HELPER METHODS
  // ============================================

  /// Create a custom box shadow
  static BoxShadow custom({
    Color? color,
    double blurRadius = 6,
    double spreadRadius = 0,
    Offset offset = const Offset(0, 2),
  }) {
    return BoxShadow(
      color: color ?? ColorManager.black.withValues(alpha: 0.1),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      offset: offset,
    );
  }

  /// Create a colored glow shadow
  static List<BoxShadow> glow(Color color, {double intensity = 0.3}) {
    return [
      BoxShadow(
        color: color.withValues(alpha: intensity),
        blurRadius: 20,
        spreadRadius: 2,
      ),
    ];
  }
}
