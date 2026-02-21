import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

/// Data model for patient display
class Patient {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String phone;
  final String? nextVisit;
  final double balance;

  const Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    this.nextVisit,
    required this.balance,
  });

  String get initials => name.split(' ').map((e) => e[0]).take(2).join();
}

/// Card widget displaying patient information
class PatientCard extends StatelessWidget {
  const PatientCard({super.key, required this.patient, required this.onTap});

  final Patient patient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildMainRow(),
            if (patient.balance > 0 || patient.nextVisit != null) ...[
              SizedBox(height: 12.h),
              _buildExtraInfo(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMainRow() {
    return Row(
      children: [
        _buildAvatar(),
        SizedBox(width: 12.w),
        Expanded(child: _buildPatientInfo()),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          patient.initials,
          style: TextStyle(
            color: ColorManager.primary,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            fontFamily: FontFamily.geist,
          ),
        ),
      ),
    );
  }

  Widget _buildPatientInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          patient.name,
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: FontFamily.geist,
            color: ColorManager.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          '${patient.age} years • ${patient.gender}',
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontFamily.geist,
            color: ColorManager.textSecondary,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Icon(
              Icons.phone_outlined,
              size: 14.w,
              color: ColorManager.textTertiary,
            ),
            SizedBox(width: 4.w),
            Text(
              patient.phone,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: FontFamily.geist,
                color: ColorManager.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExtraInfo() {
    return Column(
      children: [
        if (patient.balance > 0)
          Row(
            children: [
              Text(
                'Outstanding balance: ',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontFamily.geist,
                  color: ColorManager.textSecondary,
                ),
              ),
              Text(
                '\$${patient.balance.toInt()}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontFamily.geist,
                  color: ColorManager.warning,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        if (patient.nextVisit != null) ...[
          if (patient.balance > 0) SizedBox(height: 4.h),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 14.w,
                color: ColorManager.primary,
              ),
              SizedBox(width: 4.w),
              Text(
                'Next visit: ${patient.nextVisit}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontFamily.geist,
                  color: ColorManager.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
