import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';

/// Custom snackbar helper for consistent, visible notifications
class AppSnackbar {
  AppSnackbar._();

  /// Show success snackbar (teal color, appears from top)
  static void showSuccess(
    BuildContext context, {
    required String title,
    String? message,
  }) {
    _show(context, title: title, message: message, type: _SnackbarType.success);
  }

  /// Show error snackbar (red color, appears from top)
  static void showError(
    BuildContext context, {
    required String title,
    String? message,
  }) {
    _show(context, title: title, message: message, type: _SnackbarType.error);
  }

  /// Show warning snackbar (orange color, appears from top)
  static void showWarning(
    BuildContext context, {
    required String title,
    String? message,
  }) {
    _show(context, title: title, message: message, type: _SnackbarType.warning);
  }

  /// Show info snackbar (blue color, appears from top)
  static void showInfo(
    BuildContext context, {
    required String title,
    String? message,
  }) {
    _show(context, title: title, message: message, type: _SnackbarType.info);
  }

  static void _show(
    BuildContext context, {
    required String title,
    String? message,
    required _SnackbarType type,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _SnackbarContent(title: title, message: message, type: type),
        backgroundColor: type.backgroundColor,
        behavior: SnackBarBehavior.floating,
        elevation: 8,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        duration: const Duration(seconds: 4),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}

enum _SnackbarType { success, error, warning, info }

extension on _SnackbarType {
  Color get backgroundColor {
    switch (this) {
      case _SnackbarType.success:
        return const Color(0xFF70B2B2);
      case _SnackbarType.error:
        return const Color(0xFFEF4444);
      case _SnackbarType.warning:
        return const Color(0xFFF59E0B);
      case _SnackbarType.info:
        return const Color(0xFF3B82F6);
    }
  }

  IconData get icon {
    switch (this) {
      case _SnackbarType.success:
        return Icons.check_circle_rounded;
      case _SnackbarType.error:
        return Icons.error_rounded;
      case _SnackbarType.warning:
        return Icons.warning_rounded;
      case _SnackbarType.info:
        return Icons.info_rounded;
    }
  }
}

class _SnackbarContent extends StatelessWidget {
  const _SnackbarContent({
    required this.title,
    this.message,
    required this.type,
  });

  final String title;
  final String? message;
  final _SnackbarType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: type.backgroundColor.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: ColorManager.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(type.icon, color: ColorManager.white, size: 22.w),
          ),
          SizedBox(width: 12.w),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyleManager.titleSmall.copyWith(
                    color: ColorManager.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (message != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    message!,
                    style: TextStyleManager.bodySmall.copyWith(
                      color: ColorManager.white.withValues(alpha: 0.9),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          // Close button
          GestureDetector(
            onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            child: Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: ColorManager.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.close, color: ColorManager.white, size: 16.w),
            ),
          ),
        ],
      ),
    );
  }
}
