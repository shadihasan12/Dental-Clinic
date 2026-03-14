import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanSummaryHeader extends StatelessWidget {
  final TreatmentPlan plan;
  final bool isInitial;
  final VoidCallback? onTap;
  final VoidCallback? onViewPaymentHistory;
  final VoidCallback? onMarkAsFinished;

  const PlanSummaryHeader({
    super.key,
    required this.plan,
    this.isInitial = false,
    this.onTap,
    this.onViewPaymentHistory,
    this.onMarkAsFinished,
  });

  @override
  Widget build(BuildContext context) {
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
            if (isInitial) _buildInitialStats(context) else _buildSavedStats(context),

            // View Payment History button
            if (onViewPaymentHistory != null) ...[
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: onViewPaymentHistory,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt_long_outlined,
                        size: 14.w,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        AppLocalizations.of(context)!.viewPaymentHistory,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            // Mark as Finished button
            if (onMarkAsFinished != null) ...[
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: onMarkAsFinished,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 14.w,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        AppLocalizations.of(context)!.markAsFinished,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
              label: AppLocalizations.of(context)!.totalCost,
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
              label: AppLocalizations.of(context)!.labFees,
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
    return Row(
      children: [
        _buildStat(
          context,
          icon: Icons.account_balance_wallet_outlined,
          value: plan.grandTotal.toStringAsFixed(0),
          label: AppLocalizations.of(context)!.totalLabel,
        ),
        _divider(),
        _buildStat(
          context,
          icon: Icons.check_circle_outline,
          value: plan.paid.toStringAsFixed(0),
          label: AppLocalizations.of(context)!.paidLabel,
        ),
        _divider(),
        _buildStat(
          context,
          icon: Icons.schedule,
          value: plan.pending.toStringAsFixed(0),
          label: AppLocalizations.of(context)!.pendingLabel,
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
