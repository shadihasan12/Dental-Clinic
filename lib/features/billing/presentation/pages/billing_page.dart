import 'package:dental_clinic_app/core/utils/bloc_settled.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/presentation/bloc/billing_bloc.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/invoice_card.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/subscription_status_banner.dart';
import 'package:dental_clinic_app/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final clinicId = getIt<UserStorage>().getSelectedClinicId() ?? '';
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<BillingBloc>()..add(BillingEvent.loadInvoices(clinicId)),
        ),
        BlocProvider(
          create: (_) =>
              getIt<SubscriptionBloc>()
                ..add(SubscriptionEvent.loadSubscription(clinicId)),
        ),
      ],
      child: const _BillingView(),
    );
  }
}

class _BillingView extends StatelessWidget {
  const _BillingView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      appBar: PageHeader(title: l10n.billingPageTitle),
      body: BlocBuilder<SubscriptionBloc, SubscriptionState>(
        builder: (context, subState) {
          return BlocConsumer<BillingBloc, BillingState>(
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
                context.pushNamed(
                  AppRoutesNames.invoiceDetails,
                  extra: invoice,
                );
              }
            },
            builder: (context, state) {
              if (state.isLoading) {
                return const _BillingSkeleton();
              }
              final bottomInset = MediaQuery.of(context).viewPadding.bottom;
              return DentaRefresh(
                onRefresh: () => _refresh(context),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    14.w,
                    14.h,
                    14.w,
                    24.h + bottomInset,
                  ),
                  children: [
                    SubscriptionStatusBanner(
                      subscription: subState.currentSubscription,
                      onAction: () => _onRenew(context),
                    ),
                    if (subState.currentSubscription != null &&
                        (subState.currentSubscription!.isNearExpiry ||
                            !subState.currentSubscription!.isValid))
                      SizedBox(height: 8.h),
                    _CurrentPlanCard(),
                    SizedBox(height: 12.h),
                    _BuyOrRenewButton(
                      hasOpenInvoice: state.latestOpen != null,
                      onTap: () => _onRenew(context),
                    ),
                    SizedBox(height: 20.h),
                    SectionLabel(
                      l10n.invoicesHistoryTitle,
                      trailing: state.invoices.isEmpty
                          ? null
                          : CountPill(state.invoices.length),
                    ),
                    SizedBox(height: 10.h),
                    if (state.invoices.isEmpty)
                      _EmptyInvoices()
                    else
                      ...state.invoices.map(
                        (invoice) => Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: InvoiceCard(
                            invoice: invoice,
                            onTap: () => _openInvoice(context, invoice),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// Reloads the banner and the invoice list together; the band holds until
  /// the invoice request lands, which is the slower of the two.
  Future<void> _refresh(BuildContext context) async {
    final clinicId = getIt<UserStorage>().getSelectedClinicId() ?? '';
    final billing = context.read<BillingBloc>();
    context.read<SubscriptionBloc>().add(
      SubscriptionEvent.loadSubscription(clinicId),
    );
    billing.add(BillingEvent.loadInvoices(clinicId));
    await billing.stream.settled((state) => !state.isLoading);
  }

  void _onRenew(BuildContext context) {
    final state = context.read<BillingBloc>().state;
    final open = state.latestOpen;
    if (open != null) {
      _openInvoice(context, open);
      return;
    }
    context.pushNamed(AppRoutesNames.selectBillingPlan);
  }

  void _openInvoice(BuildContext context, InvoiceEntity invoice) {
    context.read<BillingBloc>().add(BillingEvent.selectInvoice(invoice));
    context.pushNamed(AppRoutesNames.invoiceDetails, extra: invoice);
  }
}

class _CurrentPlanCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        final sub = state.currentSubscription;
        if (sub == null) {
          return AppCard(
            child: Row(
              children: [
                const IconTile(icon: Icons.workspace_premium_outlined),
                SizedBox(width: 11.w),
                Expanded(
                  child: Text(
                    l10n.noActiveSubscription,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontFamily: fontFamily,
                      color: c.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        // The plan name and the time left are the two facts this screen is
        // opened for, so they read as labelled figures rather than prose.
        return AppCard(
          // IntrinsicHeight is what makes `stretch` legal here: without it
          // the Row is vertically unbounded, so stretching hands each tile an
          // infinite height. Two children, so the extra pass is cheap.
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ValueTile(
                    label: l10n.currentPlan,
                    value: sub.planTier.name.toUpperCase(),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: ValueTile(
                    label: sub.isInTrial ? l10n.trial : l10n.renewal,
                    value: sub.isInTrial
                        ? l10n.trialDaysRemaining(sub.trialDaysRemaining)
                        : l10n.daysUntilRenewal(sub.daysUntilRenewal),
                    tone:
                        (sub.isInTrial
                                ? sub.trialDaysRemaining
                                : sub.daysUntilRenewal) <=
                            7
                        ? ColorManager.warning
                        : null,
                    valueSize: 12.5.sp,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BuyOrRenewButton extends StatelessWidget {
  const _BuyOrRenewButton({required this.hasOpenInvoice, required this.onTap});

  final bool hasOpenInvoice;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      width: double.infinity,
      child: PrimaryButton(
        text: hasOpenInvoice ? l10n.continueOpenInvoice : l10n.buyOrRenewPlan,
        onPressed: onTap,
      ),
    );
  }
}

class _EmptyInvoices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return StateCard(
      icon: Icons.receipt_long_outlined,
      title: l10n.noInvoicesYet,
      message: l10n.noInvoicesYetHint,
    );
  }
}

/// Keeps the plan card, the action and three invoice rows in place while the
/// request is out, so the screen does not jump when it lands.
class _BillingSkeleton extends StatelessWidget {
  const _BillingSkeleton();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    Widget block(double height) => Container(
      height: height,
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: c.borderLight),
      ),
    );

    return AppShimmer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h),
        children: [
          block(74.h),
          SizedBox(height: 12.h),
          ShimmerBox(
            width: double.infinity,
            height: 48.h,
            radius: BorderRadius.circular(12.r),
          ),
          SizedBox(height: 20.h),
          ShimmerBox(width: 130.w, height: 13.h),
          SizedBox(height: 10.h),
          for (var i = 0; i < 3; i++) ...[
            if (i > 0) SizedBox(height: 8.h),
            block(72.h),
          ],
        ],
      ),
    );
  }
}
