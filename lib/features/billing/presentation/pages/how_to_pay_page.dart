import 'package:dartz/dartz.dart' show Either;
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_method_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/billing/presentation/pages/report_payment_page.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/billing_ui.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class _HowToPayData {
  const _HowToPayData(this.methods, this.invoice);

  final List<PaymentMethodEntity> methods;
  final InvoiceEntity? invoice;
}

/// Where to send money: every method and destination an admin set up, each
/// account number one tap from the clipboard, and the admin's instructions
/// under it as written. Then the way to report the transfer.
///
/// With [invoiceId], the invoice is re-read too, so the amount shown for
/// each account's currency is today's.
class HowToPayPage extends StatelessWidget {
  const HowToPayPage({super.key, this.invoiceId});

  final String? invoiceId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final repository = getIt<BillingRepository>();

    Future<Either<NetworkExceptions, _HowToPayData>> load() async {
      final methodsF = repository.getPaymentMethods();
      final invoiceF = invoiceId == null ? null : repository.getInvoice(invoiceId!);
      final methods = await methodsF;
      final invoice = invoiceF == null ? null : await invoiceF;
      return methods.map(
        (list) => _HowToPayData(list, invoice?.fold((_) => null, (i) => i)),
      );
    }

    return AdaptivePageScaffold(
      backgroundColor: c.scaffoldBg,
      title: l10n.howToPayTitle,
      maxContentWidth: 760,
      body: BillingAsync<_HowToPayData>(
        load: load,
        builder: (context, data, _) => _Body(data: data, invoiceId: invoiceId),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.data, this.invoiceId});

  final _HowToPayData data;
  final String? invoiceId;

  /// Only an open charge is something to pay. A refund (money sent to the
  /// clinic) or a void one (nothing owed) never shows a figure to transfer.
  static bool _payable(InvoiceEntity? invoice) =>
      invoice != null && invoice.isOpen && !invoice.isRefund;

  /// What to send to an account, in its own currency - exact, not rounded.
  static String? _amountFor(InvoiceEntity? invoice, String currency) {
    if (!_payable(invoice)) return null;
    final price = invoice!.amountIn(currency);
    return price == null ? null : formatPrice(price);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final invoice = data.invoice;
    final summary = [
      if (_payable(invoice)) ...[
        _InvoiceSummary(invoice: invoice!),
        SizedBox(height: 16.h),
      ],
    ];

    // An empty list is legitimate - no destination is set up yet - and a
    // blank screen would read as broken.
    if (data.methods.isEmpty) {
      return ListView(
        padding: EdgeInsets.all(14.w),
        children: [
          ...summary,
          StateCard(
            icon: Icons.account_balance_outlined,
            title: l10n.noPaymentMethodsTitle,
            message: l10n.noPaymentMethodsBody,
            actionLabel: l10n.contactSupport,
            onAction: () => context.pushNamed(AppRoutesNames.reportIssue),
          ),
        ],
      );
    }

    return ListView(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h + bottomInset),
      children: [
        ...summary,
        for (final method in data.methods) ...[
          SectionLabel(method.name),
          SizedBox(height: 8.h),
          if (method.accounts.isEmpty)
            AppCard(
              child: Text(
                l10n.noPaymentMethodsBody,
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 12.sp,
                  color: c.textSecondary,
                ),
              ),
            ),
          for (final account in method.accounts)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _AccountCard(
                method: method,
                account: account,
                amount: _amountFor(invoice, account.currency),
                onReport: () => context.pushNamed(
                  AppRoutesNames.reportPayment,
                  extra: ReportPaymentPrefill(
                    invoiceId: invoiceId,
                    method: method.method,
                    accountId: account.id,
                    currency: account.currency,
                  ),
                ),
              ),
            ),
          SizedBox(height: 8.h),
        ],
      ],
    );
  }
}

/// What is owed on the invoice being paid, and the way into its lines,
/// period and dates - the pay screen is where a new plan lands, so the
/// invoice has to stay reachable from here.
class _InvoiceSummary extends StatelessWidget {
  const _InvoiceSummary({required this.invoice});

  final InvoiceEntity invoice;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    void openDetails() => context.pushNamed(
          AppRoutesNames.invoiceDetails,
          pathParameters: {'invoiceId': invoice.id},
          extra: true,
        );

    return AppCard(
      onTap: openDetails,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.amountToTransferFor(invoice.number),
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
          SizedBox(height: 6.h),
          Text(
            l10n.partialPaymentHint,
            style: TextStyle(
              fontFamily: family,
              fontSize: 11.sp,
              height: 1.4,
              color: c.textTertiary,
            ),
          ),
          SizedBox(height: 10.h),
          DentaOutlineButton(
            label: l10n.viewInvoiceDetails,
            icon: Icons.receipt_long_outlined,
            expand: true,
            tone: ColorManager.primary,
            onTap: openDetails,
          ),
        ],
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  const _AccountCard({
    required this.method,
    required this.account,
    required this.onReport,
    this.amount,
  });

  final PaymentMethodEntity method;
  final PaymentAccountEntity account;
  final VoidCallback onReport;

  /// What to send to this account, in its own currency.
  final String? amount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconTile(
                icon: method.isBankTransfer
                    ? Icons.account_balance_outlined
                    : Icons.account_balance_wallet_outlined,
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: Text(
                  account.accountName,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
              ),
              CountPill.label(account.currency),
            ],
          ),
          SizedBox(height: 10.h),
          // Offered as copy-to-clipboard: a mistyped wallet number is the
          // most common way this flow fails.
          Material(
            color: c.cardBgSecondary,
            borderRadius: BorderRadius.circular(12.r),
            child: InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: () async {
                await Clipboard.setData(
                  ClipboardData(text: account.accountNumber),
                );
                if (!context.mounted) return;
                AppSnackbar.showSuccess(context, title: l10n.copied);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        account.accountNumber,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: family,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: c.textPrimary,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.copy_rounded,
                      size: 18.w,
                      color: ColorManager.primaryDarker,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (account.instructions != null) ...[
            SizedBox(height: 8.h),
            Text(
              account.instructions!,
              style: TextStyle(
                fontFamily: family,
                fontSize: 12.sp,
                height: 1.45,
                color: c.textSecondary,
              ),
            ),
          ],
          if (amount != null) ...[
            SizedBox(height: 8.h),
            BillingInfoRow(
              label: l10n.amountToTransfer,
              value: amount!,
              ltrValue: true,
            ),
          ],
          SizedBox(height: 10.h),
          DentaOutlineButton(
            label: l10n.iSentItAction,
            icon: Icons.upload_file_outlined,
            expand: true,
            tone: ColorManager.primary,
            onTap: onReport,
          ),
        ],
      ),
    );
  }
}
