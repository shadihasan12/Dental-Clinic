import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

/// Row with Google and Facebook login buttons
class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({
    super.key,
    required this.onGooglePressed,
    required this.onFacebookPressed,
  });

  final VoidCallback onGooglePressed;
  final VoidCallback onFacebookPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SocialButton(
            icon: 'G',
            label: 'Google',
            isGoogle: true,
            onPressed: onGooglePressed,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: SocialButton(
            icon: 'f',
            label: 'Facebook',
            isGoogle: false,
            onPressed: onFacebookPressed,
          ),
        ),
      ],
    );
  }
}

/// Individual social login button
class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isGoogle,
    required this.onPressed,
  });

  final String icon;
  final String label;
  final bool isGoogle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        side: BorderSide(color: ColorManager.gray200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              color: ColorManager.textPrimary,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.geist,
              fontSize: 12.sp
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    if (isGoogle) {
      return Text(
        'G',
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      );
    }
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: const BoxDecoration(
        color: Color(0xFF1877F2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          'f',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.white,
          ),
        ),
      ),
    );
  }
}
