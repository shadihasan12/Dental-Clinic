import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

/// A reusable loading dialog with customizable message
class AppLoadingDialog extends StatelessWidget {
  const AppLoadingDialog({
    super.key,
    this.message = 'Loading...',
    this.indicatorColor = const Color(0xFF62B4DA),
  });

  final String message;
  final Color indicatorColor;

  /// The loading dialogs on screen, oldest first.
  static final List<Route<void>> _routes = [];

  /// Show the loading dialog
  static void show({
    required BuildContext context,
    String message = 'Loading...',
    Color indicatorColor = const Color(0xFF62B4DA),
  }) {
    // Pushed on the root navigator, like any showDialog - and the route is
    // kept, so dismiss() can remove exactly this dialog.
    final navigator = Navigator.of(context, rootNavigator: true);
    final route = DialogRoute<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AppLoadingDialog(
        message: message,
        indicatorColor: indicatorColor,
      ),
    );
    _routes.add(route);
    navigator.push(route);
  }

  /// Dismiss the loading dialog
  ///
  /// Removes the dialog's own route rather than popping whatever navigator
  /// [context] sits in. Pages live inside the desktop ShellRoute's navigator
  /// while the dialog sits on the root one, so `Navigator.pop(context)`
  /// closed the *page* and left the spinner over the app for good. It also
  /// cannot pop anything else - a sheet opened above it, or the page - when
  /// no loader is showing.
  static void dismiss(BuildContext context) {
    if (_routes.isEmpty) return;
    final route = _routes.removeLast();
    final navigator = route.navigator;
    if (navigator == null || !route.isActive) return;
    if (route.isCurrent) {
      navigator.pop();
    } else {
      navigator.removeRoute(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
              ),
              SizedBox(height: 16.h),
              Text(
                message,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.of(context).textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
