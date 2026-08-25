import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';

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
    final c = ColorManager.of(context);
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
      style: TextStyle(
        fontSize: 13.sp,
        fontFamily: FontHelper.fontFamily(context),
        color: c.textPrimary,
      ),
      decoration:
          formOutlinedInput(
            context,
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            fillColor: fillColor,
          ).copyWith(
            labelText: labelText,
            labelStyle: TextStyle(
              color: c.textSecondary,
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 13.sp,
            ),
            // Null keeps the shared padding; a call site can still override it.
            contentPadding: contentPadding,
          ),
    );
  }
}
