import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/core/resources/resources.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

class AppointmentData {
  final String initials;
  final String name;
  final String treatment;
  final String time;
  final String status;
  final Color statusColor;

  const AppointmentData({
    required this.initials,
    required this.name,
    required this.treatment,
    required this.time,
    required this.status,
    required this.statusColor,
  });
}

class TodaysSchedule extends StatelessWidget {
  const TodaysSchedule({super.key, this.onViewAllTap});

  final VoidCallback? onViewAllTap;

  List<AppointmentData> get _appointments => const [
        AppointmentData(
          initials: 'SJ',
          name: 'Sarah Johnson',
          treatment: 'Cleaning',
          time: '09:00 AM',
          status: 'Done',
          statusColor: Color(0xFF22C55E),
        ),
        AppointmentData(
          initials: 'MC',
          name: 'Michael Chen',
          treatment: 'Root Canal',
          time: '10:30 AM',
          status: 'Done',
          statusColor: Color(0xFF22C55E),
        ),
        AppointmentData(
          initials: 'ED',
          name: 'Emily Davis',
          treatment: 'Check-up',
          time: '11:45 AM',
          status: 'Now',
          statusColor: Color(0xFF3B82F6),
        ),
        AppointmentData(
          initials: 'JW',
          name: 'James Wilson',
          treatment: 'Filling',
          time: '02:00 PM',
          status: 'Next',
          statusColor: Color(0xFFF97316),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localizations.todaysSchedule,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            GestureDetector(
              onTap: onViewAllTap,
              child: Text(
                localizations.viewAll,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // Appointments list
        ..._appointments.asMap().entries.map((entry) {
          final data = entry.value;
          final isLast = entry.key == _appointments.length - 1;
          return Column(
            children: [
              _AppointmentRow(data: data),
              if (!isLast) Divider(height: 1, color: Colors.grey.shade100),
            ],
          );
        }),
      ],
    );
  }
}

class _AppointmentRow extends StatelessWidget {
  const _AppointmentRow({required this.data});

  final AppointmentData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          // Time
          SizedBox(
            width: 65.w,
            child: Text(
              data.time,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black45,
              ),
            ),
          ),

          
          SizedBox(width: 10.w),

          // Name + treatment
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  data.treatment,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 12.sp,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),

          // Status badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: data.statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              data.status,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: data.statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}