import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/prototype_models.dart';

class PlanSummaryHeader extends StatelessWidget {
  final TreatmentPlan plan;
  final bool isInitial;
  final VoidCallback? onTap;

  const PlanSummaryHeader({
    super.key,
    required this.plan,
    this.isInitial = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final total = plan.treatments.length;
    final done = plan.completed.length;

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            // Patient name row
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
                        isInitial
                            ? '$total treatments added'
                            : '$done of $total treatments completed',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                if (onTap != null)
                  Icon(
                    Icons.edit_outlined,
                    size: 18.w,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
              ],
            ),
            SizedBox(height: 16.h),

            if (isInitial) _buildInitialStats(context) else _buildSavedStats(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialStats(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _costItem(
              context,
              label: 'Total Cost',
              value: plan.totalCost > 0
                  ? plan.totalCost.toStringAsFixed(0)
                  : '—',
            ),
          ),
          Container(
            width: 1,
            height: 32.h,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          Expanded(
            child: _costItem(
              context,
              label: 'Lab Fees',
              value: plan.labFees > 0
                  ? plan.labFees.toStringAsFixed(0)
                  : '—',
            ),
          ),
        ],
      ),
    );
  }

  Widget _costItem(BuildContext context,
      {required String label, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontFamily: FontHelper.fontFamily(context),
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildSavedStats(BuildContext context) {
    final total = plan.treatments.length;
    final done = plan.completed.length;
    final progress = total > 0 ? done / total : 0.0;

    return Column(
      children: [
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

        // Financial stats row
        Row(
          children: [
            _buildStat(
              context,
              icon: Icons.account_balance_wallet_outlined,
              value: plan.grandTotal.toStringAsFixed(0),
              label: 'Total',
            ),
            _divider(),
            _buildStat(
              context,
              icon: Icons.check_circle_outline,
              value: plan.paid.toStringAsFixed(0),
              label: 'Paid',
            ),
            _divider(),
            _buildStat(
              context,
              icon: Icons.schedule,
              value: plan.pending.toStringAsFixed(0),
              label: 'Pending',
            ),
          ],
        ),
      ],
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
