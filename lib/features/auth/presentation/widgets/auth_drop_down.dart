import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthDropdownField extends StatelessWidget {
  const AuthDropdownField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    this.prefixIcon,
    this.onChanged,
    this.validator,
  });

  final String label;
  final String hint;
  final String? value;
  final List<String> items;
  final IconData? prefixIcon;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label
        Text(
          label,
          style: TextStyle(
            color: ColorManager.textPrimary,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamily.geist,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 8.h),

        /// Dropdown
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          validator: validator,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: ColorManager.textTertiary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: ColorManager.textTertiary,
              fontFamily: FontFamily.geist,
              fontSize: 12.sp,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: ColorManager.textTertiary,
                    size: 20.w,
                  )
                : null,
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
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontFamily: FontFamily.geist,
                      fontSize: 14.sp,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                ),
              )
              .toList(),
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
