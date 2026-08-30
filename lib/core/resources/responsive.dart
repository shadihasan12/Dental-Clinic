import 'package:flutter/material.dart';

/// Central breakpoints and helpers for responsive layout.
/// All screens should use these instead of hardcoded values.
class Responsive {
  Responsive._();

  static const double desktopBreakpoint = 900;
  static const double tabletBreakpoint = 600;

  /// Max width for form content on desktop.
  static const double formMaxWidth = 480;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint &&
      MediaQuery.of(context).size.width < desktopBreakpoint;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletBreakpoint;
}
