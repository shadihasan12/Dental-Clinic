import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';

/// Get the application theme data - Light theme
ThemeData getApplicationThemeData() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: FontFamilyManager.primary,

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
      titleTextStyle: TextStyleManager.headlineMedium.copyWith(
        color: ColorManager.textPrimary,
      ),
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
      hintStyle: TextStyleManager.bodyMedium.copyWith(
        color: ColorManager.inputPlaceholder,
      ),
      labelStyle: TextStyleManager.bodyMedium.copyWith(
        color: ColorManager.textSecondary,
      ),
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
        textStyle: TextStyleManager.button,
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
        textStyle: TextStyleManager.button,
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.primary,
        disabledForegroundColor: ColorManager.gray400,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: TextStyleManager.button,
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
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyleManager.labelMedium.copyWith(
            color: ColorManager.primary,
            fontWeight: FontWeightManager.semiBold,
          );
        }
        return TextStyleManager.labelMedium.copyWith(
          color: ColorManager.gray500,
        );
      }),
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
      labelStyle: TextStyleManager.labelMedium.copyWith(
        color: ColorManager.textPrimary,
      ),
      secondaryLabelStyle: TextStyleManager.labelMedium.copyWith(
        color: ColorManager.primary,
      ),
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
      titleTextStyle: TextStyleManager.headlineMedium.copyWith(
        color: ColorManager.textPrimary,
      ),
      contentTextStyle: TextStyleManager.bodyMedium.copyWith(
        color: ColorManager.textSecondary,
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
      contentTextStyle: TextStyleManager.bodyMedium.copyWith(
        color: ColorManager.white,
      ),
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
      labelStyle: TextStyleManager.labelLarge.copyWith(
        fontWeight: FontWeightManager.semiBold,
      ),
      unselectedLabelStyle: TextStyleManager.labelLarge,
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
      titleTextStyle: TextStyleManager.titleMedium.copyWith(
        color: ColorManager.textPrimary,
      ),
      subtitleTextStyle: TextStyleManager.bodySmall.copyWith(
        color: ColorManager.textSecondary,
      ),
      iconColor: ColorManager.textSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.lg,
      ),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyleManager.displayLarge,
      displayMedium: TextStyleManager.displayMedium,
      displaySmall: TextStyleManager.displaySmall,
      headlineLarge: TextStyleManager.headlineLarge,
      headlineMedium: TextStyleManager.headlineMedium,
      headlineSmall: TextStyleManager.headlineSmall,
      titleLarge: TextStyleManager.titleLarge,
      titleMedium: TextStyleManager.titleMedium,
      titleSmall: TextStyleManager.titleSmall,
      bodyLarge: TextStyleManager.bodyLarge,
      bodyMedium: TextStyleManager.bodyMedium,
      bodySmall: TextStyleManager.bodySmall,
      labelLarge: TextStyleManager.labelLarge,
      labelMedium: TextStyleManager.labelMedium,
      labelSmall: TextStyleManager.labelSmall,
    ),
  );
}

/// Get dark theme data
ThemeData getDarkThemeData() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: FontFamilyManager.primary,

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
      surface: const Color(0xFF1E1E1E),
      onSurface: ColorManager.white,
    ),

    scaffoldBackgroundColor: const Color(0xFF121212),

    // App Bar Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: ColorManager.transparent,
      foregroundColor: ColorManager.white,
      surfaceTintColor: ColorManager.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: const IconThemeData(color: ColorManager.white),
      titleTextStyle: TextStyleManager.headlineMedium.copyWith(
        color: ColorManager.white,
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E),
      elevation: 0,
      surfaceTintColor: ColorManager.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.xl,
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2A2A2A),
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintStyle: TextStyleManager.bodyMedium.copyWith(
        color: ColorManager.gray500,
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(88, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusManager.xl,
        ),
        elevation: 0,
        textStyle: TextStyleManager.button,
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: ColorManager.primary,
      unselectedItemColor: ColorManager.gray500,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: ColorManager.gray700,
      thickness: 1,
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyleManager.displayLarge.copyWith(color: ColorManager.white),
      displayMedium: TextStyleManager.displayMedium.copyWith(color: ColorManager.white),
      displaySmall: TextStyleManager.displaySmall.copyWith(color: ColorManager.white),
      headlineLarge: TextStyleManager.headlineLarge.copyWith(color: ColorManager.white),
      headlineMedium: TextStyleManager.headlineMedium.copyWith(color: ColorManager.white),
      headlineSmall: TextStyleManager.headlineSmall.copyWith(color: ColorManager.white),
      titleLarge: TextStyleManager.titleLarge.copyWith(color: ColorManager.white),
      titleMedium: TextStyleManager.titleMedium.copyWith(color: ColorManager.white),
      titleSmall: TextStyleManager.titleSmall.copyWith(color: ColorManager.white),
      bodyLarge: TextStyleManager.bodyLarge.copyWith(color: ColorManager.gray200),
      bodyMedium: TextStyleManager.bodyMedium.copyWith(color: ColorManager.gray300),
      bodySmall: TextStyleManager.bodySmall.copyWith(color: ColorManager.gray400),
      labelLarge: TextStyleManager.labelLarge.copyWith(color: ColorManager.gray200),
      labelMedium: TextStyleManager.labelMedium.copyWith(color: ColorManager.gray300),
      labelSmall: TextStyleManager.labelSmall.copyWith(color: ColorManager.gray400),
    ),
  );
}
