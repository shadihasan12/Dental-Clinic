import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'expense_models.dart';

class ExpenseDetailSheet extends StatelessWidget {
  const ExpenseDetailSheet({
    super.key,
    required this.expense,
    required this.onDelete,
  });

  final ExpenseEntity expense;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final formatted = DateFormat('EEEE, MMM d, yyyy').format(expense.date);
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h + bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Amount + title
          Text(
            '\$${expense.amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D2D2D),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            expense.title,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 20.h),

          // Details rows
          _DetailRow(icon: Icons.calendar_today_outlined, text: formatted),
          SizedBox(height: 12.h),
          _DetailRow(
            icon: Icons.category_outlined,
            text: categoryLabel(context, expense.category),
          ),
          SizedBox(height: 24.h),

          // Delete button
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => _confirmDelete(context, l10n),
              child: Text(
                l10n.deleteExpenseButton,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.red.shade400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          l10n.deleteExpenseTitle,
          style: TextStyle(fontFamily: FontHelper.fontFamily(ctx)),
        ),
        content: Text(
          l10n.deleteExpenseConfirmation,
          style: TextStyle(fontFamily: FontHelper.fontFamily(ctx)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              l10n.cancel,
              style: TextStyle(fontFamily: FontHelper.fontFamily(ctx)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);   // close dialog
              onDelete();           // remove from data
              Navigator.pop(context); // close sheet
            },
            child: Text(
              l10n.delete,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(ctx),
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16.w, color: Colors.grey.shade500),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 14.sp,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
