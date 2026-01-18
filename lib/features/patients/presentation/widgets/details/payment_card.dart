import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

class PaymentCard extends StatelessWidget {
  final String description;
  final String method;
  final String date;
  final double amount;
  final bool isPaid;

  const PaymentCard({
    super.key,
    required this.description,
    required this.method,
    required this.date,
    required this.amount,
    required this.isPaid,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: TextStyleManager.titleSmall.copyWith(
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      method,
                      style: TextStyleManager.bodySmall.copyWith(
                        color: ColorManager.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              StatusBadge(
                label: isPaid ? 'Paid' : 'Pending',
                type: isPaid ? StatusType.success : StatusType.pending,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16.w,
                    color: ColorManager.textTertiary,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    date,
                    style: TextStyleManager.bodySmall.copyWith(
                      color: ColorManager.textSecondary,
                    ),
                  ),
                ],
              ),
              Text(
                '\$${amount.toStringAsFixed(0)}',
                style: TextStyleManager.titleMedium.copyWith(
                  color: ColorManager.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}