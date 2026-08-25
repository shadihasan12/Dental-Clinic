import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Dropdown for the auth pages, on the same shell as [AuthTextField].
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
    this.required = false,
  });

  final String label;
  final String hint;
  final String? value;
  final List<String> items;
  final IconData? prefixIcon;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final textStyle = TextStyle(
      color: c.textPrimary,
      fontFamily: family,
      fontSize: 13.sp,
    );

    return FormFieldShell(
      label: label,
      required: required,
      child: DropdownButtonFormField<String>(
        initialValue: value,
        onChanged: onChanged,
        validator: validator,
        isDense: true,
        borderRadius: BorderRadius.circular(12.r),
        dropdownColor: c.cardBg,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 18.w,
          color: c.textTertiary,
        ),
        style: textStyle,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: textStyle.copyWith(color: c.textTertiary),
          errorStyle: TextStyle(
            fontSize: 11.sp,
            height: 1.3,
            fontFamily: family,
            color: ColorManager.error,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: c.textTertiary, size: 18.w)
              : null,
          prefixIconConstraints: BoxConstraints(minWidth: 38.w, minHeight: 0),
          filled: true,
          fillColor: c.inputBg,
          isDense: true,
          border: _border(BorderSide(color: c.borderLight)),
          enabledBorder: _border(BorderSide(color: c.borderLight)),
          disabledBorder: _border(BorderSide(color: c.borderLight)),
          focusedBorder: _border(
            const BorderSide(color: ColorManager.primary, width: 1.5),
          ),
          errorBorder: _border(
            const BorderSide(color: ColorManager.error, width: 1.5),
          ),
          focusedErrorBorder: _border(
            const BorderSide(color: ColorManager.error, width: 1.5),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  OutlineInputBorder _border(BorderSide side) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: side,
    );
  }
}
