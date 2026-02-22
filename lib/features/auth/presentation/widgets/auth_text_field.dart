import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

/// Styled text field for auth pages with label, validation, and optional suffix
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: ColorManager.textPrimary,
            fontWeight: FontWeight.w500,
            fontFamily: FontHelper.fontFamily(context),
            fontSize: 12.sp
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          style: TextStyle(
            color: ColorManager.textPrimary,
            fontFamily: FontHelper.fontFamily(context),
            fontSize: 14.sp
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: ColorManager.textTertiary,
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 12.sp
            ),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: ColorManager.textTertiary, size: 20.w)
                : null,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: ColorManager.gray50,
            border: _buildBorder(BorderSide.none),
            enabledBorder: _buildBorder(BorderSide.none),
            focusedBorder: _buildBorder(
              const BorderSide(color: ColorManager.primary, width: 1.5),
            ),
            errorBorder: _buildBorder(
              const BorderSide(color: ColorManager.error, width: 1),
            ),
            focusedErrorBorder: _buildBorder(
              const BorderSide(color: ColorManager.error, width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(BorderSide side) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: side,
    );
  }
}
