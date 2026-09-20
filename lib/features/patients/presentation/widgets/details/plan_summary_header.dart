import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/cost_fields.dart';
import 'package:dental_clinic_app/services/currency/currency_entity.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanSummaryHeader extends StatefulWidget {
  final TreatmentPlan plan;
  final bool isInitial;
  final VoidCallback? onTap;
  final VoidCallback? onViewPaymentHistory;
  final VoidCallback? onMarkAsFinished;

  /// Turns the card into its own editor: the cost row opens downwards into
  /// the two fields instead of handing off to a bottom sheet, and reports
  /// every edit as it happens.
  ///
  /// Null keeps the old behaviour, where the card is a button and [onTap]
  /// owns what opens - which is still what the saved plan and the desktop
  /// layout want.
  final void Function(
    double totalCost,
    double labFees,
    CurrencyEntity? totalCostCurrency,
    CurrencyEntity? labFeesCurrency,
  )?
  onCostChanged;

  /// Seeds the chips when the form opens. Currency lives on the page, not on
  /// the plan, because the plan carries codes for display while the API
  /// takes ids.
  final CurrencyEntity? totalCostCurrency;
  final CurrencyEntity? labFeesCurrency;

  const PlanSummaryHeader({
    super.key,
    required this.plan,
    this.isInitial = false,
    this.onTap,
    this.onViewPaymentHistory,
    this.onMarkAsFinished,
    this.onCostChanged,
    this.totalCostCurrency,
    this.labFeesCurrency,
  });

  @override
  State<PlanSummaryHeader> createState() => _PlanSummaryHeaderState();
}

class _PlanSummaryHeaderState extends State<PlanSummaryHeader> {
  bool _expanded = false;

  TreatmentPlan get plan => widget.plan;
  bool get isInitial => widget.isInitial;
  VoidCallback? get onTap => widget.onTap;
  VoidCallback? get onViewPaymentHistory => widget.onViewPaymentHistory;
  VoidCallback? get onMarkAsFinished => widget.onMarkAsFinished;

  /// True when this card edits in place rather than handing off.
  bool get _isInlineEditor => isInitial && widget.onCostChanged != null;

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
          // ── Body ───────────────────────────────────────────────
          // Material rather than a bare gesture: this row opens something,
          // inline here and a sheet elsewhere, and the ripple is half of
          // what says so.
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16.r),
            child: InkWell(
              onTap: _isInlineEditor
                  ? () => setState(() => _expanded = !_expanded)
                  : onTap,
              borderRadius: BorderRadius.circular(16.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: isInitial
                    ? _buildInitialBody(context)
                    : _buildSavedStats(context),
              ),
            ),
          ),

          // ── The form, opened in place ──────────────────────────
          // Kept outside the InkWell above: a tap meant for a text field or
          // a currency chip must not also collapse the thing it landed in.
          if (_isInlineEditor)
            AnimatedSize(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              alignment: Alignment.topCenter,
              // Built only while open, rather than kept offstage: the fields
              // then start from whatever the plan currently holds every time
              // they are opened, and a closed card costs nothing.
              child: _expanded
                  ? _buildInlineEditor(context)
                  : const SizedBox(width: double.infinity),
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

  Widget _buildInlineEditor(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(height: 1, color: c.borderLight),
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CostFields(
                initialTotalCost: plan.totalCost,
                initialLabFees: plan.labFees,
                initialTotalCostCurrency: widget.totalCostCurrency,
                initialLabFeesCurrency: widget.labFeesCurrency,
                onChanged: widget.onCostChanged!,
              ),
              SizedBox(height: 14.h),
              // Nothing to commit - the figures are already in the plan - so
              // this only folds the form away again. Sized to its word
              // rather than to the card: a full-width primary bar would read
              // as the screen's main action, which Save in the header is.
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: GestureDetector(
                  onTap: () => setState(() => _expanded = false),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 22.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      l10n.done,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// A plan being written is in one of two states, and the card shows only
  /// the one it is in.
  ///
  /// Unpriced, it is a single invitation - the app's ordinary icon, title,
  /// chevron row, which everyone already reads as "tap this". Priced, it is
  /// the figures. What it replaced drew two labelled columns holding an em
  /// dash each: a read-out of numbers that did not exist yet, where the dash
  /// read as "nothing here" rather than "yours to fill in".
  Widget _buildInitialBody(BuildContext context) {
    if (plan.totalCost > 0) return _buildPricedLines(context);

    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return Row(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorManager.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(11.r),
          ),
          child: Icon(
            Icons.payments_outlined,
            size: 17.w,
            color: ColorManager.primaryDarker,
          ),
        ),
        SizedBox(width: 11.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.setCost,
                style: TextStyle(
                  fontSize: 12.5.sp,
                  fontFamily: family,
                  fontWeight: FontWeight.w600,
                  color: c.textPrimary,
                ),
              ),
              SizedBox(height: 2.h),
              // The two figures the sheet asks for, named rather than mocked
              // up - the row can say what it opens without the card drawing
              // empty versions of them first.
              Text(
                '${l10n.totalCost} • ${l10n.labFees}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: family,
                  color: c.textTertiary,
                ),
              ),
            ],
          ),
        ),
        _ExpandChevron(expanded: _expanded),
      ],
    );
  }

  /// What has actually been priced.
  ///
  /// The lab line shows only when there is a lab fee: most cases have none,
  /// and a row saying so is noise on a card the user is done with.
  Widget _buildPricedLines(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    Widget line({
      required String label,
      required double value,
      required String? code,
      required Color valueColor,
      required Widget trailing,
    }) {
      return Row(
        children: [
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: family,
                fontWeight: FontWeight.w500,
                color: c.textSecondary,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          _amount(context, value: value, code: code, valueColor: valueColor),
          SizedBox(width: 8.w),
          trailing,
        ],
      );
    }

    return Column(
      children: [
        line(
          label: l10n.totalCost,
          value: plan.totalCost,
          code: plan.currencyCode,
          valueColor: c.textPrimary,
          // One affordance for the pair: both figures are edited together.
          trailing: _isInlineEditor
              ? _ExpandChevron(expanded: _expanded)
              : Icon(Icons.edit_outlined, size: 14.w, color: c.textTertiary),
        ),
        if (plan.labFees > 0) ...[
          SizedBox(height: 8.h),
          line(
            label: l10n.labFees,
            value: plan.labFees,
            // Falls back to the case currency only when the lab has none of
            // its own, so 350000 can never be read as dollars.
            code: plan.labFeesCurrencyCode ?? plan.currencyCode,
            valueColor: c.textSecondary,
            // Holds the figures in one column, under the control above.
            trailing: SizedBox(width: _isInlineEditor ? 18.w : 14.w),
          ),
        ],
      ],
    );
  }

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

/// Points down when the form is folded away and up once it is open - the
/// ordinary disclosure gesture, and direction-neutral, so it means the same
/// thing in Arabic as in English.
class _ExpandChevron extends StatelessWidget {
  const _ExpandChevron({required this.expanded});

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: expanded ? 0.5 : 0,
      duration: const Duration(milliseconds: 180),
      child: Icon(
        Icons.expand_more_rounded,
        size: 18.w,
        color: ColorManager.of(context).textTertiary,
      ),
    );
  }
}
