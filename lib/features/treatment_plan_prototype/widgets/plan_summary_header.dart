import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/prototype_models.dart';

class PlanSummaryHeader extends StatelessWidget {
  final TreatmentPlan plan;

  const PlanSummaryHeader({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    final total = plan.treatments.length;
    final done = plan.completed.length;
    final progress = total > 0 ? done / total : 0.0;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorManager.primary,
            ColorManager.primaryDark,
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          // Patient name + progress
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    plan.patientName.isNotEmpty
                        ? plan.patientName[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
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
                      plan.patientName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '$done of $total treatments completed',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 6.h,
            ),
          ),
          SizedBox(height: 16.h),

          // Stats row
          Row(
            children: [
              _buildStat(
                context,
                icon: Icons.assignment_outlined,
                value: '$total',
                label: 'Total',
              ),
              _divider(),
              _buildStat(
                context,
                icon: Icons.check_circle_outline,
                value: '$done',
                label: 'Done',
              ),
              _divider(),
              _buildStat(
                context,
                icon: Icons.schedule,
                value: '${plan.planned.length}',
                label: 'Remaining',
              ),
              _divider(),
              _buildStat(
                context,
                icon: Icons.attach_money,
                value: '\$${plan.totalCost.toStringAsFixed(0)}',
                label: 'Total Cost',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 18.w, color: Colors.white.withValues(alpha: 0.8)),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              fontFamily: FontHelper.fontFamily(context),
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 36.h,
      color: Colors.white.withValues(alpha: 0.2),
    );
  }
}
