import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/subscription_period_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/billing_ui.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Every cycle the clinic has been served, newest first - from
/// `GET /subscriptions/periods`, not the dashboard's raw event log at
/// `/subscriptions/history`: which plan, for how long, for how much.
class SubscriptionHistoryPage extends StatelessWidget {
  const SubscriptionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final repository = getIt<BillingRepository>();

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      appBar: PageHeader(title: l10n.subscriptionHistoryTitle),
      body: BillingAsync<List<SubscriptionPeriodEntity>>(
        load: repository.getPeriods,
        builder: (context, periods, _) {
          final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
          if (periods.isEmpty) {
            return ListView(
              padding: EdgeInsets.all(14.w),
              children: [
                StateCard(
                  icon: Icons.history_rounded,
                  title: l10n.noHistoryYet,
                ),
              ],
            );
          }
          return ListView.separated(
            padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h + bottomInset),
            itemCount: periods.length,
            separatorBuilder: (_, _) => SizedBox(height: 8.h),
            itemBuilder: (context, i) => _PeriodCard(period: periods[i]),
          );
        },
      ),
    );
  }
}

class _PeriodCard extends StatelessWidget {
  const _PeriodCard({required this.period});

  final SubscriptionPeriodEntity period;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final (label, tone) = switch (period.status.toUpperCase()) {
      'ACTIVE' => (l10n.subStatusActive, ColorManager.success),
      'CANCELED' || 'CANCELLED' => (l10n.subStatusCanceled, ColorManager.error),
      _ => (l10n.periodCompleted, ColorManager.gray500),
    };
    final start = period.startsAt;
    // A cancelled cycle's end is the day it really stopped.
    final end = period.endsAt;

    return AppCard(
      statusTone: tone,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconTile(
                icon: period.isTrial
                    ? Icons.card_giftcard_outlined
                    : Icons.workspace_premium_outlined,
                tone: tone,
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      period.planName,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      billingPeriodLabel(
                        l10n,
                        period.billingPeriod,
                        period.durationQuantity,
                      ),
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 11.sp,
                        color: c.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              CountPill.label(label, tone: tone),
            ],
          ),
          SizedBox(height: 8.h),
          if (start != null && end != null)
            BillingInfoRow(
              label: l10n.invoicePeriod,
              value:
                  '${AppDate.medium(context, start)} – ${AppDate.medium(context, end)}',
            ),
          BillingInfoRow(
            label: l10n.invoiceAmountLabel,
            value: period.isTrial ? l10n.freeTrial : formatUsd(period.priceUsd),
            ltrValue: !period.isTrial,
          ),
        ],
      ),
    );
  }
}
