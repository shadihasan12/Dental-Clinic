import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/clinic_payment_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/billing/presentation/pages/payments_page.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/billing_ui.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

/// One reported transfer, read fresh - its receipt links are signed and
/// expire, so they are never reused from an older read.
class PaymentDetailsPage extends StatelessWidget {
  const PaymentDetailsPage({super.key, required this.paymentId});

  final String paymentId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final repository = getIt<BillingRepository>();

    return AdaptivePageScaffold(
      backgroundColor: c.scaffoldBg,
      title: l10n.transferDetailsTitle,
      maxContentWidth: 760,
      body: BillingAsync<ClinicPaymentEntity>(
        load: () => repository.getPayment(paymentId),
        builder: (context, payment, reload) =>
            _Body(payment: payment, reload: reload),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.payment, required this.reload});

  final ClinicPaymentEntity payment;
  final Future<void> Function() reload;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final tone = paymentTone(payment.status);
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final rejection = payment.rejectionReason;
    final cancellation = payment.cancellationReason;
    final note = payment.clinicNote;

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
                  IconTile(icon: Icons.swap_horiz_rounded, tone: tone),
                  SizedBox(width: 11.w),
                  Expanded(
                    child: Text(
                      '${formatPlainAmount(payment.amountOriginal)} ${payment.currencyOriginal}',
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
                      ),
                    ),
                  ),
                  CountPill.label(
                    paymentStatusLabel(l10n, payment.status),
                    tone: tone,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                _statusExplainer(l10n),
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 12.sp,
                  height: 1.45,
                  color: c.textSecondary,
                ),
              ),
              if (payment.status == ClinicPaymentStatus.rejected &&
                  rejection != null) ...[
                SizedBox(height: 8.h),
                Text(
                  l10n.paymentRejectedReason(rejection),
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.45,
                    color: ColorManager.error,
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 8.h),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BillingInfoRow(
                label: l10n.paymentMethod,
                value: paymentMethodLabel(payment.method),
              ),
              BillingInfoRow(
                label: l10n.transactionReferenceLabel,
                value: payment.referenceNumber,
                ltrValue: true,
              ),
              if (payment.bankName != null)
                BillingInfoRow(label: l10n.bankName, value: payment.bankName!),
              if (payment.paidAt != null)
                BillingInfoRow(
                  label: l10n.transferDate,
                  value: AppDate.medium(context, payment.paidAt!),
                ),
              // The server's own reading of what was sent - shown for
              // reference, never computed here.
              BillingInfoRow(
                label: l10n.valueInUsd,
                value: formatUsd(payment.amountUsd),
                ltrValue: true,
              ),
              if (note != null) BillingInfoRow(label: l10n.notes, value: note),
              if (cancellation != null)
                BillingInfoRow(
                  label: l10n.withdrawReasonOptional,
                  value: cancellation,
                ),
            ],
          ),
        ),
        if (payment.attachments.isNotEmpty) ...[
          SizedBox(height: 16.h),
          SectionLabel(l10n.receiptsTitle),
          SizedBox(height: 10.h),
          for (final (i, attachment) in payment.attachments.indexed)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: AppCard(
                onTap: () => launchUrl(
                  Uri.parse(attachment.viewUrl),
                  mode: LaunchMode.externalApplication,
                ),
                child: Row(
                  children: [
                    const IconTile(icon: Icons.receipt_outlined),
                    SizedBox(width: 11.w),
                    Expanded(
                      child: Text(
                        l10n.receiptNumber(i + 1),
                        style: TextStyle(
                          fontFamily: family,
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w600,
                          color: c.textPrimary,
                        ),
                      ),
                    ),
                    Icon(Icons.open_in_new_rounded,
                        size: 18.w, color: c.textTertiary),
                  ],
                ),
              ),
            ),
        ],
        if (payment.isPending) ...[
          SizedBox(height: 16.h),
          DentaOutlineButton(
            label: l10n.withdrawReport,
            icon: Icons.undo_rounded,
            expand: true,
            tone: ColorManager.error,
            onTap: () async {
              if (await withdrawPayment(context, payment)) reload();
            },
          ),
        ],
        if (payment.status == ClinicPaymentStatus.rejected) ...[
          SizedBox(height: 16.h),
          DentaButton(
            label: l10n.reportAgain,
            icon: Icons.replay_rounded,
            expand: true,
            onTap: () async {
              await reportAgain(context, payment);
              if (context.mounted) context.pop();
            },
          ),
        ],
      ],
    );
  }

  String _statusExplainer(AppLocalizations l10n) {
    switch (payment.status) {
      case ClinicPaymentStatus.pending:
        return l10n.paymentPendingExplainer;
      case ClinicPaymentStatus.verified:
        return l10n.paymentVerifiedExplainer;
      case ClinicPaymentStatus.rejected:
        return l10n.paymentRejectedExplainer;
      case ClinicPaymentStatus.cancelled:
        return l10n.paymentCancelledExplainer;
      case ClinicPaymentStatus.unknown:
        return '';
    }
  }
}
