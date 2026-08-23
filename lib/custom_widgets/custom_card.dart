import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/padding_manager.dart';

/// Card surface. Elevation is a 1px hairline, not a shadow - pass [shadow]
/// explicitly on the rare surface that still wants one.
class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius,
    this.border,
    this.shadow,
    this.onTap,
    this.width,
    this.height,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? shadow;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? ColorManager.of(context).cardBg,
        borderRadius: borderRadius ?? BorderRadius.circular(16.r),
        border: border ??
            Border.all(color: ColorManager.of(context).borderLight),
        boxShadow: shadow,
      ),
      child: Material(
        color: ColorManager.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(16.r),
          child: Padding(
            padding: padding ?? PaddingManager.cardPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Stats card for dashboard metrics
class StatsCard extends StatelessWidget {
  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.iconBackgroundColor,
    this.trend,
    this.trendValue,
    this.onTap,
  });

  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final TrendDirection? trend;
  final String? trendValue;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (icon != null)
                Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: iconBackgroundColor ?? ColorManager.primary10,
                    borderRadius: BorderRadiusManager.lg,
                  ),
                  child: Icon(
                    icon,
                    size: 24.w,
                    color: iconColor ?? ColorManager.primary,
                  ),
                ),
              if (trend != null && trendValue != null)
                _buildTrendIndicator(),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: ColorManager.of(context).textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: ColorManager.of(context).textSecondary,
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: 2.h),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 12.sp,
                color: ColorManager.of(context).textTertiary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTrendIndicator() {
    final isPositive = trend == TrendDirection.up;
    final color = isPositive ? ColorManager.success : ColorManager.error;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadiusManager.full,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.trending_up : Icons.trending_down,
            size: 14.w,
            color: color,
          ),
          SizedBox(width: 2.w),
          Text(
            trendValue!,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

enum TrendDirection { up, down }
