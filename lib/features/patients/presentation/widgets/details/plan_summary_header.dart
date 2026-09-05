import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanSummaryHeader extends StatelessWidget {
  final TreatmentPlan plan;
  final bool isInitial;
  final VoidCallback? onTap;
  final VoidCallback? onViewPaymentHistory;
  final VoidCallback? onMarkAsFinished;

  const PlanSummaryHeader({
    super.key,
    required this.plan,
    this.isInitial = false,
    this.onTap,
    this.onViewPaymentHistory,
    this.onMarkAsFinished,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.of(context).borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Stats row ──────────────────────────────────────────
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: isInitial
                  ? _buildInitialStats(context)
                  : _buildSavedStats(context),
            ),
          ),

          // ── Action buttons ─────────────────────────────────────
          if (onViewPaymentHistory != null || onMarkAsFinished != null) ...[
            Divider(height: 1, color: ColorManager.of(context).borderLight),
            _buildActions(context, l10n),
          ],
        ],
      ),
    );
  }

  /// The figure keeps the weight; the currency rides beside it small and
  /// muted. A glance reads the number, a second look confirms the money it is
  /// in - which matters on this card, where the lab is routinely billed in a
  /// different currency than the case itself.
  Widget _amount(
    BuildContext context, {
    required double value,
    required String? code,
    required Color valueColor,
  }) {
    final family = FontHelper.fontFamily(context);
    final hasCode = code != null && code.trim().isNotEmpty;

    return Text.rich(
      TextSpan(
        text: value.toStringAsFixed(0),
        children: [
          if (hasCode)
            TextSpan(
              // Non-breaking, so the code can never wrap away from the figure
              // it qualifies.
              text: '\u00A0${code.trim()}',
              style: TextStyle(
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w600,
                color: ColorManager.of(context).textTertiary,
              ),
            ),
        ],
      ),
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 17.sp,
        fontFamily: family,
        fontWeight: FontWeight.w700,
        color: valueColor,
      ),
    );
  }

  /// An amount that has not been set yet. No currency: there is no figure for
  /// it to qualify.
  Widget _noAmount(BuildContext context, Color valueColor) => Text(
        '—',
        style: TextStyle(
          fontSize: 17.sp,
          fontFamily: FontHelper.fontFamily(context),
          fontWeight: FontWeight.w700,
          color: valueColor,
        ),
      );

  Widget _buildSavedStats(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Paid and pending are settled in the case currency, so all three read
    // the same code - the lab's is the only one that can differ.
    return Row(
      children: [
        _stat(
          context,
          label: l10n.totalLabel,
          value: _amount(
            context,
            value: plan.grandTotal,
            code: plan.currencyCode,
            valueColor: ColorManager.of(context).textPrimary,
          ),
        ),
        _verticalDivider(context),
        _stat(
          context,
          label: l10n.paidLabel,
          value: _amount(
            context,
            value: plan.paid,
            code: plan.currencyCode,
            valueColor: const Color(0xFF2E9E5B),
          ),
        ),
        _verticalDivider(context),
        _stat(
          context,
          label: l10n.pendingLabel,
          value: _amount(
            context,
            value: plan.pending,
            code: plan.currencyCode,
            valueColor: plan.pending > 0
                ? const Color(0xFFE07B2A)
                : const Color(0xFF2E9E5B),
          ),
        ),
      ],
    );
  }

  Widget _buildInitialStats(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return Row(
      children: [
        _stat(
          context,
          label: l10n.totalCost,
          value: plan.totalCost > 0
              ? _amount(
                  context,
                  value: plan.totalCost,
                  code: plan.currencyCode,
                  valueColor: c.textPrimary,
                )
              : _noAmount(context, c.textPrimary),
        ),
        _verticalDivider(context),
        _stat(
          context,
          label: l10n.labFees,
          value: plan.labFees > 0
              ? _amount(
                  context,
                  value: plan.labFees,
                  // Falls back to the case currency only when the lab has none
                  // of its own, so 350000 can never be read as dollars.
                  code: plan.labFeesCurrencyCode ?? plan.currencyCode,
                  valueColor: c.textSecondary,
                )
              : _noAmount(context, c.textSecondary),
        ),
      ],
    );
  }

  Widget _stat(
    BuildContext context, {
    required String label,
    required Widget value,
  }) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontFamily: FontHelper.fontFamily(context),
              color: ColorManager.of(context).textSecondary,
            ),
          ),
          SizedBox(height: 4.h),
          value,
        ],
      ),
    );
  }

  Widget _verticalDivider(BuildContext context) {
    return Container(width: 1, height: 36.h, color: ColorManager.of(context).borderLight);
  }

  Widget _buildActions(BuildContext context, AppLocalizations l10n) {
    final items = <({IconData icon, String label, VoidCallback? onTap})>[];

    if (onViewPaymentHistory != null) {
      items.add((
        icon: Icons.receipt_long_outlined,
        label: l10n.viewPaymentHistory,
        onTap: onViewPaymentHistory,
      ));
    }
    if (onMarkAsFinished != null) {
      items.add((
        icon: Icons.check_circle_outline,
        label: l10n.markAsFinished,
        onTap: onMarkAsFinished,
      ));
    }

    return Row(
      children: items.indexed.map((entry) {
        final (i, item) = entry;
        return Expanded(
          child: InkWell(
            onTap: item.onTap,
            borderRadius: i == 0
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(16.r),
                  )
                : BorderRadius.only(
                    bottomRight: Radius.circular(16.r),
                  ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 11.h),
              decoration: i == 0 && items.length > 1
                  ? BoxDecoration(
                      border: Border(
                        right: BorderSide(color: ColorManager.of(context).borderLight),
                      ),
                    )
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.icon, size: 14.w, color: ColorManager.primary),
                  SizedBox(width: 5.w),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w500,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
