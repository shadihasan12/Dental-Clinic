import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/session/session_manager.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/billing/presentation/cubit/billing_overview_cubit.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/billing_cards.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/billing_ui.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_usage_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// The subscription screen: where it stands, what is owed, what was reported
/// and is being checked, and the way into choosing a plan.
///
/// [locked] is the same screen standing in for the whole app when the clinic
/// is `billing_only`: no back arrow, since there is nowhere else to go, and
/// the two ways out that are left - another clinic, or logging out.
class BillingPage extends StatelessWidget {
  const BillingPage({super.key, this.locked = false});

  final bool locked;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BillingOverviewCubit>()..load(),
      child: _BillingView(locked: locked),
    );
  }
}

class _BillingView extends StatelessWidget {
  const _BillingView({required this.locked});

  final bool locked;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      appBar: PageHeader(
        title: l10n.subscriptionPageTitle,
        showBack: locked ? false : null,
        actions: [
          IconButton(
            tooltip: l10n.subscriptionHistoryTitle,
            icon: Icon(Icons.history_rounded, color: c.textSecondary),
            onPressed: () =>
                context.pushNamed(AppRoutesNames.subscriptionHistory),
          ),
          if (locked) _LockedMenu(),
        ],
      ),
      body: BlocBuilder<BillingOverviewCubit, BillingOverviewState>(
        builder: (context, state) {
          if (state.isLoading) return const BillingListSkeleton();
          final cubit = context.read<BillingOverviewCubit>();
          final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
          final open = state.openInvoice;
          final pending = state.pendingPayments;
          final status = state.status;

          return DentaRefresh(
            onRefresh: () async {
              SubscriptionGuardHelper.refreshAccess(force: true);
              await cubit.load();
            },
            child: ListView(
              padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h + bottomInset),
              children: [
                if (status != null)
                  _StatusCard(status: status)
                else
                  _StatusUnavailable(error: state.statusError),
                if (pending.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  _PendingPaymentsCard(
                    count: pending.length,
                    onTap: () => _push(
                      context,
                      AppRoutesNames.clinicPayments,
                    ),
                  ),
                ],
                if (open != null) ...[
                  SizedBox(height: 16.h),
                  SectionLabel(l10n.openInvoiceTitle),
                  SizedBox(height: 10.h),
                  _OpenInvoiceCard(
                    state: state,
                    onOpen: () => _push(
                      context,
                      AppRoutesNames.invoiceDetails,
                      pathParameters: {'invoiceId': open.id},
                    ),
                    onHowToPay: () => _push(
                      context,
                      AppRoutesNames.howToPay,
                      extra: open.id,
                    ),
                  ),
                ] else if (status == null || status.canSubscribe) ...[
                  SizedBox(height: 12.h),
                  if (status != null)
                    DentaButton(
                      label: l10n.choosePlanAction,
                      icon: Icons.workspace_premium_outlined,
                      expand: true,
                      onTap: () =>
                          _push(context, AppRoutesNames.selectBillingPlan),
                    ),
                ] else ...[
                  SizedBox(height: 12.h),
                  _RenewalUnavailableNote(),
                ],
                if (state.usage != null) ...[
                  SizedBox(height: 16.h),
                  SectionLabel(l10n.usageTitle),
                  SizedBox(height: 10.h),
                  _UsageCard(usage: state.usage!),
                ],
                SizedBox(height: 16.h),
                AppCard(
                  onTap: () => _push(context, AppRoutesNames.clinicPayments),
                  child: Row(
                    children: [
                      const IconTile(icon: Icons.swap_horiz_rounded),
                      SizedBox(width: 11.w),
                      Expanded(
                        child: _TwoLine(
                          title: l10n.reportedTransfersTitle,
                          subtitle: l10n.reportedTransfersHint,
                        ),
                      ),
                      if (state.payments.isNotEmpty) ...[
                        CountPill(state.payments.length),
                        SizedBox(width: 6.w),
                      ],
                      const DirectionalChevron(),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                SectionLabel(
                  l10n.invoicesHistoryTitle,
                  trailing: state.invoices.isEmpty
                      ? null
                      : CountPill(state.invoices.length),
                ),
                SizedBox(height: 10.h),
                if (state.invoices.isEmpty)
                  StateCard(
                    icon: Icons.receipt_long_outlined,
                    title: l10n.noInvoicesYet,
                    message: l10n.noInvoicesYetHint,
                  )
                else
                  for (final invoice in state.invoices)
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: InvoiceCard(
                        invoice: invoice,
                        onTap: () => _push(
                          context,
                          AppRoutesNames.invoiceDetails,
                          pathParameters: {'invoiceId': invoice.id},
                        ),
                      ),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Every screen reached from here can change what this one shows - a
  /// request raises an invoice, a report adds a pending payment - so it
  /// reloads on the way back.
  Future<void> _push(
    BuildContext context,
    String name, {
    Map<String, String> pathParameters = const {},
    Object? extra,
  }) async {
    final cubit = context.read<BillingOverviewCubit>();
    await context.pushNamed(name, pathParameters: pathParameters, extra: extra);
    if (!cubit.isClosed) cubit.load();
  }
}

class _TwoLine extends StatelessWidget {
  const _TwoLine({required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: family,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: c.textPrimary,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: 2.h),
          Text(
            subtitle!,
            style: TextStyle(
              fontFamily: family,
              fontSize: 11.sp,
              height: 1.35,
              color: c.textTertiary,
            ),
          ),
        ],
      ],
    );
  }
}

/// Where the subscription stands, in the owner's terms.
class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.status});

  final SubscriptionStatusEntity status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final (label, tone, icon, body) = _describe(context, l10n);

    return AppCard(
      statusTone: tone,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconTile(icon: icon, tone: tone),
              SizedBox(width: 11.w),
              Expanded(
                child: Text(
                  status.planName.isEmpty ? l10n.currentPlan : status.planName,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
              ),
              CountPill.label(label, tone: tone),
            ],
          ),
          if (body != null) ...[
            SizedBox(height: 10.h),
            Text(
              body,
              style: TextStyle(
                fontFamily: family,
                fontSize: 12.sp,
                height: 1.45,
                color: c.textSecondary,
              ),
            ),
          ],
          ..._figures(context, l10n),
        ],
      ),
    );
  }

  (String, Color, IconData, String?) _describe(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    // A lock this screen is standing in for says why in the server's words.
    final serverMessage = getIt<SubscriptionGuard>().lastMessage;
    if (status.isExpired || status.status.toUpperCase() == 'EXPIRED') {
      return (
        l10n.subStatusExpired,
        ColorManager.error,
        Icons.lock_clock_outlined,
        l10n.subBodyExpired,
      );
    }
    if (status.isPendingActivation) {
      return (
        l10n.subStatusPending,
        ColorManager.warning,
        Icons.hourglass_top_rounded,
        serverMessage ?? l10n.subBodyPending,
      );
    }
    if (status.isCanceled) {
      return (
        l10n.subStatusCanceled,
        ColorManager.error,
        Icons.cancel_outlined,
        serverMessage ?? l10n.subBodyCanceled,
      );
    }
    if (status.isGrace) {
      return (
        l10n.subStatusGrace,
        ColorManager.warning,
        Icons.warning_amber_rounded,
        l10n.subBodyGrace,
      );
    }
    if (status.isTrial) {
      return (
        l10n.subStatusTrialing,
        ColorManager.primary,
        Icons.card_giftcard_outlined,
        null,
      );
    }
    return (
      l10n.subStatusActive,
      ColorManager.success,
      Icons.verified_outlined,
      null,
    );
  }

  List<Widget> _figures(BuildContext context, AppLocalizations l10n) {
    // Once expired, the dates still describe the cycle that ended - showing
    // them would read as time left.
    if (status.isExpired) return const [];
    final tiles = <Widget>[];
    if (status.isTrial || status.isActive) {
      tiles.add(ValueTile(
        label: l10n.daysRemaining,
        value: '${status.daysRemaining}',
        tone: status.daysRemaining <= 7 ? ColorManager.warning : null,
      ));
    }
    if (status.endsAt != null && !status.isGrace) {
      tiles.add(ValueTile(
        label: status.isTrial ? l10n.trialEndsLabel : l10n.endsLabel,
        value: AppDate.medium(context, status.endsAt!),
        valueSize: 12.5.sp,
      ));
    }
    if (status.isGrace && status.graceEndsAt != null) {
      tiles.add(ValueTile(
        label: l10n.graceEndsLabel,
        value: AppDate.medium(context, status.graceEndsAt!),
        tone: ColorManager.warning,
        valueSize: 12.5.sp,
      ));
    }
    if (tiles.isEmpty) return const [];
    return [
      SizedBox(height: 10.h),
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < tiles.length; i++) ...[
              if (i > 0) SizedBox(width: 8.w),
              Expanded(child: tiles[i]),
            ],
          ],
        ),
      ),
    ];
  }
}

/// The status call failed. No subscription at all reads as its own state -
/// nothing works then, not even paying - anything else offers a retry.
class _StatusUnavailable extends StatelessWidget {
  const _StatusUnavailable({this.error});

  final NetworkExceptions? error;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final noSubscription = error?.maybeWhen(
          notFound: (_) => true,
          paymentRequired: (_, mode, _) => mode == 'none',
          orElse: () => false,
        ) ??
        false;

    if (noSubscription) {
      return StateCard(
        icon: Icons.support_agent_outlined,
        tone: ColorManager.warning,
        title: l10n.subStatusNone,
        message: l10n.subBodyNone,
        actionLabel: l10n.contactSupport,
        onAction: () => context.pushNamed(AppRoutesNames.reportIssue),
      );
    }
    return StateCard(
      icon: Icons.cloud_off_outlined,
      tone: ColorManager.error,
      title: l10n.billingLoadFailed,
      message:
          error == null ? null : NetworkExceptions.localizedMessage(context, error!),
      actionLabel: l10n.retry,
      onAction: () => context.read<BillingOverviewCubit>().load(),
    );
  }
}

/// Between reporting a transfer and an admin confirming it nothing else in
/// the app changes. Without this the owner assumes it was lost and sends the
/// money again.
class _PendingPaymentsCard extends StatelessWidget {
  const _PendingPaymentsCard({required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppCard(
      onTap: onTap,
      tone: ColorManager.warning,
      child: Row(
        children: [
          const IconTile(
            icon: Icons.hourglass_top_rounded,
            tone: ColorManager.warning,
          ),
          SizedBox(width: 11.w),
          Expanded(
            child: _TwoLine(
              title: l10n.pendingPaymentsTitle,
              subtitle: l10n.pendingPaymentsBody(count),
            ),
          ),
          const DirectionalChevron(),
        ],
      ),
    );
  }
}

class _OpenInvoiceCard extends StatelessWidget {
  const _OpenInvoiceCard({
    required this.state,
    required this.onOpen,
    required this.onHowToPay,
  });

  final BillingOverviewState state;
  final VoidCallback onOpen;
  final VoidCallback onHowToPay;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final invoice = state.openInvoice!;
    final tone = invoiceTone(invoice);

    return AppCard(
      onTap: onOpen,
      statusTone: tone,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  invoice.number,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
              ),
              CountPill.label(invoiceStatusLabel(l10n, invoice), tone: tone),
              SizedBox(width: 6.w),
              const DirectionalChevron(),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            l10n.amountToTransfer,
            style: TextStyle(
              fontFamily: family,
              fontSize: 11.sp,
              color: c.textTertiary,
            ),
          ),
          SizedBox(height: 4.h),
          AmountsView(
            amounts: invoice.amounts,
            fallbackUsd: invoice.remainingUsd,
          ),
          if (invoice.dueAt != null) ...[
            SizedBox(height: 8.h),
            Text(
              '${l10n.invoiceDueOn} ${AppDate.medium(context, invoice.dueAt!)}',
              style: TextStyle(
                fontFamily: family,
                fontSize: 11.5.sp,
                color: invoice.isOverdue ? ColorManager.error : c.textSecondary,
              ),
            ),
          ],
          SizedBox(height: 12.h),
          // One way forward: paying. The card itself opens the invoice.
          DentaButton(
            label: l10n.payNowAction,
            icon: Icons.account_balance_outlined,
            expand: true,
            onTap: onHowToPay,
          ),
        ],
      ),
    );
  }
}

/// ACTIVE or GRACE: the quote says `can_request: false` and the request is a
/// 409, so there is no renew button that posts anything - only the way to
/// support.
class _RenewalUnavailableNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const IconTile(icon: Icons.info_outline_rounded),
              SizedBox(width: 11.w),
              Expanded(
                child: _TwoLine(
                  title: l10n.renewalFromAppTitle,
                  subtitle: l10n.subRenewNotAvailable,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          DentaOutlineButton(
            label: l10n.contactSupport,
            icon: Icons.support_agent_outlined,
            expand: true,
            tone: ColorManager.primary,
            onTap: () => context.pushNamed(AppRoutesNames.reportIssue),
          ),
        ],
      ),
    );
  }
}

class _UsageCard extends StatelessWidget {
  const _UsageCard({required this.usage});

  final SubscriptionUsageEntity usage;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final rows = <Widget>[];
    final users = usage.users;
    if (users != null) {
      rows.add(_UsageRow(
        icon: Icons.people_outline,
        label: l10n.seatsLabel,
        metric: users,
      ));
    }
    final storage = usage.storage;
    if (storage != null) {
      rows.add(_UsageRow(
        icon: Icons.cloud_outlined,
        label: l10n.storageUsed,
        metric: storage,
      ));
    }
    if (rows.isEmpty) return const SizedBox.shrink();
    return AppCard(
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) SizedBox(height: 12.h),
            rows[i],
          ],
        ],
      ),
    );
  }
}

class _UsageRow extends StatelessWidget {
  const _UsageRow({
    required this.icon,
    required this.label,
    required this.metric,
  });

  final IconData icon;
  final String label;
  final UsageMetric metric;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final unit = metric.unit.isEmpty ? '' : ' ${metric.unit}';
    final value = metric.isUnlimited
        ? '${metric.used}$unit · ${l10n.unlimited}'
        : l10n.usageOf('${metric.used}$unit', '${metric.limit}$unit');
    final tone = metric.reached ? ColorManager.warning : ColorManager.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(icon, size: 16.w, color: c.textTertiary),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600,
                  color: c.textPrimary,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontFamily: family,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: metric.reached ? ColorManager.warning : c.textSecondary,
              ),
            ),
          ],
        ),
        if (!metric.isUnlimited) ...[
          SizedBox(height: 6.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: metric.progress,
              minHeight: 5.h,
              backgroundColor: c.borderLight,
              valueColor: AlwaysStoppedAnimation(tone),
            ),
          ),
        ],
      ],
    );
  }
}

/// The two ways out of a clinic whose subscription locks everything else.
class _LockedMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert_rounded, color: c.textSecondary),
      color: c.cardBg,
      onSelected: (value) async {
        if (value == 'clinics') {
          context.pushNamed(AppRoutesNames.myClinics);
          return;
        }
        final confirmed = await AppConfirmationDialog.show(
          context: context,
          title: l10n.logout,
          subtitle: l10n.logoutConsequence,
          icon: Icons.logout,
          iconColor: ColorManager.error,
          iconBackgroundColor: ColorManager.error.withValues(alpha: 0.12),
          yesText: l10n.logout,
          noText: l10n.cancel,
        );
        if (confirmed == true) await getIt<SessionManager>().endSession();
      },
      itemBuilder: (_) => [
        PopupMenuItem(value: 'clinics', child: Text(l10n.myClinics)),
        PopupMenuItem(value: 'logout', child: Text(l10n.logout)),
      ],
    );
  }
}
