import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:dental_clinic_app/core/utils/input_formatters.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';

/// Reusable form field with label, used across multiple pages.
///
/// Wears the shared form-kit surface - [FormFieldShell] for the label and
/// [formInputDecoration] for the 12r hairline that thickens to 1.5px in the
/// brand hue on focus - so it is indistinguishable from [FormTextField].
class AppFormField extends StatefulWidget {
  const AppFormField({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.maxLines = 1,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.enabled = true,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  /// Kept for call-site compatibility. This field is a [TextField], not a
  /// [TextFormField], so nothing runs it - the pages that pass one validate
  /// their own state before submitting.
  final String? Function(String?)? validator;

  final ValueChanged<String>? onChanged;
  final bool? enabled;

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return FormFieldShell(
      label: widget.label,
      child: Container(
        decoration: formInputDecoration(
          context,
          focused: _focusNode.hasFocus,
          hasError: false,
        ),
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          inputFormatters: formattersForKeyboard(widget.keyboardType),
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          obscureText: widget.obscureText,
          onChanged: widget.onChanged,
          enabled: widget.enabled,
          style: TextStyle(
            fontSize: 13.sp,
            fontFamily: family,
            color: c.textPrimary,
          ),
          decoration: bareInputDecoration().copyWith(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 13.sp,
              fontFamily: family,
              color: c.textTertiary,
            ),
            prefixIcon: widget.prefixIcon,
            prefixIconConstraints: BoxConstraints(minWidth: 38.w, minHeight: 0),
            suffixIcon: widget.suffixIcon,
            suffixIconConstraints: BoxConstraints(minWidth: 36.w, minHeight: 0),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
          ),
        ),
      ),
    );
  }
}

/// Reusable date picker field with label
class AppDateField extends StatelessWidget {
  const AppDateField({
    super.key,
    required this.label,
    this.value,
    required this.onTap,
    this.placeholder = '01/08/1992',
  });

  final String label;
  final DateTime? value;
  final VoidCallback onTap;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontHelper.fontFamily(context),
            color: c.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: c.inputBg,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value != null ? _formatDate(value!) : placeholder,
                  style: TextStyle(
                    color: value != null ? c.textPrimary : c.textTertiary,
                    fontSize: 14.sp,
                    fontFamily: FontHelper.fontFamily(context),
                  ),
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  color: c.textTertiary,
                  size: 20.w,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}

/// Reusable dropdown field with label
class AppDropdownField extends StatelessWidget {
  const AppDropdownField({
    super.key,
    required this.label,
    this.value,
    required this.items,
    required this.onChanged,
    this.hint = 'Select an option',
  });

  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontHelper.fontFamily(context),
            color: c.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: c.inputBg,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Text(
                hint,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: c.textTertiary,
                ),
              ),
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: c.textTertiary),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      color: c.textPrimary,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
