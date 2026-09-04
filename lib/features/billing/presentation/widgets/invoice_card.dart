import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/invoice_status_badge.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({
    super.key,
    required this.invoice,
    required this.onTap,
  });

  final InvoiceEntity invoice;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: c.cardBg,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: c.borderLight, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          invoice.number,
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w700,
                            color: c.textPrimary,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          _planLabel(invoice, l10n),
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontFamily: fontFamily,
                            color: c.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InvoiceStatusBadge(status: invoice.status),
                ],
              ),
              SizedBox(height: 14.h),
              Row(
                children: [
                  Text(
                    '${invoice.currency} ${invoice.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.primary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    AppDate.medium(context, invoice.issuedAt),
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
      ),
    );
  }

  String _planLabel(InvoiceEntity invoice, AppLocalizations l10n) {
    final tier = invoice.planTier;
    if (tier == null) return l10n.invoiceLineSubscription;
    final cycle = invoice.billingCycle == BillingCycle.yearly
        ? l10n.billingYearly
        : l10n.billingMonthly;
    final plan = SubscriptionPlans.getPlanByTier(tier);
    final planName = plan?.name ?? tier.name;
    return '$planName · $cycle';
  }
}
