import 'package:dental_clinic_app/features/patients/presentation/widgets/payment/record_payment_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:intl/intl.dart';

class PaymentHistoryPopup extends StatelessWidget {
  final String caseTitle;
  final List<PaymentRecord> payments;
  final double totalCost;
  final double paidAmount;

  const PaymentHistoryPopup({
    super.key,
    required this.caseTitle,
    required this.payments,
    required this.totalCost,
    required this.paidAmount,
  });

  static Future<void> show(
    BuildContext context, {
    required String caseTitle,
    required List<PaymentRecord> payments,
    required double totalCost,
    required double paidAmount,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PaymentHistoryPopup(
        caseTitle: caseTitle,
        payments: payments,
        totalCost: totalCost,
        paidAmount: paidAmount,
      ),
    );
  }

  double get _pendingAmount => totalCost - paidAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 0.75.sh),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ColorManager.gray300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment History',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: FontFamily.geist,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    size: 24.w,
                    color: ColorManager.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Payments list
          Flexible(
            child: payments.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(16.w),
                    itemCount: payments.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      return _buildPaymentItem(payments[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentItem(PaymentRecord payment) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.gray50,
        borderRadius: BorderRadiusManager.md,
        border: Border.all(color: ColorManager.gray200),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: ColorManager.gray200,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.payments_outlined,
              size: 20.w,
              color: ColorManager.grey,
            ),
          ),

          SizedBox(width: 12.w),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment.note ?? 'Payment',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: FontFamily.geist,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      DateFormat('MMM d, yyyy').format(payment.date),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: FontFamily.geist,
                        color: ColorManager.textSecondary,
                      ),
                    ),
                    SizedBox(width: 8.w),
                  ],
                ),
              ],
            ),
          ),

          // Amount
          Text(
            '\$${payment.amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w500,
              color: ColorManager.healthGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 48.w,
            color: ColorManager.textTertiary,
          ),
          SizedBox(height: 12.h),
          Text(
            'No payments yet',
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontFamily.geist,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}