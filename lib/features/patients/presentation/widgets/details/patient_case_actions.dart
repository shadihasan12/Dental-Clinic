import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Finished cases, as an inline accordion at the foot of the scroll rather
/// than a third tab. Collapsed by default: it is reference material, not
/// something the dentist needs mid-appointment.
class PastCasesSection extends StatefulWidget {
  const PastCasesSection({
    super.key,
    required this.cases,
    required this.onOpenCase,
  });

  final List<DentalCase> cases;
  final ValueChanged<DentalCase> onOpenCase;

  @override
  State<PastCasesSection> createState() => _PastCasesSectionState();
}

class _PastCasesSectionState extends State<PastCasesSection> {
  bool _open = false;

  String _date(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    if (widget.cases.isEmpty) return const SizedBox.shrink();

    final last = widget.cases.first;

    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _open = !_open),
            borderRadius: BorderRadius.circular(14.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
              child: Row(
                children: [
                  Icon(Icons.folder_outlined, size: 18.w, color: c.textTertiary),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              l10n.pastCasesTitle,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: family,
                                color: c.textPrimary,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 1.h,
                              ),
                              decoration: BoxDecoration(
                                color: c.cardBgSecondary,
                                borderRadius: BorderRadius.circular(999.r),
                              ),
                              child: Text(
                                '${widget.cases.length}',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: family,
                                  color: c.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (!_open)
                          Text(
                            '${l10n.lastFinished} ${_date(last.endDate ?? last.startDate)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontFamily: family,
                              color: c.textSecondary,
                            ),
                          ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _open ? 0.5 : 0,
                    duration: const Duration(milliseconds: 160),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20.w,
                      color: c.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_open)
            for (final k in widget.cases) ...[
              Divider(height: 1, color: c.borderLight),
              InkWell(
                onTap: () => widget.onOpenCase(k),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              k.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: family,
                                color: c.textPrimary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              '${_date(k.endDate ?? k.startDate)} - ${l10n.readOnlyCase}',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontFamily: family,
                                color: c.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 20.w,
                        color: c.textTertiary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
        ],
      ),
    );
  }
}

/// The two things a dentist does mid-appointment, parked in the thumb arc.
class DockedCaseActions extends StatelessWidget {
  const DockedCaseActions({
    super.key,
    required this.onAddTreatment,
    required this.onRecordPayment,
  });

  final VoidCallback onAddTreatment;
  final VoidCallback onRecordPayment;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    // Pinned to one value for both buttons: the outlined variant otherwise
    // sits a couple of pixels taller than the filled one and the pair reads
    // as misaligned.
    final kActionHeight = 46.h;

    return Container(
      decoration: BoxDecoration(
        color: c.surfaceBg,
        border: Border(top: BorderSide(color: c.borderLight)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
          child: Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: onAddTreatment,
                  icon: Icon(Icons.add_rounded, size: 16.w),
                  label: Text(
                    l10n.addTreatmentButton,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: family,
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    foregroundColor: ColorManager.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    minimumSize: Size(0, kActionHeight),
                    maximumSize: Size(double.infinity, kActionHeight),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                // Deliberately icon-less: only the primary action carries a
                // glyph, so the two buttons read as unequal at a glance.
                child: OutlinedButton(
                  onPressed: onRecordPayment,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorManager.primaryDarker,
                    side: BorderSide(
                      color: ColorManager.primary.withValues(alpha: 0.55),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    minimumSize: Size(0, kActionHeight),
                    maximumSize: Size(double.infinity, kActionHeight),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    l10n.addPaymentButton,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: family,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Mark-as-finished stays a dialog rather than a sheet: it is the one
/// destructive action here and should interrupt, not slide up politely.
class FinishCaseDialog {
  const FinishCaseDialog._();

  static Future<bool> show(
    BuildContext context, {
    required double outstanding,
    required int unfinishedTreatments,
    required String currencyCode,
  }) async {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    final hasWarning = outstanding > 0 || unfinishedTreatments > 0;

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: c.cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          l10n.finishThisCaseTitle,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            fontFamily: family,
            color: c.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.finishCaseBody,
              style: TextStyle(
                fontSize: 13.sp,
                height: 1.45,
                fontFamily: family,
                color: c.textSecondary,
              ),
            ),
            if (hasWarning) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: ColorManager.warning.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: ColorManager.warning.withValues(alpha: 0.28),
                  ),
                ),
                child: Text(
                  l10n.stillOutstandingWarning,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    height: 1.4,
                    fontFamily: family,
                    color: c.textPrimary,
                  ),
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              l10n.cancel,
              style: TextStyle(
                fontSize: 13.5.sp,
                fontFamily: family,
                color: c.textSecondary,
              ),
            ),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor:
                  hasWarning ? ColorManager.destructive : ColorManager.primary,
            ),
            child: Text(
              hasWarning ? l10n.finishAnyway : l10n.finishCaseAction,
              style: TextStyle(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w600,
                fontFamily: family,
                color: ColorManager.white,
              ),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
