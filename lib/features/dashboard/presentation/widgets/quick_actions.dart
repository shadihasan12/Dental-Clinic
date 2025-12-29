import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';

/// Quick actions grid with shortcuts to common tasks
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
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: ColorManager.black.withValues(alpha: 0.06), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Actions', style: TextStyleManager.titleMedium.copyWith(color: ColorManager.textPrimary, fontWeight: FontWeight.w600)),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ActionItem(icon: Icons.person_add_outlined, label: 'Add\nPatient', color: const Color(0xFF70B2B2), onTap: onAddPatient),
              ActionItem(icon: Icons.calendar_month_outlined, label: 'Schedule\nVisit', color: const Color(0xFF8BC9C9), onTap: onScheduleVisit),
              ActionItem(icon: Icons.description_outlined, label: 'New\nCase', color: const Color(0xFF70B2B2), onTap: onNewCase),
              ActionItem(icon: Icons.attach_money, label: 'Record\nPayment', color: const Color(0xFF8BC9C9), onTap: onRecordPayment),
            ],
          ),
        ],
      ),
    );
  }
}

/// Individual action button in quick actions grid
class ActionItem extends StatelessWidget {
  const ActionItem({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 70.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4))],
              ),
              child: Icon(icon, color: ColorManager.white, size: 24.w),
            ),
            SizedBox(height: 8.h),
            Text(label, style: TextStyleManager.labelSmall.copyWith(color: ColorManager.textSecondary, height: 1.3), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
