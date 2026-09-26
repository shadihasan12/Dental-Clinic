import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/addon_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/billing_line_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/billing/presentation/cubit/plan_picker_cubit.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/billing_ui.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/plan_option_card.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/quote_sheet.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

export 'package:dental_clinic_app/features/billing/presentation/cubit/plan_picker_cubit.dart'
    show BillingPlanArgs, BillingPlanMode;

/// The plan picker: monthly or yearly, how many periods at once, and which
/// plan - with what each plan includes one tap away. Pricing it opens the
/// quote sheet; nothing is raised until that sheet is confirmed.
///
/// The same page buys a new subscription, renews one (opening "as it
/// stands", with the add-on units to carry on), or upgrades one - see
/// [BillingPlanMode].
class SelectBillingPlanPage extends StatelessWidget {
  const SelectBillingPlanPage({super.key, this.args = const BillingPlanArgs()});

  final BillingPlanArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PlanPickerCubit>()..start(args),
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
        return AdaptivePageScaffold(
          backgroundColor: c.scaffoldBg,
          title: switch (state.mode) {
            BillingPlanMode.subscribe => l10n.selectPlanTitle,
            BillingPlanMode.renew => l10n.renewPlanTitle,
            BillingPlanMode.upgrade => l10n.upgradePlanTitle,
          },
          maxContentWidth: 760,
          body: _body(context, l10n, state, cubit),
          bottomNavigationBar: state.plans.isEmpty
              ? null
              : FormActionBar(
                  label: l10n.seePriceAction,
                  onPressed: state.quoteParams == null
                      ? null
                      : () => _openQuote(context, state),
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
    if (state.plans.isEmpty && state.isUpgrade && state.error == null) {
      return ListView(
        padding: EdgeInsets.all(14.w),
        children: [
          StateCard(
            icon: Icons.workspace_premium_outlined,
            title: l10n.noBiggerPlan,
            message: l10n.upgradeHint,
          ),
        ],
      );
    }
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
        // An upgrade keeps the cycle's period, quantity and dates: only the
        // plan is chosen.
        if (state.isUpgrade)
          _HintCard(text: l10n.upgradeHint)
        else ...[
          SectionLabel(l10n.selectBillingCycle),
          SizedBox(height: 10.h),
          _PeriodToggle(period: state.period, onChanged: cubit.setPeriod),
          SizedBox(height: 12.h),
          _DurationStepper(
            period: state.period,
            duration: state.duration,
            onChanged: cubit.setDuration,
          ),
        ],
        SizedBox(height: 18.h),
        SectionLabel(l10n.choosePlan),
        SizedBox(height: 10.h),
        for (final plan in state.plans)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: PlanOptionCard(
              plan: plan,
              highlightedPeriod: state.period,
              selected: plan.id == state.selectedPlanId,
              features: state.features[plan.id],
              featuresLoading: state.featuresLoading.contains(plan.id),
              onTap: () => cubit.selectPlan(plan.id),
              onShowFeatures: () => cubit.loadFeatures(plan.id),
            ),
          ),
        // The steppers are what is asked for; the quote's lines are what will
        // be bought - a plan with no ceiling on a limit leaves that add-on out.
        if (state.mode == BillingPlanMode.renew &&
            state.addons.isNotEmpty) ...[
          SizedBox(height: 10.h),
          SectionLabel(l10n.renewAddonsTitle),
          SizedBox(height: 6.h),
          Text(
            l10n.renewAddonsHint,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 11.sp,
              height: 1.4,
              color: ColorManager.of(context).textTertiary,
            ),
          ),
          SizedBox(height: 10.h),
          for (final addon in state.addons)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _AddonStepper(
                addon: addon,
                units: state.addonUnits[addon.versionId] ?? 0,
                onChanged: (units) =>
                    cubit.setAddonUnits(addon.versionId, units),
              ),
            ),
        ],
      ],
    );
  }

  Future<void> _openQuote(BuildContext context, PlanPickerState state) async {
    final repository = getIt<BillingRepository>();
    final params = state.quoteParams!;
    final version = params.planVersionId;
    final result = await showQuoteSheet(
      context,
      quote: state.isUpgrade
          ? () => repository.getUpgradeQuote(version)
          : () => repository.getQuote(params),
      request: state.isUpgrade
          ? () => repository.requestUpgrade(version)
          : () => repository.requestSubscription(params),
    );
    if (result == null || !context.mounted) return;
    handleQuoteSheetResult(context, result);
  }
}

class _HintCard extends StatelessWidget {
  const _HintCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IconTile(icon: Icons.info_outline_rounded),
          SizedBox(width: 11.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 12.sp,
                height: 1.45,
                color: c.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Units of one add-on for the new cycle, starting at what the clinic holds.
/// 0 ends the add-on with the current cycle.
class _AddonStepper extends StatelessWidget {
  const _AddonStepper({
    required this.addon,
    required this.units,
    required this.onChanged,
  });

  final AddonEntity addon;
  final int units;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    return AppCard(
      child: Row(
        children: [
          IconTile(
            icon: addon.isSeats ? Icons.people_outline : Icons.cloud_outlined,
          ),
          SizedBox(width: 11.w),
          Expanded(
            child: Text(
              addon.name,
              style: TextStyle(
                fontFamily: family,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
                color: c.textPrimary,
              ),
            ),
          ),
          _StepButton(
            icon: Icons.remove_rounded,
            onTap: units > 0 ? () => onChanged(units - 1) : null,
          ),
          SizedBox(
            width: 40.w,
            child: Text(
              units.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: family,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: c.textPrimary,
              ),
            ),
          ),
          _StepButton(
            icon: Icons.add_rounded,
            onTap: units < 1000 ? () => onChanged(units + 1) : null,
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return IconButton(
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
