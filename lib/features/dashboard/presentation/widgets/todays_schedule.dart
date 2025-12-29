import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';

/// Data model for appointment display
class AppointmentData {
  final String initials;
  final String name;
  final String treatment;
  final String time;
  final String status;
  final Color statusColor;
  final Color statusBgColor;

  const AppointmentData({
    required this.initials,
    required this.name,
    required this.treatment,
    required this.time,
    required this.status,
    required this.statusColor,
    required this.statusBgColor,
  });
}

/// Today's schedule section showing appointment list
class TodaysSchedule extends StatelessWidget {
  const TodaysSchedule({super.key, this.onViewAllTap});

  final VoidCallback? onViewAllTap;

  // Sample data - in production, this would come from a bloc/provider
  List<AppointmentData> get _appointments => const [
    AppointmentData(initials: 'SJ', name: 'Sarah Johnson', treatment: 'Cleaning', time: '09:00 AM', status: 'Completed', statusColor: Color(0xFF22C55E), statusBgColor: Color(0xFFDCFCE7)),
    AppointmentData(initials: 'MC', name: 'Michael Chen', treatment: 'Root Canal', time: '10:30 AM', status: 'Completed', statusColor: Color(0xFF22C55E), statusBgColor: Color(0xFFDCFCE7)),
    AppointmentData(initials: 'ED', name: 'Emily Davis', treatment: 'Check-up', time: '11:45 AM', status: 'In Progress', statusColor: Color(0xFF3B82F6), statusBgColor: Color(0xFFDBEAFE)),
    AppointmentData(initials: 'JW', name: 'James Wilson', treatment: 'Filling', time: '02:00 PM', status: 'Upcoming', statusColor: Color(0xFFF97316), statusBgColor: Color(0xFFFFEDD5)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: ColorManager.black.withValues(alpha: 0.06), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 16.h),
          ..._appointments.asMap().entries.map((entry) {
            final isLast = entry.key == _appointments.length - 1;
            return AppointmentItem(data: entry.value, isLast: isLast);
          }),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Today's Schedule", style: TextStyleManager.titleMedium.copyWith(color: ColorManager.textPrimary, fontWeight: FontWeight.w600)),
        GestureDetector(
          onTap: onViewAllTap,
          child: Text('View All', style: TextStyleManager.bodySmall.copyWith(color: const Color(0xFF70B2B2), fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

/// Individual appointment item in the schedule
class AppointmentItem extends StatelessWidget {
  const AppointmentItem({super.key, required this.data, this.isLast = false});

  final AppointmentData data;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1),
      ),
      child: Row(
        children: [
          _buildAvatar(),
          SizedBox(width: 12.w),
          _buildPatientInfo(),
          _buildTimeAndStatus(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF70B2B2), Color(0xFF5A9999)]),
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: const Color(0xFF70B2B2).withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Center(child: Text(data.initials, style: TextStyleManager.titleSmall.copyWith(color: ColorManager.white, fontWeight: FontWeight.w600))),
    );
  }

  Widget _buildPatientInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.name, style: TextStyleManager.titleSmall.copyWith(color: ColorManager.textPrimary, fontWeight: FontWeight.w600)),
          SizedBox(height: 4.h),
          Text(data.treatment, style: TextStyleManager.bodySmall.copyWith(color: ColorManager.textTertiary)),
        ],
      ),
    );
  }

  Widget _buildTimeAndStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(data.time, style: TextStyleManager.bodySmall.copyWith(color: const Color(0xFF70B2B2), fontWeight: FontWeight.w600)),
        SizedBox(height: 4.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(color: data.statusBgColor, borderRadius: BorderRadius.circular(12.r)),
          child: Text(data.status, style: TextStyleManager.labelSmall.copyWith(color: data.statusColor, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}
