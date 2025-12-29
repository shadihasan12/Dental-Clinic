import 'package:flutter/material.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

/// Gradient management class for the dental clinic application
/// Based on the design system teal gradient theme
class GradientManager {
  GradientManager._();

  // ============================================
  // PRIMARY TEAL GRADIENTS
  // ============================================

  /// Main header gradient - used for page headers and hero sections
  /// Direction: Top-left to Bottom-right
  static LinearGradient get primaryHeader => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          ColorManager.primary,
          ColorManager.primaryDark,
          ColorManager.primaryDarker,
        ],
      );

  /// Button gradient - used for primary action buttons
  /// Direction: Left to Right
  static LinearGradient get primaryButton => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          ColorManager.primary,
          ColorManager.primaryDark,
        ],
      );

  /// Button gradient hover state
  static LinearGradient get primaryButtonHover => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          ColorManager.primaryDark,
          ColorManager.primaryDarker,
        ],
      );

  /// Light teal gradient - used for subtle backgrounds
  static LinearGradient get primaryLight => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          ColorManager.primaryLighter,
          ColorManager.primaryLight,
        ],
      );

  /// Card icon gradient - variation 1
  static LinearGradient get iconGradient1 => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          ColorManager.primary,
          ColorManager.primaryDark,
        ],
      );

  /// Card icon gradient - variation 2 (lighter)
  static LinearGradient get iconGradient2 => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          ColorManager.primaryLight,
          ColorManager.primary,
        ],
      );

  // ============================================
  // BACKGROUND GRADIENTS
  // ============================================

  /// Subtle background gradient - for page backgrounds
  static LinearGradient get backgroundSubtle => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          ColorManager.gray50,
          ColorManager.gray100,
        ],
      );

  /// White to gray gradient
  static LinearGradient get backgroundWhite => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          ColorManager.white,
          ColorManager.gray50,
        ],
      );

  // ============================================
  // OVERLAY GRADIENTS
  // ============================================

  /// Dark overlay gradient - for image overlays (top to bottom)
  static LinearGradient get overlayDark => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          ColorManager.transparent,
          ColorManager.black.withValues(alpha: 0.6),
        ],
      );

  /// Light overlay gradient
  static LinearGradient get overlayLight => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          ColorManager.transparent,
          ColorManager.black.withValues(alpha: 0.3),
        ],
      );

  /// Glassmorphism overlay
  static LinearGradient get glassmorphism => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          ColorManager.white.withValues(alpha: 0.25),
          ColorManager.white.withValues(alpha: 0.1),
        ],
      );

  // ============================================
  // STATUS GRADIENTS
  // ============================================

  /// Success gradient
  static LinearGradient get success => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          ColorManager.success,
          ColorManager.successLight,
        ],
      );

  /// Warning gradient
  static LinearGradient get warning => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          ColorManager.warning,
          ColorManager.warningLight,
        ],
      );

  /// Error gradient
  static LinearGradient get error => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          ColorManager.error,
          ColorManager.errorLight,
        ],
      );

  /// Info gradient
  static LinearGradient get info => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          ColorManager.info,
          ColorManager.infoLight,
        ],
      );

  // ============================================
  // RADIAL GRADIENTS
  // ============================================

  /// Primary radial gradient - for circular elements
  static RadialGradient get primaryRadial => const RadialGradient(
        center: Alignment.center,
        radius: 0.8,
        colors: [
          ColorManager.primaryLight,
          ColorManager.primary,
        ],
      );

  /// Decorative circle gradient - for background decorations
  static RadialGradient get decorativeCircle => RadialGradient(
        center: Alignment.center,
        radius: 1.0,
        colors: [
          ColorManager.white.withValues(alpha: 0.1),
          ColorManager.transparent,
        ],
      );

  // ============================================
  // SWEEP GRADIENTS
  // ============================================

  /// Progress indicator gradient
  static SweepGradient get progressIndicator => const SweepGradient(
        colors: [
          ColorManager.primary,
          ColorManager.primaryLight,
          ColorManager.primary,
        ],
      );

  // ============================================
  // HELPER METHODS
  // ============================================

  /// Create a custom linear gradient with the primary colors
  static LinearGradient custom({
    required List<Color> colors,
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
    List<double>? stops,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: colors,
      stops: stops,
    );
  }

  /// Create a vertical gradient
  static LinearGradient vertical({
    required List<Color> colors,
    List<double>? stops,
  }) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: colors,
      stops: stops,
    );
  }

  /// Create a horizontal gradient
  static LinearGradient horizontal({
    required List<Color> colors,
    List<double>? stops,
  }) {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: colors,
      stops: stops,
    );
  }

  /// Create a diagonal gradient (top-left to bottom-right)
  static LinearGradient diagonal({
    required List<Color> colors,
    List<double>? stops,
  }) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: colors,
      stops: stops,
    );
  }
}
