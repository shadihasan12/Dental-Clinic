import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/billing/presentation/bloc/billing_bloc.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SelectBillingPlanPage extends StatefulWidget {
  const SelectBillingPlanPage({super.key, this.isRenewal = false});

  final bool isRenewal;

  @override
  State<SelectBillingPlanPage> createState() => _SelectBillingPlanPageState();
}

class _SelectBillingPlanPageState extends State<SelectBillingPlanPage> {
  PlanTier _selected = PlanTier.clinic;
  BillingCycle _cycle = BillingCycle.monthly;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);

    return BlocProvider(
      create: (_) => getIt<BillingBloc>(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: c.scaffoldBg,
          appBar: PageHeader(title: l10n.selectPlanTitle),
          body: BlocConsumer<BillingBloc, BillingState>(
            listener: (context, state) {
              if (state.error != null) {
                AppSnackbar.showError(
                  context,
                  title: l10n.errorTitle,
                  message: state.error!,
                );
                context.read<BillingBloc>().add(
                      const BillingEvent.clearFlags(),
                    );
              }
              if (state.createdInvoice != null) {
                final invoice = state.createdInvoice!;
                context.read<BillingBloc>().add(
                      const BillingEvent.clearFlags(),
                    );
                context.pushReplacementNamed(
                  AppRoutesNames.invoiceDetails,
                  extra: invoice,
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
                      children: [
                        Text(
                          l10n.selectBillingCycle,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w600,
                            color: c.textSecondary,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        _CycleToggle(
                          cycle: _cycle,
                          onChanged: (cycle) =>
                              setState(() => _cycle = cycle),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          l10n.choosePlan,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w600,
                            color: c.textSecondary,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ...SubscriptionPlans.allPlans.map(
                          (plan) => Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: _PlanRow(
                              plan: plan,
                              cycle: _cycle,
                              selected: plan.tier == _selected,
                              onTap: () =>
                                  setState(() => _selected = plan.tier),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewPadding.bottom,
                    ),
                    child: PrimaryButton(
                      text: _selected == PlanTier.custom
                          ? 'Contact Us'
                          : l10n.generateInvoice,
                      isLoading: state.isProcessing,
                      onPressed: () => _onGenerate(context),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }

  void _onGenerate(BuildContext context) {
    // Custom plan: no invoice flow, route to contact sales instead.
    if (_selected == PlanTier.custom) {
      context.pushNamed(AppRoutesNames.contactSupport);
      return;
    }
    final clinicId = getIt<UserStorage>().getSelectedClinicId() ?? '';
    final plan = SubscriptionPlans.getPlanByTier(_selected)!;
    context.read<BillingBloc>().add(
          BillingEvent.createInvoice(
            clinicId: clinicId,
            plan: plan,
            cycle: _cycle,
            isRenewal: widget.isRenewal,
          ),
        );
  }
}

class _CycleToggle extends StatelessWidget {
  const _CycleToggle({required this.cycle, required this.onChanged});

  final BillingCycle cycle;
  final ValueChanged<BillingCycle> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          _option(context, BillingCycle.monthly,
              AppLocalizations.of(context)!.billingMonthly),
          _option(context, BillingCycle.yearly,
              AppLocalizations.of(context)!.billingYearly),
        ],
      ),
    );
  }

  Widget _option(BuildContext context, BillingCycle value, String label) {
    final selected = cycle == value;
    final c = ColorManager.of(context);
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
                color: selected ? ColorManager.primary : c.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlanRow extends StatelessWidget {
  const _PlanRow({
    required this.plan,
    required this.cycle,
    required this.selected,
    required this.onTap,
  });

  final SubscriptionPlanEntity plan;
  final BillingCycle cycle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final price = plan.getPrice(cycle);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: c.cardBg,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected
                ? ColorManager.primary
                : c.borderLight,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? ColorManager.primary
                      : c.border,
                  width: 2,
                ),
                color: selected ? ColorManager.primary : Colors.transparent,
              ),
              child: selected
                  ? Icon(Icons.check, size: 14.w, color: Colors.white)
                  : null,
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        plan.name,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w700,
                          color: c.textPrimary,
                        ),
                      ),
                      if (plan.isPopular) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: ColorManager.primary,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.popular,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontFamily: fontFamily,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    plan.description,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: fontFamily,
                      color: c.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // Custom plan has no fixed price — show "Contact us" instead
            // of $0/yr.
            plan.isCustom
                ? Text(
                    'Contact us',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.warning,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${price.toStringAsFixed(price % 1 == 0 ? 0 : 2)}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.primary,
                        ),
                      ),
                      Text(
                        cycle == BillingCycle.yearly ? '/yr' : '/mo',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontFamily: fontFamily,
                          color: c.textTertiary,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
