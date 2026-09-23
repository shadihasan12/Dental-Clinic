import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/billing_line_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/plan_features_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/billing/presentation/cubit/plan_picker_cubit.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/billing_ui.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/quote_sheet.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// The plan picker: monthly or yearly, how many periods at once, and which
/// plan - with what each plan includes one tap away. Pricing it opens the
/// quote sheet; nothing is raised until that sheet is confirmed.
class SelectBillingPlanPage extends StatelessWidget {
  const SelectBillingPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PlanPickerCubit>()..load(),
      child: const _PlanPickerView(),
    );
  }
}

class _PlanPickerView extends StatelessWidget {
  const _PlanPickerView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return BlocBuilder<PlanPickerCubit, PlanPickerState>(
      builder: (context, state) {
        final cubit = context.read<PlanPickerCubit>();
        return Scaffold(
          backgroundColor: c.scaffoldBg,
          appBar: PageHeader(title: l10n.selectPlanTitle),
          body: _body(context, l10n, state, cubit),
          bottomNavigationBar: state.plans.isEmpty
              ? null
              : FormActionBar(
                  label: l10n.seePriceAction,
                  onPressed: state.quoteParams == null
                      ? null
                      : () => _openQuote(context, state.quoteParams!),
                ),
        );
      },
    );
  }

  Widget _body(
    BuildContext context,
    AppLocalizations l10n,
    PlanPickerState state,
    PlanPickerCubit cubit,
  ) {
    if (state.isLoading) return const BillingListSkeleton();
    if (state.plans.isEmpty) {
      return ListView(
        padding: EdgeInsets.all(14.w),
        children: [
          StateCard(
            icon: state.error == null
                ? Icons.inventory_2_outlined
                : Icons.cloud_off_outlined,
            tone: state.error == null ? null : ColorManager.error,
            title: state.error == null
                ? l10n.noPlansAvailable
                : l10n.billingLoadFailed,
            message: state.error == null
                ? null
                : NetworkExceptions.localizedMessage(context, state.error!),
            actionLabel: l10n.retry,
            onAction: cubit.load,
          ),
        ],
      );
    }

    return ListView(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h),
      children: [
        SectionLabel(l10n.selectBillingCycle),
        SizedBox(height: 10.h),
        _PeriodToggle(period: state.period, onChanged: cubit.setPeriod),
        SizedBox(height: 12.h),
        _DurationStepper(
          period: state.period,
          duration: state.duration,
          onChanged: cubit.setDuration,
        ),
        SizedBox(height: 18.h),
        SectionLabel(l10n.choosePlan),
        SizedBox(height: 10.h),
        for (final plan in state.plans)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: _PlanCard(
              plan: plan,
              period: state.period,
              selected: plan.id == state.selectedPlanId,
              features: state.features[plan.id],
              featuresLoading: state.featuresLoading.contains(plan.id),
              onTap: () => cubit.selectPlan(plan.id),
              onShowFeatures: () => cubit.loadFeatures(plan.id),
            ),
          ),
      ],
    );
  }

  Future<void> _openQuote(BuildContext context, QuoteParams params) async {
    final l10n = AppLocalizations.of(context)!;
    final result = await showQuoteSheet(context, params);
    if (result == null || !context.mounted) return;

    if (result.isNew && result.message != null && result.message!.isNotEmpty) {
      AppSnackbar.showSuccess(
        context,
        title: l10n.invoiceRaisedTitle,
        message: result.message,
      );
    }
    // The invoice replaces the picker: going back from it lands on the
    // subscription screen, not on a plan that has already been billed.
    context.pushReplacementNamed(
      AppRoutesNames.invoiceDetails,
      pathParameters: {'invoiceId': result.invoice.id},
    );
  }
}

class _PeriodToggle extends StatelessWidget {
  const _PeriodToggle({required this.period, required this.onChanged});

  final BillingPeriod period;
  final ValueChanged<BillingPeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    Widget option(BillingPeriod value, String label) {
      final selected = period == value;
      return Expanded(
        child: GestureDetector(
          onTap: () => onChanged(value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: selected ? c.cardBg : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected
                      ? ColorManager.primaryDarker
                      : c.textSecondary,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Row(
        children: [
          option(BillingPeriod.monthly, l10n.billingMonthly),
          option(BillingPeriod.yearly, l10n.billingYearly),
        ],
      ),
    );
  }
}

/// 1-36 periods at once. The quote prices the whole run.
class _DurationStepper extends StatelessWidget {
  const _DurationStepper({
    required this.period,
    required this.duration,
    required this.onChanged,
  });

  final BillingPeriod period;
  final int duration;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    Widget button(IconData icon, VoidCallback? onTap) => IconButton(
          onPressed: onTap,
          icon: Icon(icon, size: 18.w),
          color: ColorManager.primaryDarker,
          disabledColor: c.textSubtle,
          style: IconButton.styleFrom(
            backgroundColor: c.cardBgSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        );

    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Text(
              l10n.billingDurationLabel,
              style: TextStyle(
                fontFamily: family,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
                color: c.textPrimary,
              ),
            ),
          ),
          button(
            Icons.remove_rounded,
            duration > 1 ? () => onChanged(duration - 1) : null,
          ),
          SizedBox(
            width: 92.w,
            child: Text(
              billingPeriodLabel(l10n, period, duration),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: family,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w700,
                color: c.textPrimary,
              ),
            ),
          ),
          button(
            Icons.add_rounded,
            duration < QuoteParams.maxDuration
                ? () => onChanged(duration + 1)
                : null,
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatefulWidget {
  const _PlanCard({
    required this.plan,
    required this.period,
    required this.selected,
    required this.features,
    required this.featuresLoading,
    required this.onTap,
    required this.onShowFeatures,
  });

  final PlanEntity plan;
  final BillingPeriod period;
  final bool selected;
  final PlanFeaturesEntity? features;
  final bool featuresLoading;
  final VoidCallback onTap;
  final VoidCallback onShowFeatures;

  @override
  State<_PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<_PlanCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final plan = widget.plan;
    final prices = widget.period == BillingPeriod.yearly
        ? plan.priceYearly
        : plan.priceMonthly;

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
                    Icon(
                      widget.selected
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_off_rounded,
                      size: 20.w,
                      color: widget.selected
                          ? ColorManager.primary
                          : c.textSubtle,
                    ),
                    SizedBox(width: 10.w),
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
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (final (i, price) in prices.indexed)
                          Text(
                            price.display,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              fontFamily: family,
                              fontSize: i == 0 ? 13.5.sp : 11.sp,
                              fontWeight:
                                  i == 0 ? FontWeight.w700 : FontWeight.w500,
                              color: i == 0
                                  ? ColorManager.primaryDarker
                                  : c.textTertiary,
                            ),
                          ),
                        Text(
                          widget.period == BillingPeriod.yearly
                              ? l10n.perYear
                              : l10n.perMonth,
                          style: TextStyle(
                            fontFamily: family,
                            fontSize: 10.5.sp,
                            color: c.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() => _expanded = !_expanded);
                      if (_expanded) widget.onShowFeatures();
                    },
                    icon: Icon(
                      _expanded
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
                if (_expanded) _featuresBody(context, l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _featuresBody(BuildContext context, AppLocalizations l10n) {
    if (widget.featuresLoading && widget.features == null) {
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
    final features = widget.features;
    if (features == null || features.isEmpty) {
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
        for (final entry in features.limits.entries)
          _FeatureGroup(title: entry.key, entries: entry.value),
        for (final entry in features.features.entries)
          _FeatureGroup(title: entry.key, entries: entry.value),
      ],
    );
  }
}

class _FeatureGroup extends StatelessWidget {
  const _FeatureGroup({required this.title, required this.entries});

  final String title;
  final List<PlanFeatureEntity> entries;

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
                          if (!f.isTrialFeature)
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
