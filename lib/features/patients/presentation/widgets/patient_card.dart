import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
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
            _buildMainRow(context),
            if (patient.balance > 0 || patient.nextVisit != null) ...[
              SizedBox(height: 12.h),
              _buildExtraInfo(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMainRow(BuildContext context) {
    return Row(
      children: [
        _buildAvatar(context),
        SizedBox(width: 12.w),
        Expanded(child: _buildPatientInfo(context)),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context) {
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
            fontFamily: FontHelper.fontFamily(context),
          ),
        ),
      ),
    );
  }

  Widget _buildPatientInfo(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Get localized gender label
    final genderLabel = patient.gender.toLowerCase() == 'female' 
        ? l10n.female 
        : l10n.male;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          patient.name,
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: FontHelper.fontFamily(context),
            color: ColorManager.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          '${patient.age} ${l10n.years} • $genderLabel',
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: FontHelper.fontFamily(context),
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
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExtraInfo(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Column(
      children: [
        if (patient.balance > 0)
          Row(
            children: [
              Text(
                '${l10n.outstandingBalance}: ',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.textSecondary,
                ),
              ),
              Text(
                '\$${patient.balance.toInt()}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontHelper.fontFamily(context),
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
                '${l10n.nextVisit}: ${patient.nextVisit}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontHelper.fontFamily(context),
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
