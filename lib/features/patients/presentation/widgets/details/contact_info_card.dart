import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

class ContactInfoCard extends StatelessWidget {
  final String phone;
  final String email;
  final String address;

  const ContactInfoCard({
    super.key,
    required this.phone,
    required this.email,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w500,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          ContactRow(icon: Icons.phone_outlined, text: phone),
          SizedBox(height: 12.h),
          ContactRow(icon: Icons.email_outlined, text: email),
          SizedBox(height: 12.h),
          ContactRow(icon: Icons.location_on_outlined, text: address),
        ],
      ),
    );
  }
}

class ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const ContactRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: ColorManager.borderLight,
            borderRadius: BorderRadiusManager.full,
          ),
          child: Icon(icon, size: 20.w, color: ColorManager.darkGrey),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w400,
              color: ColorManager.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}