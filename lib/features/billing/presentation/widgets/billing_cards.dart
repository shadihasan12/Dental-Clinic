import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/clinic_payment_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/billing_ui.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// One invoice in a list: number, status, what it was for, and the figure
/// that matters for its state - what is left to pay on an open one, what it
/// was worth otherwise.
class InvoiceCard extends StatelessWidget {
  const InvoiceCard({super.key, required this.invoice, this.onTap});

  final InvoiceEntity invoice;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final tone = invoiceTone(invoice);
    final voided = invoice.status == InvoiceStatus.voided;

    // Open: the figure to transfer, in the server's first currency. Anything
    // else: what it was for, in USD - `amounts` is zero once it is paid.
    final figure = invoice.isOpen && invoice.amounts.isNotEmpty
        ? formatPrice(invoice.amounts.first)
        : formatUsd(invoice.amountUsd);
    final date = invoice.isOpen ? invoice.dueAt : (invoice.paidAt ?? invoice.createdAt);
    final dateLabel = invoice.isOpen ? l10n.invoiceDueOn : l10n.invoiceIssuedOn;

    return AppCard(
      onTap: onTap,
      statusTone: tone,
      child: Row(
        children: [
          IconTile(
            icon: invoice.isCreditNote
                ? Icons.savings_outlined
                : Icons.receipt_long_outlined,
            tone: tone,
          ),
          SizedBox(width: 11.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoice.number,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                    decoration: voided ? TextDecoration.lineThrough : null,
                  ),
                ),
                if (date != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    '$dateLabel ${AppDate.medium(context, date)}',
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 11.sp,
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
              Text(
                figure,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: invoice.isCreditNote ? ColorManager.info : c.textPrimary,
                  decoration: voided ? TextDecoration.lineThrough : null,
                ),
              ),
              SizedBox(height: 4.h),
              CountPill.label(invoiceStatusLabel(l10n, invoice), tone: tone),
            ],
          ),
        ],
      ),
    );
  }
}

/// One reported transfer: what was sent and how, and where its review
/// stands. A refused one carries the admin's reason right on the card.
class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.payment,
    this.methodNames,
    this.onTap,
  });

  final ClinicPaymentEntity payment;
  final Map<String, String>? methodNames;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final tone = paymentTone(payment.status);
    final muted = payment.status == ClinicPaymentStatus.cancelled;
    final reason = payment.rejectionReason;

    return Opacity(
      opacity: muted ? 0.6 : 1,
      child: AppCard(
        onTap: onTap,
        statusTone: tone,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconTile(icon: Icons.swap_horiz_rounded, tone: tone),
                SizedBox(width: 11.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${formatPlainAmount(payment.amountOriginal)} ${payment.currencyOriginal}',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontFamily: family,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: c.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        [
                          paymentMethodLabel(payment.method, methodNames),
                          if (payment.paidAt != null)
                            AppDate.medium(context, payment.paidAt!),
                        ].join(' · '),
                        style: TextStyle(
                          fontFamily: family,
                          fontSize: 11.sp,
                          color: c.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                CountPill.label(
                  paymentStatusLabel(l10n, payment.status),
                  tone: tone,
                ),
              ],
            ),
            if (payment.status == ClinicPaymentStatus.rejected &&
                reason != null) ...[
              SizedBox(height: 8.h),
              Text(
                l10n.paymentRejectedReason(reason),
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 11.5.sp,
                  height: 1.4,
                  color: ColorManager.error,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
