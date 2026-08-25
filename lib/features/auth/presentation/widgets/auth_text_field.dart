import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Text field for the auth pages.
///
/// Wears the shared form-kit shell - same 12r radius, hairline, focus and
/// error hues, label scale and type size as every field on Add Patient - so
/// signing up and adding a record feel like the same product. It keeps
/// [TextFormField] because the auth pages validate through a [Form].
class AuthTextField extends StatefulWidget {
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
    this.enabled = true,
    this.textDirection,
    this.required = false,
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
  final bool enabled;
  final TextDirection? textDirection;
  final bool required;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
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
      required: widget.required,
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        validator: widget.validator,
        onChanged: widget.onChanged,
        enabled: widget.enabled,
        textDirection: widget.textDirection,
        style: TextStyle(
          color: c.textPrimary,
          fontFamily: family,
          fontSize: 13.sp,
        ),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: c.textTertiary,
            fontFamily: family,
            fontSize: 13.sp,
          ),
          errorStyle: TextStyle(
            fontSize: 11.sp,
            height: 1.3,
            fontFamily: family,
            color: ColorManager.error,
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, color: c.textTertiary, size: 18.w)
              : null,
          prefixIconConstraints: BoxConstraints(
            minWidth: 38.w,
            minHeight: 0,
          ),
          // Use `suffixIcon` (not `suffix`) so the widget sits in its own
          // slot, and tighten `suffixIconConstraints` so the default 48 dp
          // `kMinInteractiveDimension` doesn't inflate the row past the
          // height of fields without a suffix.
          suffixIcon: widget.suffixIcon,
          suffixIconConstraints: BoxConstraints(
            minWidth: 36.w,
            minHeight: 0,
          ),
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
