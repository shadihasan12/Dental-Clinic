import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Editable text field row
class ProfileTextField extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool isLast;
  final bool enabled;
  final Widget? suffixWidget;
  final TextDirection? textDirection;

  const ProfileTextField({
    super.key,
    required this.icon,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.isLast = false,
    this.enabled = true,
    this.suffixWidget,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final field = AuthTextField(
      label: label,
      hint: 'Enter $label',
      controller: controller,
      prefixIcon: icon,
      keyboardType: keyboardType,
      enabled: enabled,
      suffixIcon: !enabled && suffixWidget != null ? null : suffixWidget,
      textDirection: textDirection,
      onChanged: (value) {},
    );

    return Container(
      decoration: isLast
          ? null
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(color: c.borderLight, width: 1),
              ),
            ),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: !enabled && suffixWidget != null
          ? Stack(
              children: [
                field,
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  end: 0,
                  bottom: 0,
                  top: 20.h,
                  child: Center(child: suffixWidget!),
                ),
              ],
            )
          : field,
    );
  }
}
