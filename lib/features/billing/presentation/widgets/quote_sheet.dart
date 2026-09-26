import 'package:dartz/dartz.dart' show Either;
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';
import 'package:dental_clinic_app/custom_widgets/app_snackbar.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/quote_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/billing_ui.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// What the sheet ended with: either what the request came to, or - when it
/// was refused because an invoice is already open - that invoice.
class QuoteSheetResult {
  const QuoteSheetResult.requested(BillingRequestResult this.outcome)
      : openInvoice = null;

  const QuoteSheetResult.alreadyOpen(InvoiceEntity this.openInvoice)
      : outcome = null;

  final BillingRequestResult? outcome;
  final InvoiceEntity? openInvoice;
}

/// Prices a purchase with [quote], shows the lines and the period, and asks
/// to be billed for it with [request] - a whole cycle, an upgrade, or add-on
/// units: all three quotes answer the same shape.
///
/// The confirm button is governed by `can_request` and nothing else; when it
/// is false the server's `reason` (and, when the clinic does not fit, what it
/// is over) is shown in its place, and the price stays visible - the owner is
/// allowed to know what it would cost.
Future<QuoteSheetResult?> showQuoteSheet(
  BuildContext context, {
  required Future<Either<NetworkExceptions, QuoteEntity>> Function() quote,
  required Future<Either<NetworkExceptions, BillingRequestResult>> Function()
      request,
}) {
  return showModalBottomSheet<QuoteSheetResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _QuoteSheet(quote: quote, request: request),
  );
}

/// Where the sheet's result leads, the same for every purchase:
///
/// - an invoice already open: straight to paying that one;
/// - a new OPEN invoice: straight to paying it, in place of the page that
///   priced it - going back lands on the subscription screen, not on a
///   purchase that has already been billed;
/// - PAID from the balance, or no invoice at all (it came out in the
///   clinic's favour): nothing to pay. Say so in the server's words, refresh
///   the access mode - the plan may have started or moved up - and go back
///   to the subscription screen, which reloads on the way back.
void handleQuoteSheetResult(BuildContext context, QuoteSheetResult result) {
  final l10n = AppLocalizations.of(context)!;
  final open = result.openInvoice;
  if (open != null) {
    context.pushReplacementNamed(AppRoutesNames.howToPay, extra: open.id);
    return;
  }

  final outcome = result.outcome!;
  if (outcome.needsPayment) {
    if (outcome.message.isNotEmpty) {
      AppSnackbar.showSuccess(
        context,
        title: l10n.invoiceRaisedTitle,
        message: outcome.message,
      );
    }
    context.pushReplacementNamed(
      AppRoutesNames.howToPay,
      extra: outcome.invoice!.id,
    );
    return;
  }

  AppSnackbar.showSuccess(
    context,
    title: l10n.billingDoneTitle,
    message: outcome.message.isEmpty ? null : outcome.message,
  );
  SubscriptionGuardHelper.refreshAccess(force: true);
  if (context.canPop()) context.pop();
}

class _QuoteSheet extends StatefulWidget {
  const _QuoteSheet({required this.quote, required this.request});

  final Future<Either<NetworkExceptions, QuoteEntity>> Function() quote;
  final Future<Either<NetworkExceptions, BillingRequestResult>> Function()
      request;

  @override
  State<_QuoteSheet> createState() => _QuoteSheetState();
}

class _QuoteSheetState extends State<_QuoteSheet> {
  final _repository = getIt<BillingRepository>();

  QuoteEntity? _quote;
  NetworkExceptions? _loadError;
  bool _requesting = false;

  /// A refusal to show in place of the button, verbatim.
  String? _refusal;

  /// Set when the request was refused because an invoice is already open.
  InvoiceEntity? _openInvoice;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final result = await widget.quote();
    if (!mounted) return;
    setState(() {
      result.fold((e) => _loadError = e, (q) => _quote = q);
    });
  }

  Future<void> _request() async {
    setState(() => _requesting = true);
    final result = await widget.request();
    if (!mounted) return;

    final outcome = result.fold((_) => null, (value) => value);
    if (outcome != null) {
      Navigator.pop(context, QuoteSheetResult.requested(outcome));
      return;
    }

    final failure = result.fold((e) => e, (_) => null)!;
    final message = NetworkExceptions.localizedMessage(context, failure);
    final isConflict =
        failure.maybeWhen(conflict: (_) => true, orElse: () => false);
    InvoiceEntity? open;
    if (isConflict) {
      // One open invoice per clinic: if that is why, the owner needs that
      // invoice, not a second one. Other 409s - the clinic does not fit, the
      // next cycle is starting this minute - are shown as they are.
      final invoices = await _repository.getInvoices();
      open = invoices.fold(
        (_) => null,
        (list) => list.where((i) => i.isOpen && !i.isRefund).firstOrNull,
      );
    }
    if (!mounted) return;
    setState(() {
      _requesting = false;
      _refusal = message;
      _openInvoice = open;
    });
  }

  String _confirmLabel(AppLocalizations l10n, QuoteEntity quote) {
    if (quote.isCredit) return l10n.confirm;
    if (quote.startsLater && quote.periodStart != null) {
      return l10n.renewFromAction(AppDate.medium(context, quote.periodStart!));
    }
    return l10n.requestInvoiceAction;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final quote = _quote;

    Widget? footer;
    if (_openInvoice != null) {
      footer = FormSheetButton(
        label: l10n.openInvoiceNumber(_openInvoice!.number),
        onPressed: () => Navigator.pop(
          context,
          QuoteSheetResult.alreadyOpen(_openInvoice!),
        ),
      );
    } else if (quote != null && quote.canRequest && _refusal == null) {
      footer = FormSheetButton(
        label: _confirmLabel(l10n, quote),
        busy: _requesting,
        onPressed: _request,
      );
    }

    return FormSheetShell(
      title: l10n.quoteTitle,
      footer: footer,
      children: [
        if (quote == null && _loadError == null)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: const Center(child: CircularProgressIndicator()),
          )
        else if (quote == null)
          _Notice(
            text: NetworkExceptions.localizedMessage(context, _loadError!),
            tone: ColorManager.error,
          )
        else
          ..._body(context, l10n, quote),
      ],
    );
  }

  List<Widget> _body(
    BuildContext context,
    AppLocalizations l10n,
    QuoteEntity quote,
  ) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final small = TextStyle(
      fontFamily: family,
      fontSize: 11.sp,
      height: 1.4,
      color: c.textTertiary,
    );
    final start = quote.periodStart;
    final end = quote.periodEnd;
    final isNowPurchase = quote.kind == 'upgrade' || quote.kind == 'addon';
    // A refusal about the state (not ACTIVE, the cycle ends today) comes with
    // empty figures - the reason is all there is to show.
    final hasFigures = quote.lines.isNotEmpty;

    return [
      Text(
        quote.planName,
        style: TextStyle(
          fontFamily: family,
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
          color: c.textPrimary,
        ),
      ),
      SizedBox(height: 2.h),
      Text(
        isNowPurchase
            ? l10n.quoteRestOfCycle
            : billingPeriodLabel(
                l10n,
                quote.billingPeriod,
                quote.durationQuantity,
              ),
        style: TextStyle(
          fontFamily: family,
          fontSize: 12.sp,
          color: c.textSecondary,
        ),
      ),
      if (hasFigures) ...[
        SizedBox(height: 14.h),
        if (quote.isCredit) ...[
          Text(l10n.quoteCreditLabel, style: small),
          SizedBox(height: 4.h),
          Text(
            formatUsd(quote.amountUsd),
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontFamily: family,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: ColorManager.success,
            ),
          ),
        ] else ...[
          Text(l10n.amountToTransfer, style: small),
          SizedBox(height: 4.h),
          AmountsView(amounts: quote.amounts, fallbackUsd: quote.amountUsd),
        ],
        SizedBox(height: 14.h),
        BillingLinesView(
          lines: quote.lines,
          total: quote.isCredit ? -quote.amountUsd : quote.amountUsd,
        ),
        if (start != null && end != null) ...[
          SizedBox(height: 10.h),
          Text(
            isNowPurchase
                ? l10n.quoteUntil(AppDate.medium(context, end))
                : quote.startsLater
                    ? l10n.quoteRunsFrom(
                        AppDate.medium(context, start),
                        AppDate.medium(context, end),
                      )
                    : l10n.quotePeriodIfPaidNow(
                        AppDate.medium(context, start),
                        AppDate.medium(context, end),
                      ),
            style: small,
          ),
        ],
      ],
      SizedBox(height: 12.h),
      if (!quote.canRequest) ...[
        _Notice(
          text: quote.reason ?? l10n.billingNotAvailableNow,
          tone: ColorManager.warning,
        ),
        for (final blocker in quote.blockers) ...[
          SizedBox(height: 8.h),
          _BlockerRow(blocker: blocker),
        ],
      ] else if (_refusal != null)
        _Notice(text: _refusal!, tone: ColorManager.error)
      else
        _Notice(
          text: quote.isCredit
              ? l10n.quoteCreditExplainer
              : quote.startsLater && start != null
                  ? l10n.quoteStartsLaterExplainer(
                      AppDate.medium(context, start),
                    )
                  : isNowPurchase && end != null
                      ? l10n.quotePayBefore(AppDate.medium(context, end))
                      : l10n.quoteInvoiceExplainer,
          tone: ColorManager.info,
        ),
    ];
  }
}

/// One ceiling the clinic is over, as something to do about it rather than
/// only a greyed-out button.
class _BlockerRow extends StatelessWidget {
  const _BlockerRow({required this.blocker});

  final QuoteBlockerEntity blocker;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    return Row(
      children: [
        Icon(
          blocker.isSeats ? Icons.people_outline : Icons.cloud_outlined,
          size: 16.w,
          color: ColorManager.warning,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            blocker.isSeats
                ? l10n.blockerSeats(
                    blocker.current,
                    blocker.allowed,
                    blocker.excess,
                  )
                : l10n.blockerStorage(blocker.excess),
            style: TextStyle(
              fontFamily: family,
              fontSize: 12.sp,
              height: 1.4,
              color: c.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({required this.text, required this.tone});

  final String text;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: tone.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: FontHelper.fontFamily(context),
          fontSize: 12.sp,
          height: 1.45,
          color: ColorManager.of(context).textPrimary,
        ),
      ),
    );
  }
}
