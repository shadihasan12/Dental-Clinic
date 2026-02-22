import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
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

  const ProfileTextField({
    super.key,
    required this.icon,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isLast
          ? null
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColorManager.borderLight, width: 1),
              ),
            ),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: AuthTextField(
        label: label,
        hint: 'Enter $label',
        controller: controller,
        prefixIcon: icon,
        keyboardType: keyboardType,
        onChanged: (value) {},
      ),
    );
  }
}
