import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';

/// Custom text field widget matching the design system
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.fillColor,
    this.contentPadding,
    this.borderRadius,
    this.textDirection,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius? borderRadius;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: textDirection,
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      style: TextStyleManager.bodyLarge.copyWith(
        color: ColorManager.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor ?? ColorManager.gray50,
        hintStyle: TextStyle(
          color: ColorManager.textHint,
          fontFamily: FontHelper.fontFamily(context),
          fontSize: 12.sp
        ),
        labelStyle: TextStyle(
          color: ColorManager.textSecondary,
          fontFamily: FontHelper.fontFamily(context),
        ),
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        border: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadiusManager.xl,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadiusManager.xl,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadiusManager.xl,
          borderSide: const BorderSide(color: ColorManager.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadiusManager.xl,
          borderSide: const BorderSide(color: ColorManager.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadiusManager.xl,
          borderSide: const BorderSide(color: ColorManager.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadiusManager.xl,
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
