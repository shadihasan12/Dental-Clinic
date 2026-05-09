import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
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
          create: (_) => getIt<BillingBloc>()
            ..add(BillingEvent.loadInvoices(clinicId)),
        ),
        BlocProvider(
          create: (_) => getIt<SubscriptionBloc>()
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
                return const Center(child: CircularProgressIndicator());
              }
              final bottomInset = MediaQuery.of(context).viewPadding.bottom;
              return ListView(
                padding: EdgeInsets.fromLTRB(
                  20.w,
                  16.h,
                  20.w,
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
                    SizedBox(height: 16.h),
                  _CurrentPlanCard(),
                  SizedBox(height: 16.h),
                  _BuyOrRenewButton(
                    hasOpenInvoice: state.latestOpen != null,
                    onTap: () => _onRenew(context),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    l10n.invoicesHistoryTitle,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w700,
                      color: c.textPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  if (state.invoices.isEmpty)
                    _EmptyInvoices()
                  else
                    ...state.invoices.map(
                      (invoice) => Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: InvoiceCard(
                          invoice: invoice,
                          onTap: () => _openInvoice(context, invoice),
                        ),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
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
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: c.cardBg,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: c.borderLight),
            ),
            child: Text(
              l10n.noActiveSubscription,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: fontFamily,
                color: c.textSecondary,
              ),
            ),
          );
        }
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: c.cardBg,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: c.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.currentPlan,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: fontFamily,
                  color: c.textTertiary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                sub.planTier.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w700,
                  color: c.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                sub.isInTrial
                    ? l10n.trialDaysRemaining(sub.trialDaysRemaining)
                    : l10n.daysUntilRenewal(sub.daysUntilRenewal),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: fontFamily,
                  color: c.textSecondary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BuyOrRenewButton extends StatelessWidget {
  const _BuyOrRenewButton({
    required this.hasOpenInvoice,
    required this.onTap,
  });

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
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        children: [
          Icon(Icons.receipt_long_outlined,
              size: 36.w, color: c.textTertiary),
          SizedBox(height: 8.h),
          Text(
            l10n.noInvoicesYet,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: fontFamily,
              color: c.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
