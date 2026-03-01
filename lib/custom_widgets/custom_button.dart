import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gradient_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/shadow_manager.dart';

/// Primary gradient button matching the design system
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height,
    this.icon,
    this.iconPosition = IconPosition.left,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double? height;
  final Widget? icon;
  final IconPosition iconPosition;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 56.h,
        decoration: BoxDecoration(
          gradient: isEnabled ? GradientManager.primaryButton : null,
          color: isEnabled ? null : ColorManager.gray300,
          borderRadius: BorderRadiusManager.xl,
          boxShadow: isEnabled ? ShadowManager.shadowSm : null,
        ),
        child: Material(
          color: ColorManager.transparent,
          child: InkWell(
            onTap: isEnabled && !isLoading ? onPressed : null,
            borderRadius: BorderRadiusManager.xl,
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          ColorManager.white,
                        ),
                      ),
                    )
                  : _buildContent(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (icon == null) {
      return Text(
        text,
        style: TextStyle(
          color: isEnabled ? ColorManager.white : ColorManager.gray500,
          fontFamily: FontHelper.fontFamily(context),
          fontWeight: FontWeight.w600,
          fontSize: 14.sp
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconPosition == IconPosition.left) ...[icon!, SizedBox(width: 8.w)],
        Text(
          text,
          style: TextStyleManager.button.copyWith(
            color: isEnabled ? ColorManager.white : ColorManager.gray500,
          ),
        ),
        if (iconPosition == IconPosition.right) ...[
          SizedBox(width: 8.w),
          icon!,
        ],
      ],
    );
  }
}

/// Secondary outlined button
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.borderColor,
    this.textColor,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double? height;
  final Widget? icon;
  final IconPosition iconPosition;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = borderColor ?? ColorManager.primary;
    final effectiveTextColor = textColor ?? ColorManager.primary;

    return Container(
      width: width ?? double.infinity,
      height: height ?? 56.h,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadiusManager.xl,
        border: Border.all(
          color: isEnabled ? effectiveBorderColor : ColorManager.gray300,
          width: 1.5,
        ),
      ),
      child: Material(
        color: ColorManager.transparent,
        child: InkWell(
          onTap: isEnabled && !isLoading ? onPressed : null,
          borderRadius: BorderRadiusManager.xl,
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        effectiveTextColor,
                      ),
                    ),
                  )
                : _buildContent(effectiveTextColor),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(Color textColor) {
    if (icon == null) {
      return Text(
        text,
        style: TextStyleManager.button.copyWith(
          color: isEnabled ? textColor : ColorManager.gray400,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconPosition == IconPosition.left) ...[icon!, SizedBox(width: 8.w)],
        Text(
          text,
          style: TextStyleManager.button.copyWith(
            color: isEnabled ? textColor : ColorManager.gray400,
          ),
        ),
        if (iconPosition == IconPosition.right) ...[
          SizedBox(width: 8.w),
          icon!,
        ],
      ],
    );
  }
}

/// Text button for less prominent actions
class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.icon,
    this.iconPosition = IconPosition.left,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color? textColor;
  final Widget? icon;
  final IconPosition iconPosition;

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = textColor ?? ColorManager.primary;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: effectiveTextColor,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      ),
      child: icon == null
          ? Text(
              text,
              style: TextStyleManager.button.copyWith(
                color: effectiveTextColor,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (iconPosition == IconPosition.left) ...[
                  icon!,
                  SizedBox(width: 8.w),
                ],
                Text(
                  text,
                  style: TextStyleManager.button.copyWith(
                    color: effectiveTextColor,
                  ),
                ),
                if (iconPosition == IconPosition.right) ...[
                  SizedBox(width: 8.w),
                  icon!,
                ],
              ],
            ),
    );
  }
}

/// Icon button with gradient background
class GradientIconButton extends StatelessWidget {
  const GradientIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size,
    this.iconSize,
    this.gradient,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final double? size;
  final double? iconSize;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final effectiveSize = size ?? 48.w;
    final effectiveIconSize = iconSize ?? 24.w;

    return Container(
      width: effectiveSize,
      height: effectiveSize,
      decoration: BoxDecoration(
        gradient: gradient ?? GradientManager.iconGradient1,
        borderRadius: BorderRadiusManager.lg,
        boxShadow: ShadowManager.shadowSm,
      ),
      child: Material(
        color: ColorManager.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadiusManager.lg,
          child: Center(
            child: Icon(
              icon,
              size: effectiveIconSize,
              color: ColorManager.white,
            ),
          ),
        ),
      ),
    );
  }
}

enum IconPosition { left, right }
