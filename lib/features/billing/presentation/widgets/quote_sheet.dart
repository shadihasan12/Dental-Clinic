import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/quote_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/billing_ui.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// What the sheet ended with.
class QuoteSheetResult {
  const QuoteSheetResult({required this.invoice, this.message, this.isNew = true});

  /// The invoice to go to: the one just raised, or - when the request was
  /// refused because one is already open - that one.
  final InvoiceEntity invoice;

  /// The server's own sentence for the new invoice.
  final String? message;
  final bool isNew;
}

/// Prices [params], shows the lines and the period, and raises the invoice.
///
/// The confirm button is governed by `can_request` and nothing else; when it
/// is false the server's `reason` is shown in its place, and the price stays
/// visible - the owner is allowed to know what it would cost.
Future<QuoteSheetResult?> showQuoteSheet(
  BuildContext context,
  QuoteParams params,
) {
  return showModalBottomSheet<QuoteSheetResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _QuoteSheet(params: params),
  );
}

class _QuoteSheet extends StatefulWidget {
  const _QuoteSheet({required this.params});

  final QuoteParams params;

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
    final result = await _repository.getQuote(widget.params);
    if (!mounted) return;
    setState(() {
      result.fold((e) => _loadError = e, (q) => _quote = q);
    });
  }

  Future<void> _request() async {
    setState(() => _requesting = true);
    final result = await _repository.requestSubscription(widget.params);
    if (!mounted) return;

    final created = result.fold((_) => null, (value) => value);
    if (created != null) {
      Navigator.pop(
        context,
        QuoteSheetResult(invoice: created.value, message: created.message),
      );
      return;
    }

    final failure = result.fold((e) => e, (_) => null)!;
    final message = NetworkExceptions.localizedMessage(context, failure);
    final isConflict = failure.maybeWhen(conflict: (_) => true, orElse: () => false);
    InvoiceEntity? open;
    if (isConflict) {
      // One open invoice per clinic: if that is why, the owner needs that
      // invoice, not a second one.
      final invoices = await _repository.getInvoices();
      open = invoices.fold(
        (_) => null,
        (list) => list.where((i) => i.isOpen && !i.isCreditNote).firstOrNull,
      );
    }
    if (!mounted) return;
    setState(() {
      _requesting = false;
      _refusal = message;
      _openInvoice = open;
    });
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
          QuoteSheetResult(invoice: _openInvoice!, isNew: false),
        ),
      );
    } else if (quote != null && quote.canRequest && _refusal == null) {
      footer = FormSheetButton(
        label: l10n.requestInvoiceAction,
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
        billingPeriodLabel(l10n, quote.billingPeriod, quote.durationQuantity),
        style: TextStyle(
          fontFamily: family,
          fontSize: 12.sp,
          color: c.textSecondary,
        ),
      ),
      SizedBox(height: 14.h),
      Text(
        l10n.amountToTransfer,
        style: TextStyle(
          fontFamily: family,
          fontSize: 11.sp,
          color: c.textTertiary,
        ),
      ),
      SizedBox(height: 4.h),
      AmountsView(amounts: quote.amounts, fallbackUsd: quote.amountUsd),
      SizedBox(height: 14.h),
      BillingLinesView(lines: quote.lines, total: quote.amountUsd),
      if (quote.periodStart != null && quote.periodEnd != null) ...[
        SizedBox(height: 10.h),
        Text(
          l10n.quotePeriodIfPaidNow(
            AppDate.medium(context, quote.periodStart!),
            AppDate.medium(context, quote.periodEnd!),
          ),
          style: TextStyle(
            fontFamily: family,
            fontSize: 11.sp,
            height: 1.4,
            color: c.textTertiary,
          ),
        ),
      ],
      SizedBox(height: 12.h),
      if (!quote.canRequest)
        _Notice(
          text: quote.reason ?? l10n.subRenewNotAvailable,
          tone: ColorManager.warning,
        )
      else if (_refusal != null)
        _Notice(text: _refusal!, tone: ColorManager.error)
      else
        _Notice(text: l10n.quoteInvoiceExplainer, tone: ColorManager.info),
    ];
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
