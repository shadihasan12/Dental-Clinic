import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';

/// Get the application theme data - Light theme
ThemeData getApplicationThemeData() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: FontFamily.geist,

    // Color Scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorManager.primary,
      brightness: Brightness.light,
      primary: ColorManager.primary,
      onPrimary: ColorManager.white,
      secondary: ColorManager.secondary,
      onSecondary: ColorManager.white,
      error: ColorManager.error,
      onError: ColorManager.white,
      surface: ColorManager.surface,
      onSurface: ColorManager.textPrimary,
    ),

    // Scaffold
    scaffoldBackgroundColor: ColorManager.scaffoldBackground,

    // App Bar Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: ColorManager.transparent,
      foregroundColor: ColorManager.textPrimary,
      surfaceTintColor: ColorManager.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: const IconThemeData(color: ColorManager.textPrimary),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: ColorManager.cardBackground,
      elevation: 0,
      shadowColor: ColorManager.black.withValues(alpha: 0.1),
      surfaceTintColor: ColorManager.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.xl,
      ),
      margin: EdgeInsets.zero,
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.inputBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadiusManager.xl,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadiusManager.xl,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadiusManager.xl,
        borderSide: const BorderSide(color: ColorManager.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadiusManager.xl,
        borderSide: const BorderSide(color: ColorManager.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadiusManager.xl,
        borderSide: const BorderSide(color: ColorManager.error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      prefixIconColor: ColorManager.textSecondary,
      suffixIconColor: ColorManager.textSecondary,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.white,
        disabledBackgroundColor: ColorManager.gray300,
        disabledForegroundColor: ColorManager.gray500,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(88, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusManager.xl,
        ),
        elevation: 0,
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorManager.primary,
        disabledForegroundColor: ColorManager.gray400,
        side: const BorderSide(color: ColorManager.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(88, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusManager.xl,
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.primary,
        disabledForegroundColor: ColorManager.gray400,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorManager.primary,
      foregroundColor: ColorManager.white,
      elevation: 4,
      highlightElevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.lg,
      ),
    ),

    // Icon Button Theme
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: ColorManager.textPrimary,
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorManager.white,
      selectedItemColor: ColorManager.primary,
      unselectedItemColor: ColorManager.gray400,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Navigation Bar Theme (Material 3)
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: ColorManager.white,
      indicatorColor: ColorManager.primary10,
      surfaceTintColor: ColorManager.transparent,
      elevation: 0,
      
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: ColorManager.primary);
        }
        return const IconThemeData(color: ColorManager.gray400);
      }),
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: ColorManager.divider,
      thickness: 1,
      space: 1,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: ColorManager.gray100,
      disabledColor: ColorManager.gray200,
      selectedColor: ColorManager.primary10,
      secondarySelectedColor: ColorManager.primaryLight,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.full,
      ),
    ),

    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: ColorManager.white,
      elevation: 0,
      surfaceTintColor: ColorManager.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.xl,
      ),
     
    ),

    // Bottom Sheet Theme
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ColorManager.white,
      elevation: 0,
      surfaceTintColor: ColorManager.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.bottomSheet,
      ),
      modalBackgroundColor: ColorManager.white,
      modalElevation: 0,
    ),

    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: ColorManager.gray800,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.lg,
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    ),

    // Tab Bar Theme
    tabBarTheme: TabBarThemeData(
      labelColor: ColorManager.primary,
      unselectedLabelColor: ColorManager.gray500,
      indicatorColor: ColorManager.primary,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: ColorManager.transparent,
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ColorManager.primary,
      linearTrackColor: ColorManager.gray200,
      circularTrackColor: ColorManager.gray200,
    ),

    // Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: ColorManager.primary,
      inactiveTrackColor: ColorManager.gray200,
      thumbColor: ColorManager.primary,
      overlayColor: ColorManager.primary.withValues(alpha: 0.2),
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorManager.white;
        }
        return ColorManager.gray400;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorManager.primary;
        }
        return ColorManager.gray200;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        return ColorManager.transparent;
      }),
    ),

    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorManager.primary;
        }
        return ColorManager.transparent;
      }),
      checkColor: WidgetStateProperty.all(ColorManager.white),
      side: const BorderSide(color: ColorManager.gray400, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.xs,
      ),
    ),

    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorManager.primary;
        }
        return ColorManager.gray400;
      }),
    ),

    // List Tile Theme
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      iconColor: ColorManager.textSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.lg,
      ),
    ),

  
  );
}

/// Dark color constants used only in the dark theme definition
class _DarkColors {
  static const scaffold = Color(0xFF121212);
  static const surface = Color(0xFF1E1E1E);
  static const input = Color(0xFF2A2A2A);
  static const textPrimary = Color(0xFFE8E8E8);
  static const textSecondary = Color(0xFFB0B0B0);
  static const divider = Color(0xFF2E2E2E);
  static const border = Color(0xFF3A3A3A);
}

/// Get dark theme data
ThemeData getDarkThemeData() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: FontFamily.geist,

    // Color Scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorManager.primary,
      brightness: Brightness.dark,
      primary: ColorManager.primary,
      onPrimary: ColorManager.white,
      secondary: ColorManager.secondary,
      onSecondary: ColorManager.white,
      error: ColorManager.error,
      onError: ColorManager.white,
      surface: _DarkColors.surface,
      onSurface: _DarkColors.textPrimary,
    ),

    scaffoldBackgroundColor: _DarkColors.scaffold,

    // App Bar Theme
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: ColorManager.transparent,
      foregroundColor: _DarkColors.textPrimary,
      surfaceTintColor: ColorManager.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: IconThemeData(color: _DarkColors.textPrimary),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: _DarkColors.surface,
      elevation: 0,
      surfaceTintColor: ColorManager.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.xl,
      ),
      margin: EdgeInsets.zero,
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _DarkColors.input,
      border: OutlineInputBorder(
        borderRadius: BorderRadiusManager.xl,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadiusManager.xl,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadiusManager.xl,
        borderSide: const BorderSide(color: ColorManager.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadiusManager.xl,
        borderSide: const BorderSide(color: ColorManager.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadiusManager.xl,
        borderSide: const BorderSide(color: ColorManager.error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      prefixIconColor: _DarkColors.textSecondary,
      suffixIconColor: _DarkColors.textSecondary,
      hintStyle: const TextStyle(color: Color(0xFF6A6A6A)),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.white,
        disabledBackgroundColor: const Color(0xFF3A3A3A),
        disabledForegroundColor: const Color(0xFF6A6A6A),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(88, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusManager.xl,
        ),
        elevation: 0,
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorManager.primary,
        disabledForegroundColor: const Color(0xFF6A6A6A),
        side: const BorderSide(color: ColorManager.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(88, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusManager.xl,
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.primary,
        disabledForegroundColor: const Color(0xFF6A6A6A),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorManager.primary,
      foregroundColor: ColorManager.white,
      elevation: 4,
      highlightElevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.lg,
      ),
    ),

    // Icon Button Theme
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: _DarkColors.textPrimary,
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _DarkColors.surface,
      selectedItemColor: ColorManager.primary,
      unselectedItemColor: Color(0xFF6A6A6A),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Navigation Bar Theme (Material 3)
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: _DarkColors.surface,
      indicatorColor: ColorManager.primary10,
      surfaceTintColor: ColorManager.transparent,
      elevation: 0,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: ColorManager.primary);
        }
        return const IconThemeData(color: Color(0xFF6A6A6A));
      }),
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: _DarkColors.divider,
      thickness: 1,
      space: 1,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: _DarkColors.input,
      disabledColor: const Color(0xFF333333),
      selectedColor: ColorManager.primary10,
      secondarySelectedColor: ColorManager.primaryLight,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.full,
      ),
    ),

    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: _DarkColors.surface,
      elevation: 0,
      surfaceTintColor: ColorManager.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.xl,
      ),
    ),

    // Bottom Sheet Theme
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: _DarkColors.surface,
      elevation: 0,
      surfaceTintColor: ColorManager.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.bottomSheet,
      ),
      modalBackgroundColor: _DarkColors.surface,
      modalElevation: 0,
    ),

    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFF333333),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.lg,
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    ),

    // Tab Bar Theme
    tabBarTheme: const TabBarThemeData(
      labelColor: ColorManager.primary,
      unselectedLabelColor: Color(0xFF8A8A8A),
      indicatorColor: ColorManager.primary,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: ColorManager.transparent,
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ColorManager.primary,
      linearTrackColor: Color(0xFF333333),
      circularTrackColor: Color(0xFF333333),
    ),

    // Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: ColorManager.primary,
      inactiveTrackColor: const Color(0xFF333333),
      thumbColor: ColorManager.primary,
      overlayColor: ColorManager.primary.withValues(alpha: 0.2),
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorManager.white;
        }
        return const Color(0xFF6A6A6A);
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorManager.primary;
        }
        return const Color(0xFF333333);
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        return ColorManager.transparent;
      }),
    ),

    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorManager.primary;
        }
        return ColorManager.transparent;
      }),
      checkColor: WidgetStateProperty.all(ColorManager.white),
      side: const BorderSide(color: Color(0xFF6A6A6A), width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.xs,
      ),
    ),

    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorManager.primary;
        }
        return const Color(0xFF6A6A6A);
      }),
    ),

    // List Tile Theme
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      iconColor: _DarkColors.textSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.lg,
      ),
    ),
  );
}
