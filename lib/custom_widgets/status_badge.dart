import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';

/// Status types for badges
enum StatusType {
  success,
  warning,
  error,
  info,
  pending,
  inProgress,
  completed,
  upcoming,
  active,
  inactive,
}

/// Status badge widget for displaying status indicators
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    required this.type,
    this.icon,
    this.showDot = false,
  });

  final String label;
  final StatusType type;
  final IconData? icon;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadiusManager.full,
        border: Border.all(
          color: _getBorderColor(),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6.w,
              height: 6.h,
              decoration: BoxDecoration(
                color: _getTextColor(),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.w),
          ],
          if (icon != null) ...[
            Icon(
              icon,
              size: 14.w,
              color: _getTextColor(),
            ),
            SizedBox(width: 4.w),
          ],
          Text(
            label,
            style: TextStyleManager.labelSmall.copyWith(
              color: _getTextColor(),
              fontWeight: FontWeightManager.semiBold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (type) {
      case StatusType.success:
      case StatusType.completed:
      case StatusType.active:
        return ColorManager.successBackground;
      case StatusType.warning:
      case StatusType.pending:
      case StatusType.upcoming:
        return ColorManager.warningBackground;
      case StatusType.error:
      case StatusType.inactive:
        return ColorManager.errorBackground;
      case StatusType.info:
      case StatusType.inProgress:
        return ColorManager.infoBackground;
    }
  }

  Color _getBorderColor() {
    switch (type) {
      case StatusType.success:
      case StatusType.completed:
      case StatusType.active:
        return ColorManager.successBorder;
      case StatusType.warning:
      case StatusType.pending:
      case StatusType.upcoming:
        return ColorManager.warningBorder;
      case StatusType.error:
      case StatusType.inactive:
        return ColorManager.errorBorder;
      case StatusType.info:
      case StatusType.inProgress:
        return ColorManager.infoBorder;
    }
  }

  Color _getTextColor() {
    switch (type) {
      case StatusType.success:
      case StatusType.completed:
      case StatusType.active:
        return ColorManager.success;
      case StatusType.warning:
      case StatusType.pending:
      case StatusType.upcoming:
        return ColorManager.warning;
      case StatusType.error:
      case StatusType.inactive:
        return ColorManager.error;
      case StatusType.info:
      case StatusType.inProgress:
        return ColorManager.info;
    }
  }
}

/// Small dot indicator for simple status display
class StatusDot extends StatelessWidget {
  const StatusDot({
    super.key,
    required this.type,
    this.size,
  });

  final StatusType type;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 8.w,
      height: size ?? 8.h,
      decoration: BoxDecoration(
        color: _getColor(),
        shape: BoxShape.circle,
      ),
    );
  }

  Color _getColor() {
    switch (type) {
      case StatusType.success:
      case StatusType.completed:
      case StatusType.active:
        return ColorManager.success;
      case StatusType.warning:
      case StatusType.pending:
      case StatusType.upcoming:
        return ColorManager.warning;
      case StatusType.error:
      case StatusType.inactive:
        return ColorManager.error;
      case StatusType.info:
      case StatusType.inProgress:
        return ColorManager.info;
    }
  }
}
