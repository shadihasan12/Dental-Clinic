import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenseRow extends StatelessWidget {
  const ExpenseRow({super.key, required this.expense, required this.onTap});

  final ExpenseEntity expense;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Row(
          children: [
            // Category icon
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.receipt_outlined,
                  size: 18.w, color: ColorManager.primary),
            ),
            SizedBox(width: 12.w),

            // Category + date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.category.name,
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  if (expense.notes.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      expense.notes,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 12.sp,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Amount + currency
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${expense.amount} ${expense.currency.currencyCode}',
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2D2D2D),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  expense.entryDate,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 11.sp,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
