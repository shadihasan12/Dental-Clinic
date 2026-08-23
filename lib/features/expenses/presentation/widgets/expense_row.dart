import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// One expense, as a Denta list card: 14r, 1px hairline, a tinted icon tile,
/// and the amount as the value the eye lands on.
class ExpenseRow extends StatelessWidget {
  const ExpenseRow({super.key, required this.expense, required this.onTap});

  final ExpenseEntity expense;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? ColorManager.primary : ColorManager.primaryDarker;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                Container(
                  width: 34.w,
                  height: 34.w,
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.receipt_long_outlined,
                    size: 17.w,
                    color: accent,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        expense.category.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: family,
                          fontSize: 12.5.sp,
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                          color: c.textPrimary,
                        ),
                      ),
                      if (expense.notes.isNotEmpty) ...[
                        SizedBox(height: 3.h),
                        Text(
                          expense.notes,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: family,
                            fontSize: 11.5.sp,
                            color: c.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${expense.amount} ${expense.currency.currencyCode}',
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 13.sp,
                        height: 1.3,
                        letterSpacing: -0.3,
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      expense.entryDate,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 11.sp,
                        color: c.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
