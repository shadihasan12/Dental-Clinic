import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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
    if (Responsive.isDesktop(context)) return _buildDesktop(context);
    return _buildMobile(context);
  }

  // ═══════════════════════════════════════════════════════════════════
  // MOBILE (unchanged)
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildMobile(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h + bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: c.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          Text(
            '${expense.amount} ${expense.currency.currencyCode}',
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: c.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            expense.category.name,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: c.textSecondary,
            ),
          ),
          SizedBox(height: 20.h),

          _MobileDetailRow(
            icon: Icons.calendar_today_outlined,
            text: expense.entryDate,
          ),
          if (expense.notes.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _MobileDetailRow(
              icon: Icons.notes_outlined,
              text: expense.notes,
            ),
          ],
          if (expense.attachments.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _MobileDetailRow(
              icon: Icons.attach_file,
              text: '${expense.attachments.length} ${l10n.attachments}',
            ),
          ],
          SizedBox(height: 24.h),

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
                    side: const BorderSide(color: ColorManager.primary),
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

  // ═══════════════════════════════════════════════════════════════════
  // DESKTOP
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildDesktop(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final locale = Localizations.localeOf(context).toString();
    final dateObj = DateTime.tryParse(expense.entryDate);
    final formattedDate = dateObj != null
        ? DateFormat.yMMMd(locale).format(dateObj)
        : expense.entryDate;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Header ────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.fromLTRB(24, 18, 16, 18),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: c.borderLight)),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.receipt_outlined,
                  color: ColorManager.primary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.expenseDetails,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeightManager.semiBold,
                    color: c.textPrimary,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, size: 20, color: c.textSecondary),
                splashRadius: 18,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),

        // ── Body ──────────────────────────────────────────────
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero amount card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorManager.primary.withValues(alpha: 0.12),
                        ColorManager.primary.withValues(alpha: 0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: ColorManager.primary.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expense.category.name,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.primary,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Flexible(
                            child: Text(
                              expense.amount,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 34,
                                fontWeight: FontWeightManager.bold,
                                color: c.textPrimary,
                                height: 1.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            expense.currency.currencyCode,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeightManager.semiBold,
                              color: c.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Meta rows
                _DesktopMetaRow(
                  icon: Icons.calendar_today_outlined,
                  label: l10n.date,
                  value: formattedDate,
                  fontFamily: fontFamily,
                ),
                if (expense.notes.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _DesktopMetaRow(
                    icon: Icons.notes_outlined,
                    label: l10n.notes,
                    value: expense.notes,
                    fontFamily: fontFamily,
                  ),
                ],

                // Attachments
                if (expense.attachments.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(
                    '${l10n.attachments} (${expense.attachments.length})',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeightManager.semiBold,
                      color: c.textSecondary,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: expense.attachments.map((a) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 72,
                          height: 72,
                          color: c.cardBgSecondary,
                          child: Image.network(
                            a.viewUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Icon(
                              Icons.insert_drive_file_outlined,
                              size: 24,
                              color: c.textSecondary,
                            ),
                            loadingBuilder: (_, child, progress) {
                              if (progress == null) return child;
                              return Center(
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: c.textSubtle,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ),

        // ── Footer ────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.fromLTRB(24, 14, 24, 18),
          decoration: BoxDecoration(
            color: c.cardBgSecondary,
            border: Border(top: BorderSide(color: c.borderLight)),
          ),
          child: Row(
            children: [
              TextButton.icon(
                onPressed: () => _confirmDelete(context, l10n),
                icon: Icon(
                  Icons.delete_outline,
                  size: 16,
                  color: Colors.red.shade400,
                ),
                label: Text(
                  l10n.delete,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeightManager.medium,
                    color: Colors.red.shade400,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  l10n.close,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeightManager.medium,
                    color: c.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined, size: 16),
                label: Text(
                  l10n.edit,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        title: Text(
          l10n.deleteExpenseTitle,
          style: TextStyle(
            fontFamily: FontHelper.fontFamily(ctx),
            fontWeight: FontWeightManager.semiBold,
          ),
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
              Navigator.pop(ctx);
              onDelete();
              Navigator.pop(context);
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

class _MobileDetailRow extends StatelessWidget {
  const _MobileDetailRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Row(
      children: [
        Icon(icon, size: 16.w, color: c.textSubtle),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 14.sp,
              color: c.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

class _DesktopMetaRow extends StatelessWidget {
  const _DesktopMetaRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.fontFamily,
  });

  final IconData icon;
  final String label;
  final String value;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: c.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: c.cardBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: c.textSecondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 11,
                    fontWeight: FontWeightManager.semiBold,
                    color: c.textTertiary,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeightManager.medium,
                    color: c.textPrimary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
