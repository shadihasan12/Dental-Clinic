import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/billing/presentation/pages/report_payment_page.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/billing_ui.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// One invoice, always read fresh from `GET /invoices/{id}`.
///
/// Fresh on purpose: the invoice is held in dollars and converted again each
/// time it is read, so an amount to transfer from a list fetched earlier may
/// already be out of date.
class InvoiceDetailsPage extends StatelessWidget {
  const InvoiceDetailsPage({super.key, required this.invoiceId});

  final String invoiceId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final repository = getIt<BillingRepository>();

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      appBar: PageHeader(title: l10n.invoiceDetailsTitle),
      body: BillingAsync<InvoiceEntity>(
        load: () => repository.getInvoice(invoiceId),
        builder: (context, invoice, reload) =>
            _InvoiceBody(invoice: invoice, reload: reload),
      ),
    );
  }
}

class _InvoiceBody extends StatelessWidget {
  const _InvoiceBody({required this.invoice, required this.reload});

  final InvoiceEntity invoice;
  final Future<void> Function() reload;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final tone = invoiceTone(invoice);
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    return ListView(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h + bottomInset),
      children: [
        AppCard(
          statusTone: tone,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconTile(icon: Icons.receipt_long_outlined, tone: tone),
                  SizedBox(width: 11.w),
                  Expanded(
                    child: Text(
                      invoice.number,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
                        decoration: invoice.status == InvoiceStatus.voided
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                  CountPill.label(invoiceStatusLabel(l10n, invoice), tone: tone),
                ],
              ),
              SizedBox(height: 14.h),
              ..._headline(context, l10n),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionLabel(l10n.invoiceLinesTitle),
              SizedBox(height: 8.h),
              BillingLinesView(lines: invoice.items, total: invoice.amountUsd),
              if (!invoice.isCreditNote) ...[
                BillingInfoRow(
                  label: l10n.invoicePaidSoFar,
                  value: formatUsd(invoice.amountPaidUsd),
                  ltrValue: true,
                ),
                BillingInfoRow(
                  label: l10n.invoiceRemaining,
                  value: formatUsd(invoice.remainingUsd),
                  ltrValue: true,
                  valueTone: invoice.remainingUsd > 0 ? tone : null,
                ),
              ],
              for (final line in invoice.items)
                if (line.periodStart != null && line.periodEnd != null)
                  BillingInfoRow(
                    label: l10n.invoicePeriod,
                    value:
                        '${AppDate.medium(context, line.periodStart!)} – ${AppDate.medium(context, line.periodEnd!)}',
                  ),
              if (invoice.createdAt != null)
                BillingInfoRow(
                  label: l10n.invoiceIssuedOn,
                  value: AppDate.medium(context, invoice.createdAt!),
                ),
            ],
          ),
        ),
        if (invoice.isOpen) ...[
          SizedBox(height: 16.h),
          DentaButton(
            label: l10n.howToPayAction,
            icon: Icons.account_balance_outlined,
            expand: true,
            onTap: () => context.pushNamed(
              AppRoutesNames.howToPay,
              extra: invoice.id,
            ),
          ),
          SizedBox(height: 8.h),
          DentaOutlineButton(
            label: l10n.reportTransferAction,
            icon: Icons.upload_file_outlined,
            expand: true,
            tone: ColorManager.primary,
            onTap: () async {
              await context.pushNamed(
                AppRoutesNames.reportPayment,
                extra: ReportPaymentPrefill(invoiceId: invoice.id),
              );
              reload();
            },
          ),
          SizedBox(height: 10.h),
          Text(
            l10n.invoicePaymentExplainer,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: family,
              fontSize: 11.sp,
              height: 1.45,
              color: c.textTertiary,
            ),
          ),
        ],
      ],
    );
  }

  List<Widget> _headline(BuildContext context, AppLocalizations l10n) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final label = TextStyle(
      fontFamily: family,
      fontSize: 11.sp,
      color: c.textTertiary,
    );

    if (invoice.isCreditNote) {
      return [
        Text(l10n.invoiceCreditNoteBody, style: label),
        SizedBox(height: 4.h),
        Text(
          formatUsd(invoice.amountUsd.abs()),
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontFamily: family,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: ColorManager.info,
          ),
        ),
      ];
    }
    if (invoice.isOpen) {
      return [
        Text(l10n.amountToTransfer, style: label),
        SizedBox(height: 4.h),
        AmountsView(amounts: invoice.amounts, fallbackUsd: invoice.remainingUsd),
        if (invoice.dueAt != null) ...[
          SizedBox(height: 8.h),
          Text(
            invoice.isOverdue
                ? l10n.invoiceOverdueSince(AppDate.medium(context, invoice.dueAt!))
                : '${l10n.invoiceDueOn} ${AppDate.medium(context, invoice.dueAt!)}',
            style: TextStyle(
              fontFamily: family,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: invoice.isOverdue ? ColorManager.error : c.textSecondary,
            ),
          ),
        ],
      ];
    }
    // Paid or void: what it was worth, in USD - `amounts` is the unpaid part
    // and reads zero now.
    final date = invoice.status == InvoiceStatus.voided
        ? invoice.voidedAt
        : invoice.paidAt;
    return [
      Text(l10n.invoiceAmountLabel, style: label),
      SizedBox(height: 4.h),
      Text(
        formatUsd(invoice.amountUsd),
        textDirection: TextDirection.ltr,
        style: TextStyle(
          fontFamily: family,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: c.textPrimary,
        ),
      ),
      if (date != null) ...[
        SizedBox(height: 6.h),
        Text(
          invoice.status == InvoiceStatus.voided
              ? l10n.invoiceVoidedOn(AppDate.medium(context, date))
              : l10n.invoicePaidOnDate(AppDate.medium(context, date)),
          style: TextStyle(
            fontFamily: family,
            fontSize: 12.sp,
            color: c.textSecondary,
          ),
        ),
      ],
    ];
  }
}
