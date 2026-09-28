import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/added_by_label.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';
import 'package:dental_clinic_app/features/expenses/domain/entities/expense_entity.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/case_files_section.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// An expense's details, and - in the same sheet - the question of deleting
/// it.
///
/// Delete swaps the sheet's content for the confirmation rather than stacking
/// an alert on top: one surface, one decision, and Cancel lands the user back
/// on the details they were reading.
class ExpenseDetailSheet extends StatefulWidget {
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
  State<ExpenseDetailSheet> createState() => _ExpenseDetailSheetState();
}

class _ExpenseDetailSheetState extends State<ExpenseDetailSheet> {
  bool _confirmingDelete = false;

  ExpenseEntity get expense => widget.expense;

  @override
  Widget build(BuildContext context) {
    // Sized to whichever view is showing, and eased between them, so the
    // swap reads as the sheet changing its mind rather than jumping.
    return AnimatedSize(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      alignment: Alignment.bottomCenter,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 160),
        child: _confirmingDelete
            ? _buildConfirmDelete(context)
            : _buildDetails(context),
      ),
    );
  }

  Widget _buildConfirmDelete(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return FormSheetShell(
      key: const ValueKey('confirm-delete'),
      title: l10n.deleteExpenseTitle,
      footer: Row(
        children: [
          Expanded(
            child: _SheetAction(
              icon: Icons.arrow_back_rounded,
              label: l10n.cancel,
              tone: c.textSecondary,
              border: c.border,
              onTap: () => setState(() => _confirmingDelete = false),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: _SheetAction(
              icon: Icons.delete_outline,
              label: l10n.delete,
              tone: ColorManager.white,
              border: ColorManager.error,
              fill: ColorManager.error,
              onTap: () {
                widget.onDelete();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: ColorManager.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.delete_outline,
                size: 20.w,
                color: ColorManager.error,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Names what is about to go, so the user confirms this
                  // expense rather than "an expense".
                  Text(
                    '${expense.amount} ${expense.currency.currencyCode}'
                    ' \u00B7 ${expense.category.name}',
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: c.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    l10n.deleteExpenseConfirmation,
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 12.5.sp,
                      height: 1.45,
                      color: c.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
      ],
    );
  }

  Widget _buildDetails(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return FormSheetShell(
      key: const ValueKey('details'),
      title: l10n.expenseDetails,
      footer: Row(
        children: [
          Expanded(
            child: _SheetAction(
              icon: Icons.edit_outlined,
              label: l10n.edit,
              tone: ColorManager.primaryDarker,
              border: ColorManager.primaryLighter,
              // The sheet closes itself, with its own context, before handing
              // over. The caller's context is the page's: on desktop this is
              // a dialog on the root navigator, so popping from the page
              // popped the page instead - the last one, which go_router
              // asserts on.
              onTap: () {
                Navigator.pop(context);
                widget.onEdit();
              },
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: _SheetAction(
              icon: Icons.delete_outline,
              label: l10n.delete,
              tone: ColorManager.error,
              border: ColorManager.errorBorder,
              onTap: () => setState(() => _confirmingDelete = true),
            ),
          ),
        ],
      ),
      children: [
        // The amount is why the sheet was opened, so it leads as a hero
        // figure with the category as its caption.
        Text(
          '${expense.amount} ${expense.currency.currencyCode}',
          style: TextStyle(
            fontFamily: family,
            fontSize: 26.sp,
            height: 1.2,
            letterSpacing: -0.5,
            fontWeight: FontWeight.w700,
            color: c.textPrimary,
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          expense.category.name,
          style: TextStyle(
            fontFamily: family,
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w600,
            color: c.textSecondary,
          ),
        ),
        SizedBox(height: 6.h),
        AddedByLabel(
          audits: expense.audits,
          createdAt: DateTime.tryParse(expense.createdAt),
        ),
        SizedBox(height: 16.h),

        _DetailRow(
          icon: Icons.calendar_today_outlined,
          text: expense.entryDate,
        ),
        if (expense.notes.isNotEmpty) ...[
          SizedBox(height: 10.h),
          _DetailRow(icon: Icons.notes_outlined, text: expense.notes),
        ],
        if (expense.attachments.isNotEmpty) ...[
          SizedBox(height: 14.h),
          Text(
            l10n.attachments,
            style: TextStyle(
              fontFamily: family,
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w600,
              color: c.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          // A receipt is the whole reason an attachment is on an expense, so
          // it shows as something openable rather than as a count.
          SizedBox(
            height: 72.w,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: expense.attachments.length,
              separatorBuilder: (_, _) => SizedBox(width: 8.w),
              itemBuilder: (_, i) => _AttachmentThumb(
                url: expense.attachments[i].viewUrl,
                onTap: () => CaseFileViewer.open(
                  context,
                  attachments: _viewerItems(),
                  initialIndex: i,
                ),
              ),
            ),
          ),
        ],
        SizedBox(height: 8.h),
      ],
    );
  }

  /// The shared full-screen viewer speaks [CaseAttachment], so the expense's
  /// signed URLs are wrapped rather than duplicating the viewer here.
  List<CaseAttachment> _viewerItems() => [
    for (final a in expense.attachments)
      CaseAttachment(id: a.viewUrl, url: a.viewUrl, downloadUrl: a.downloadUrl),
  ];
}

/// One receipt as a 72x72 tile. The API hands back a signed URL with no
/// extension, so the decode is attempted and a file glyph stands in when it
/// turns out to be a PDF.
class _AttachmentThumb extends StatelessWidget {
  const _AttachmentThumb({required this.url, required this.onTap});

  final String url;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final radius = BorderRadius.circular(12.r);

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: radius,
        child: Container(
          width: 72.w,
          height: 72.w,
          color: c.cardBgSecondary,
          child: Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Icon(
              Icons.insert_drive_file_outlined,
              size: 24.w,
              color: c.textSecondary,
            ),
            loadingBuilder: (_, child, progress) => progress == null
                ? child
                : Center(
                    child: SizedBox(
                      width: 18.w,
                      height: 18.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: c.textTertiary,
                      ),
                    ),
                  ),
          ),
        ),
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
    final c = ColorManager.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15.w, color: c.textTertiary),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 11.5.sp,
              height: 1.4,
              color: c.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

/// A short outlined action for the bottom of a sheet: 11r corners, a 1px
/// border in a light tint of its own hue, and no enforced Material minimum
/// height, so it stays the size the padding asks for.
class _SheetAction extends StatelessWidget {
  const _SheetAction({
    required this.icon,
    required this.label,
    required this.tone,
    required this.border,
    required this.onTap,
    this.fill,
  });

  final IconData icon;
  final String label;
  final Color tone;
  final Color border;
  final VoidCallback onTap;

  /// Solid background for the one action that commits - the confirmed
  /// delete. Null keeps the outlined card-coloured button.
  final Color? fill;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(11.r);
    return Material(
      color: fill ?? ColorManager.of(context).cardBg,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 15.w, color: tone),
              SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600,
                  color: tone,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
