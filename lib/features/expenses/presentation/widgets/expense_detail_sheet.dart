import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenseDetailSheet extends StatelessWidget {
  const ExpenseDetailSheet({
    super.key,
    required this.expense,
    required this.onDelete,
    required this.onEdit,
  });

  final ExpenseEntity expense;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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

          // Amount + currency
          Text(
            '${expense.amount} ${expense.currency.currencyCode}',
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D2D2D),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            expense.category.name,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 20.h),

          // Details rows
          _DetailRow(
              icon: Icons.calendar_today_outlined, text: expense.entryDate),
          if (expense.notes.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _DetailRow(icon: Icons.notes_outlined, text: expense.notes),
          ],
          if (expense.attachments.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _DetailRow(
              icon: Icons.attach_file,
              text: '${expense.attachments.length} ${l10n.attachments}',
            ),
          ],
          SizedBox(height: 24.h),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit_outlined, size: 16.w),
                  label: Text(
                    l10n.edit,
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorManager.primary,
                    side: BorderSide(color: ColorManager.primary),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _confirmDelete(context, l10n),
                  icon: Icon(Icons.delete_outline, size: 16.w),
                  label: Text(
                    l10n.delete,
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red.shade400,
                    side: BorderSide(color: Colors.red.shade400),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),
            ],
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
              Navigator.pop(ctx); // close dialog
              onDelete(); // remove from data
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
