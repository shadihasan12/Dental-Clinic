import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/padding_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          'Statistics',
          style: TextStyleManager.headlineMedium.copyWith(
            color: ColorManager.textPrimary,
          ),
        ),
        backgroundColor: ColorManager.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: PaddingManager.all16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Overview
            _buildStatsOverview(),
            SizedBox(height: 24.h),

            // Revenue Chart Placeholder
            _buildChartCard(
              title: 'Revenue Trend',
              subtitle: 'Last 6 months',
              child: _buildRevenueChart(),
            ),
            SizedBox(height: 24.h),

            // Treatment Distribution
            _buildChartCard(
              title: 'Treatment Distribution',
              subtitle: 'This month',
              child: _buildTreatmentDistribution(),
            ),
            SizedBox(height: 24.h),

            // Weekly Visits
            _buildChartCard(
              title: 'Weekly Visits',
              subtitle: 'This week',
              child: _buildWeeklyVisits(),
            ),
            SizedBox(height: 24.h),

            // Top Treatments
            _buildTopTreatments(),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsOverview() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      childAspectRatio: 1.4,
      children: [
        _buildStatCard(
          title: 'Revenue',
          value: '\$45,280',
          trend: '+12.5%',
          isPositive: true,
          icon: Icons.attach_money,
          color: ColorManager.success,
        ),
        _buildStatCard(
          title: 'Patients',
          value: '248',
          trend: '+8.2%',
          isPositive: true,
          icon: Icons.people_outline,
          color: ColorManager.primary,
        ),
        _buildStatCard(
          title: 'Daily Visits',
          value: '12.4',
          trend: '-2.1%',
          isPositive: false,
          icon: Icons.calendar_today,
          color: ColorManager.info,
        ),
        _buildStatCard(
          title: 'Success Rate',
          value: '98.5%',
          trend: '+0.5%',
          isPositive: true,
          icon: Icons.check_circle_outline,
          color: ColorManager.purple,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String trend,
    required bool isPositive,
    required IconData icon,
    required Color color,
  }) {
    return CustomCard(
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadiusManager.md,
                ),
                child: Icon(icon, size: 20.w, color: color),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: (isPositive ? ColorManager.success : ColorManager.error)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadiusManager.full,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      size: 12.w,
                      color: isPositive ? ColorManager.success : ColorManager.error,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      trend,
                      style: TextStyleManager.labelSmall.copyWith(
                        color:
                            isPositive ? ColorManager.success : ColorManager.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyleManager.headlineMedium.copyWith(
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            title,
            style: TextStyleManager.bodySmall.copyWith(
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyleManager.titleMedium.copyWith(
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyleManager.bodySmall.copyWith(
                      color: ColorManager.textSecondary,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {},
                color: ColorManager.textSecondary,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
    // Placeholder for actual chart implementation
    return Container(
      height: 180.h,
      decoration: BoxDecoration(
        color: ColorManager.gray50,
        borderRadius: BorderRadiusManager.lg,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.show_chart,
              size: 48.w,
              color: ColorManager.primary.withValues(alpha: 0.5),
            ),
            SizedBox(height: 8.h),
            Text(
              'Revenue Chart',
              style: TextStyleManager.bodyMedium.copyWith(
                color: ColorManager.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTreatmentDistribution() {
    final treatments = [
      {'name': 'Cleaning', 'percentage': 35, 'color': ColorManager.primary},
      {'name': 'Filling', 'percentage': 25, 'color': ColorManager.info},
      {'name': 'Root Canal', 'percentage': 20, 'color': ColorManager.warning},
      {'name': 'Extraction', 'percentage': 12, 'color': ColorManager.error},
      {'name': 'Other', 'percentage': 8, 'color': ColorManager.purple},
    ];

    return Column(
      children: treatments.map((treatment) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Row(
            children: [
              Container(
                width: 12.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: treatment['color'] as Color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  treatment['name'] as String,
                  style: TextStyleManager.bodyMedium.copyWith(
                    color: ColorManager.textPrimary,
                  ),
                ),
              ),
              Text(
                '${treatment['percentage']}%',
                style: TextStyleManager.titleSmall.copyWith(
                  color: ColorManager.textPrimary,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadiusManager.full,
                  child: LinearProgressIndicator(
                    value: (treatment['percentage'] as int) / 100,
                    backgroundColor: ColorManager.gray200,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      treatment['color'] as Color,
                    ),
                    minHeight: 8.h,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildWeeklyVisits() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final values = [12, 15, 10, 18, 14, 8, 5];
    final maxValue = values.reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 140.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(days.length, (index) {
          final heightRatio = values[index] / maxValue;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    values[index].toString(),
                    style: TextStyleManager.labelSmall.copyWith(
                      color: ColorManager.textSecondary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    height: (100 * heightRatio).h,
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.r),
                        topRight: Radius.circular(4.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    days[index],
                    style: TextStyleManager.labelSmall.copyWith(
                      color: ColorManager.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTopTreatments() {
    final treatments = [
      {'name': 'Teeth Cleaning', 'count': 145, 'revenue': '\$4,350'},
      {'name': 'Cavity Filling', 'count': 98, 'revenue': '\$7,840'},
      {'name': 'Root Canal', 'count': 42, 'revenue': '\$12,600'},
      {'name': 'Teeth Whitening', 'count': 67, 'revenue': '\$5,360'},
      {'name': 'Dental Crown', 'count': 23, 'revenue': '\$9,200'},
    ];

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Treatments',
            style: TextStyleManager.titleMedium.copyWith(
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          ...treatments.asMap().entries.map((entry) {
            final index = entry.key;
            final treatment = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: index < treatments.length - 1 ? 12.h : 0),
              child: Row(
                children: [
                  Container(
                    width: 28.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      color: ColorManager.gray100,
                      borderRadius: BorderRadiusManager.md,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyleManager.labelMedium.copyWith(
                          color: ColorManager.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          treatment['name'] as String,
                          style: TextStyleManager.bodyMedium.copyWith(
                            color: ColorManager.textPrimary,
                          ),
                        ),
                        Text(
                          '${treatment['count']} procedures',
                          style: TextStyleManager.bodySmall.copyWith(
                            color: ColorManager.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    treatment['revenue'] as String,
                    style: TextStyleManager.titleSmall.copyWith(
                      color: ColorManager.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
