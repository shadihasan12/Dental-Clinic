import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';


class PatientInfoTab extends StatefulWidget {
  final String phone;
  final String email;
  final String address;
  final String medicalHistory;
  final String dateOfBirth;
  final bool initiallyExpanded;

  const PatientInfoTab({
    super.key,
    required this.phone,
    required this.email,
    required this.address,
    required this.medicalHistory,
    required this.dateOfBirth,
    this.initiallyExpanded = false,
  });

  @override
  State<PatientInfoTab> createState() => _PatientInfoTabState();
}

class _PatientInfoTabState extends State<PatientInfoTab>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header - Always visible, tappable
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Patient Information',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: FontFamily.geist,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.textPrimary,
                ),
              ),
            ],
          ),

          // Expandable content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              InfoRow(icon: Icons.phone_outlined, text: widget.phone),
              SizedBox(height: 12.h),
              if (widget.email.isNotEmpty) ...[
                InfoRow(icon: Icons.email_outlined, text: widget.email),
                SizedBox(height: 12.h),
              ],
              if (widget.address.isNotEmpty) ...[
                InfoRow(icon: Icons.location_on_outlined, text: widget.address),
                SizedBox(height: 12.h),
              ],
              InfoRow(icon: Icons.calendar_month_outlined, text: widget.dateOfBirth),
              SizedBox(height: 12.h),
              Divider(color: ColorManager.borderLight),
              SizedBox(height: 12.h),
              // Medical History
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medical History',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: FontFamily.geist,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    widget.medicalHistory,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: FontFamily.geist,
                      fontWeight: FontWeight.w400,
                      color: ColorManager.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({super.key, required this.icon, required this.text});

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