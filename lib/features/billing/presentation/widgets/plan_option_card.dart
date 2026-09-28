import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/billing_line_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/plan_features_entity.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/billing_ui.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// One plan from `GET /plans`, as both the signup plan chooser and the
/// in-app plan picker show it - one card so the two can never disagree.
///
/// Both prices are on the card, monthly and yearly, each exactly as priced
/// in every currency the server sent (never the rounded `display`). What the
/// plan includes comes from `GET /plans/{id}/features`, fetched the first
/// time the card is opened; nothing about a plan is hardcoded here.
class PlanOptionCard extends StatefulWidget {
  const PlanOptionCard({
    super.key,
    required this.plan,
    required this.selected,
    required this.features,
    required this.featuresLoading,
    required this.onTap,
    required this.onShowFeatures,
    this.highlightedPeriod,
    this.showTrial = false,
    this.onOpenFeatures,
  });

  final PlanEntity plan;
  final bool selected;
  final PlanFeaturesEntity? features;
  final bool featuresLoading;
  final VoidCallback onTap;

  /// Asks for [features]; called when "What's included" is first opened.
  final VoidCallback onShowFeatures;

  /// The period being bought, when there is one to choose (the in-app
  /// picker). Its price is drawn in the accent; null draws both alike.
  final BillingPeriod? highlightedPeriod;

  /// The free-trial days, for signup - the only place a trial starts.
  final bool showTrial;

  /// Shows what the plan includes somewhere else - the desktop plan
  /// chooser's popup - instead of opening the list inside the card. A
  /// long feature list stretched one card far past the others; in a popup
  /// the cards keep their size. Null keeps the in-card expansion.
  final VoidCallback? onOpenFeatures;

  @override
  State<PlanOptionCard> createState() => _PlanOptionCardState();
}

class _PlanOptionCardState extends State<PlanOptionCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final plan = widget.plan;
    final highlighted = widget.highlightedPeriod;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: widget.selected ? ColorManager.primary : c.borderLight,
          width: widget.selected ? 1.5 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: widget.onTap,
          child: Padding(
            padding: EdgeInsets.all(13.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan.name,
                            style: TextStyle(
                              fontFamily: family,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: c.textPrimary,
                            ),
                          ),
                          if (plan.description.isNotEmpty) ...[
                            SizedBox(height: 2.h),
                            Text(
                              plan.description,
                              style: TextStyle(
                                fontFamily: family,
                                fontSize: 11.5.sp,
                                height: 1.4,
                                color: c.textTertiary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Icon(
                      widget.selected
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_off_rounded,
                      size: 20.w,
                      color: widget.selected
                          ? ColorManager.primary
                          : c.textSubtle,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _PriceBlock(
                          label: l10n.monthly,
                          suffix: l10n.perMonth,
                          prices: plan.priceMonthly,
                          emphasized: highlighted == null ||
                              highlighted == BillingPeriod.monthly,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: _PriceBlock(
                          label: l10n.yearly,
                          suffix: l10n.perYear,
                          prices: plan.priceYearly,
                          emphasized: highlighted == null ||
                              highlighted == BillingPeriod.yearly,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.showTrial &&
                    plan.supportsTrial &&
                    plan.trialPeriodDays > 0) ...[
                  SizedBox(height: 10.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        l10n.dayFreeTrial(plan.trialPeriodDays),
                        style: TextStyle(
                          color: ColorManager.primaryDarker,
                          fontWeight: FontWeight.w500,
                          fontFamily: family,
                          fontSize: 10.sp,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 6.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton.icon(
                    onPressed: widget.onOpenFeatures ??
                        () {
                          setState(() => _expanded = !_expanded);
                          if (_expanded) widget.onShowFeatures();
                        },
                    icon: Icon(
                      widget.onOpenFeatures != null
                          ? Icons.info_outline_rounded
                          : _expanded
                          ? Icons.expand_less_rounded
                          : Icons.expand_more_rounded,
                      size: 18.w,
                    ),
                    label: Text(
                      l10n.whatsIncluded,
                      style: TextStyle(fontFamily: family, fontSize: 12.sp),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: ColorManager.primaryDarker,
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ),
                if (_expanded && widget.onOpenFeatures == null)
                  PlanFeaturesList(
                    features: widget.features,
                    loading: widget.featuresLoading,
                    showTrialNote: widget.showTrial,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// What a plan includes, grouped as the server groups it: limits first,
/// then features. Drawn inside the card on a phone and in the desktop
/// chooser's popup, so the two read the same.
class PlanFeaturesList extends StatelessWidget {
  const PlanFeaturesList({
    super.key,
    required this.features,
    required this.loading,
    this.showTrialNote = false,
  });

  final PlanFeaturesEntity? features;
  final bool loading;
  final bool showTrialNote;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (loading && features == null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }
    final data = features;
    if (data == null || data.isEmpty) {
      return Text(
        l10n.noData,
        style: TextStyle(
          fontFamily: FontHelper.fontFamily(context),
          fontSize: 11.5.sp,
          color: ColorManager.of(context).textTertiary,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final entry in data.limits.entries)
          _FeatureGroup(
            title: data.groupTitle(entry.key),
            entries: entry.value,
            showTrialNote: showTrialNote,
          ),
        for (final entry in data.features.entries)
          _FeatureGroup(
            title: data.groupTitle(entry.key),
            entries: entry.value,
            showTrialNote: showTrialNote,
          ),
      ],
    );
  }
}

/// One period's price: its label, then each currency on its own line, SYP
/// large - the server's order is not fixed, so it is sorted here.
class _PriceBlock extends StatelessWidget {
  const _PriceBlock({
    required this.label,
    required this.suffix,
    required this.prices,
    required this.emphasized,
  });

  final String label;
  final String suffix;
  final List<PriceEntity> prices;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final accent = Theme.of(context).brightness == Brightness.dark
        ? ColorManager.primary
        : ColorManager.primaryDarker;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: emphasized
            ? ColorManager.primary.withValues(alpha: 0.08)
            : c.cardBgSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: emphasized
              ? ColorManager.primary.withValues(alpha: 0.35)
              : c.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontFamily: family,
              fontSize: 9.5.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
              color: c.textTertiary,
            ),
          ),
          SizedBox(height: 3.h),
          if (prices.isEmpty)
            Text(
              '—',
              style: TextStyle(
                fontFamily: family,
                fontSize: 14.sp,
                color: c.textTertiary,
              ),
            ),
          for (final (i, price) in orderedAmounts(prices).indexed)
            Text(
              formatPrice(price),
              textDirection: TextDirection.ltr,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: family,
                fontSize: i == 0 ? 15.sp : 11.sp,
                fontWeight: i == 0 ? FontWeight.w700 : FontWeight.w500,
                height: 1.3,
                color: i == 0
                    ? (emphasized ? accent : c.textPrimary)
                    : c.textTertiary,
              ),
            ),
          Text(
            suffix,
            style: TextStyle(
              fontFamily: family,
              fontSize: 10.sp,
              color: c.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureGroup extends StatelessWidget {
  const _FeatureGroup({
    required this.title,
    required this.entries,
    required this.showTrialNote,
  });

  final String title;
  final List<PlanFeatureEntity> entries;

  /// Marks what the free trial does not include. Only meaningful where a
  /// trial is being started.
  final bool showTrialNote;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: family,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: c.textTertiary,
            ),
          ),
          SizedBox(height: 4.h),
          for (final f in entries)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_rounded,
                    size: 15.w,
                    color: ColorManager.success,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: f.name,
                        children: [
                          if (f.limitValue != null)
                            TextSpan(
                              text: '  ${f.limitValue}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          if (showTrialNote && !f.isTrialFeature)
                            TextSpan(
                              text: '  · ${l10n.notInTrial}',
                              style: TextStyle(color: c.textTertiary),
                            ),
                        ],
                      ),
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 12.sp,
                        height: 1.35,
                        color: c.textPrimary,
                      ),
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
