import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';

/// Dashboard statistics grid showing key metrics
class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: StatCard(
              icon: Icons.groups_outlined,
              gradientColors: const [Color(0xFF70B2B2), Color(0xFF5A9999)],
              value: '248', title: 'Total Patients',
              change: '+12', changeLabel: 'this month', showTrendIcon: true,
            )),
            SizedBox(width: 12.w),
            Expanded(child: StatCard(
              icon: Icons.calendar_today_outlined,
              gradientColors: const [Color(0xFF8BC9C9), Color(0xFF70B2B2)],
              value: '8', title: "Today's Visits",
              change: '3', changeLabel: 'completed', showTrendIcon: false,
            )),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(child: StatCard(
              icon: Icons.attach_money,
              gradientColors: const [Color(0xFF70B2B2), Color(0xFF5A9999)],
              value: '\$12,450', title: 'Monthly Revenue',
              change: '+8.2%', changeLabel: 'from last month', showTrendIcon: true,
            )),
            SizedBox(width: 12.w),
            Expanded(child: StatCard(
              icon: Icons.trending_up,
              gradientColors: const [Color(0xFF8BC9C9), Color(0xFF70B2B2)],
              value: '\$2,340', title: 'Pending Payments',
              change: '12', changeLabel: 'patients', showTrendIcon: false,
            )),
          ],
        ),
      ],
    );
  }
}

/// Individual stat card widget
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.icon,
    required this.gradientColors,
    required this.value,
    required this.title,
    required this.change,
    required this.changeLabel,
    this.showTrendIcon = false,
  });

  final IconData icon;
  final List<Color> gradientColors;
  final String value;
  final String title;
  final String change;
  final String changeLabel;
  final bool showTrendIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: ColorManager.black.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48.w, height: 48.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: gradientColors),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [BoxShadow(color: gradientColors[0].withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4))],
                ),
                child: Icon(icon, color: ColorManager.white, size: 24.w),
              ),
              if (showTrendIcon) Icon(Icons.arrow_outward, color: const Color(0xFF22C55E), size: 16.w),
            ],
          ),
          SizedBox(height: 12.h),
          Text(value, style: TextStyleManager.headlineSmall.copyWith(color: ColorManager.textPrimary, fontWeight: FontWeight.bold)),
          SizedBox(height: 4.h),
          Text(title, style: TextStyleManager.labelSmall.copyWith(color: ColorManager.textTertiary)),
          SizedBox(height: 4.h),
          Row(
            children: [
              Text(change, style: TextStyleManager.labelSmall.copyWith(color: showTrendIcon ? const Color(0xFF16A34A) : ColorManager.textSecondary, fontWeight: FontWeight.w600)),
              SizedBox(width: 4.w),
              Expanded(child: Text(changeLabel, style: TextStyleManager.labelSmall.copyWith(color: ColorManager.textTertiary), overflow: TextOverflow.ellipsis)),
            ],
          ),
        ],
      ),
    );
  }
}
