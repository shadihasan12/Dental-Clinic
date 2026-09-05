import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Money state for the active case, promoted out of a tab into the first
/// thing under the fold: what is left, of what total, and what has been paid.
class CaseMoneyCard extends StatelessWidget {
  const CaseMoneyCard({
    super.key,
    required this.totalCost,
    required this.paidAmount,
    required this.pendingAmount,
    required this.labFees,
    required this.paymentCount,
    this.currencyCode,
    this.labFeesCurrencyCode,
    this.onPayments,
    this.onEditCosts,
    this.onFinishCase,
  });

  final double totalCost;
  final double paidAmount;
  final double pendingAmount;
  final double labFees;
  final int paymentCount;

  /// The case currency, shown beside every figure on this card. Without it a
  /// bare "350,000" is unreadable in a clinic that prices some cases in USD
  /// and settles others in SYP.
  final String? currencyCode;

  /// Lab fees are recorded with their own currency, which is not always the
  /// case currency - so this figure gets its own code rather than borrowing
  /// the one above it.
  final String? labFeesCurrencyCode;
  final VoidCallback? onPayments;
  final VoidCallback? onEditCosts;
  final VoidCallback? onFinishCase;

  /// Grouped thousands, because these are figures a patient is read aloud.
  String _money(double v) {
    final s = v.toStringAsFixed(v.truncateToDouble() == v ? 0 : 2);
    final dot = s.indexOf('.');
    final whole = dot == -1 ? s : s.substring(0, dot);
    final rest = dot == -1 ? '' : s.substring(dot);
    final buf = StringBuffer();
    for (var i = 0; i < whole.length; i++) {
      if (i > 0 && (whole.length - i) % 3 == 0) buf.write(',');
      buf.write(whole[i]);
    }
    return '$buf$rest';
  }

  /// `350,000 SYP`, or just the figure when no code is known.
  String _moneyWithCode(double v, [String? code]) {
    final suffix = code ?? currencyCode;
    final amount = _money(v);
    return suffix == null || suffix.isEmpty ? amount : '$amount $suffix';
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    final settled = pendingAmount <= 0 && totalCost > 0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero number is what is still owed - the figure a dentist
                // is asked about at the desk, carrying its currency so the
                // amount is never ambiguous on a mixed-currency case.
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: _money(settled ? totalCost : pendingAmount),
                        children: [
                          if (currencyCode != null && currencyCode!.isNotEmpty)
                            TextSpan(
                              // Half the size and a step lighter, so it reads
                              // as a unit on the figure rather than as a
                              // second number competing with it.
                              text: ' $currencyCode',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: c.textTertiary,
                              ),
                            ),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: family,
                        height: 1.0,
                        color: settled ? ColorManager.success : c.textPrimary,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Flexible(
                      child: Text(
                        settled
                            ? l10n.paidLabel
                            : '${l10n.leftOfTotal} ${_moneyWithCode(totalCost)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.5.sp,
                          fontFamily: family,
                          color: c.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                _ProgressBar(
                  fraction: totalCost <= 0
                      ? 0
                      : (paidAmount / totalCost).clamp(0.0, 1.0),
                ),
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        '${_moneyWithCode(paidAmount)} ${l10n.paidLabel.toLowerCase()}'
                        '${paymentCount > 0 ? ' - $paymentCount ${l10n.paymentsCountLabel}' : ''}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: family,
                          color: ColorManager.success,
                        ),
                      ),
                    ),
                    if (labFees > 0) ...[
                      SizedBox(width: 12.w),
                      Flexible(
                        child: Text(
                          '${l10n.labFees} '
                          '${_moneyWithCode(labFees, labFeesCurrencyCode)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontFamily: family,
                            color: c.textTertiary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
          // Outlined pills rather than icons: the card already carries enough
          // weight without three glyphs competing with the hero figure.
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 14.h),
            child: Row(
              children: [
                _CardAction(label: l10n.paymentsAction, onTap: onPayments),
                SizedBox(width: 8.w),
                _CardAction(label: l10n.editCostsAction, onTap: onEditCosts),
                SizedBox(width: 8.w),
                _CardAction(
                  label: l10n.finishCaseAction,
                  tone: ColorManager.success,
                  onTap: onFinishCase,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.fraction});
  final double fraction;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(999.r),
      child: LinearProgressIndicator(
        value: fraction,
        minHeight: 6.h,
        backgroundColor: c.cardBgSecondary,
        // Green throughout: the bar tracks money collected, so its colour
        // should match the "paid" figure it summarises.
        valueColor: const AlwaysStoppedAnimation<Color>(ColorManager.success),
      ),
    );
  }
}

class _CardAction extends StatelessWidget {
  const _CardAction({required this.label, this.tone, this.onTap});

  final String label;

  /// Overrides the default blue - used to mark finishing the case as the
  /// terminal, positive step rather than another navigation link.
  final Color? tone;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final radius = BorderRadius.circular(10.r);

    return Expanded(
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 4.w),
            decoration: BoxDecoration(
              borderRadius: radius,
              // Hairline, neutral: the pills group the actions without
              // competing with the outstanding figure above them.
              border: Border.all(color: c.borderLight),
            ),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
                fontFamily: FontHelper.fontFamily(context),
                color: tone ?? ColorManager.primaryDarker,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
