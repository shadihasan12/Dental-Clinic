import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({
    super.key,
    required this.onAddPatient,
    required this.onScheduleVisit,
    required this.onNewCase,
    required this.onRecordPayment,
  });

  final VoidCallback onAddPatient;
  final VoidCallback onScheduleVisit;
  final VoidCallback onNewCase;
  final VoidCallback onRecordPayment;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        _ActionItem(
          icon: Icons.person_add_outlined,
          label: localizations.patient,
          onTap: onAddPatient,
        ),
        SizedBox(width: 12.w),
        _ActionItem(
          icon: Icons.calendar_month_outlined,
          label: localizations.appointment,
          onTap: onScheduleVisit,
        ),
        SizedBox(width: 12.w),
        _ActionItem(
          icon: Icons.attach_money,
          label: localizations.payment,
          onTap: onRecordPayment,
        ),
      ],
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: ColorManager.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Icon(icon, color: ColorManager.primary, size: 22.w),
              SizedBox(height: 6.h),
              Text(
                label,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: c.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}