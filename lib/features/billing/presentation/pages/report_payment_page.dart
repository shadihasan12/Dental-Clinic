import 'dart:io';

import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_method_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_receipt_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/billing_ui.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/currency/currency_bloc.dart';
import 'package:dental_clinic_app/services/file_picker/file_picker_service.dart';
import 'package:dental_clinic_app/services/file_picker/picked_file_model.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// What the form starts from: the invoice being paid, the destination picked
/// on "how to pay", or - for "report it again" - a refused report's values.
class ReportPaymentPrefill {
  const ReportPaymentPrefill({
    this.invoiceId,
    this.method,
    this.accountId,
    this.currency,
    this.amount,
    this.reference,
    this.bankName,
  });

  final String? invoiceId;
  final String? method;
  final String? accountId;
  final String? currency;
  final String? amount;
  final String? reference;
  final String? bankName;
}

/// One slip on the form: picked, uploading, uploaded, or failed.
class _Receipt {
  _Receipt(this.file);

  final PickedFileResult file;
  PaymentReceiptEntity? uploaded;
  bool uploading = true;
  String? error;
}

/// Reporting a transfer made outside the app.
///
/// The server prices it - there is no rate or USD field to fill in - and
/// records it PENDING. Nothing else moves until an admin at Dentech checks
/// the transfer, which can take hours. Pops `true` once a report is in.
class ReportPaymentPage extends StatefulWidget {
  const ReportPaymentPage({super.key, this.prefill = const ReportPaymentPrefill()});

  final ReportPaymentPrefill prefill;

  @override
  State<ReportPaymentPage> createState() => _ReportPaymentPageState();
}

class _ReportPaymentPageState extends State<ReportPaymentPage> {
  final _repository = getIt<BillingRepository>();
  final _picker = getIt<FilePickerService>();

  final _amount = TextEditingController();
  final _reference = TextEditingController();
  final _bankName = TextEditingController();
  final _notes = TextEditingController();

  bool _loading = true;
  NetworkExceptions? _loadError;
  List<PaymentMethodEntity> _methods = const [];
  InvoiceEntity? _invoice;

  PaymentMethodEntity? _method;
  PaymentAccountEntity? _account;
  String? _currency;
  DateTime _paidAt = DateTime.now();
  final List<_Receipt> _receipts = [];

  /// Once the amount has been typed, a currency change stops overwriting it.
  bool _amountEdited = false;
  bool _submitting = false;
  Map<String, String> _errors = const {};

  @override
  void initState() {
    super.initState();
    final p = widget.prefill;
    _amount.text = p.amount ?? '';
    _amountEdited = p.amount != null;
    _reference.text = p.reference ?? '';
    _bankName.text = p.bankName ?? '';
    _currency = p.currency;
    _load();
  }

  @override
  void dispose() {
    _amount.dispose();
    _reference.dispose();
    _bankName.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _loadError = null;
    });
    final methodsF = _repository.getPaymentMethods();
    final invoiceId = widget.prefill.invoiceId;
    final invoiceF = invoiceId == null ? null : _repository.getInvoice(invoiceId);
    final methods = await methodsF;
    final invoice = invoiceF == null ? null : await invoiceF;
    if (!mounted) return;

    setState(() {
      _loading = false;
      methods.fold((e) => _loadError = e, (list) => _methods = list);
      _invoice = invoice?.fold((_) => null, (i) => i);
      _applyPrefill();
    });
  }

  void _applyPrefill() {
    final p = widget.prefill;
    PaymentMethodEntity? method;
    for (final m in _methods) {
      if (m.method == p.method) method = m;
    }
    method ??= _methods.length == 1 ? _methods.first : null;
    if (method != null) _selectMethod(method, accountId: p.accountId);
  }

  void _selectMethod(PaymentMethodEntity method, {String? accountId}) {
    _method = method;
    PaymentAccountEntity? account;
    for (final a in method.accounts) {
      if (a.id == accountId) account = a;
    }
    account ??= method.accounts.length == 1 ? method.accounts.first : null;
    _selectAccount(account);
  }

  void _selectAccount(PaymentAccountEntity? account) {
    _account = account;
    // Send in the destination's own currency.
    if (account != null) _setCurrency(account.currency);
  }

  void _setCurrency(String? currency) {
    _currency = currency;
    // The invoice's figure for this currency, read fresh - unless the owner
    // already typed what they actually sent.
    final suggested = currency == null ? null : _invoice?.amountIn(currency);
    if (!_amountEdited && suggested != null) {
      _amount.text = formatPlainAmount(suggested.amount);
    }
  }

  /// Currencies to offer when no destination fixes one: the destinations'
  /// own, then everything `GET /currencies` lists.
  List<String> _currencyOptions(BuildContext context) {
    final codes = <String>{
      for (final m in _methods)
        for (final a in m.accounts) a.currency,
    };
    getIt<CurrencyBloc>().state.maybeWhen(
          loaded: (list) => codes.addAll(list.map((c) => c.currencyCode)),
          orElse: () {},
        );
    if (_currency != null) codes.add(_currency!);
    return codes.where((c) => c.isNotEmpty).toList();
  }

  Future<void> _pickReceipts() async {
    final l10n = AppLocalizations.of(context)!;
    final room = ReportPaymentParams.maxReceipts - _receipts.length;
    if (room <= 0) return;

    final pick = await _picker.pickReceipts(allowMultiple: room > 1);
    if (!mounted) return;
    if (pick.outcome == DocumentPickOutcome.unsupportedType) {
      AppSnackbar.showError(
        context,
        title: l10n.receiptUnsupportedTitle,
        message: l10n.receiptUnsupportedBody,
      );
      return;
    }

    for (final file in pick.files.take(room)) {
      // Refused here rather than after the upload: the endpoint stops at
      // 10 MB and would only say so once the bytes were sent.
      if (await file.file.length() > FilePickerService.maxReceiptBytes) {
        if (!mounted) return;
        AppSnackbar.showError(
          context,
          title: l10n.receiptTooLargeTitle,
          message: l10n.receiptTooLargeBody(file.name),
        );
        continue;
      }
      final receipt = _Receipt(file);
      setState(() => _receipts.add(receipt));
      _upload(receipt);
    }
  }

  Future<void> _upload(_Receipt receipt) async {
    setState(() {
      receipt.uploading = true;
      receipt.error = null;
    });
    final result = await _repository.uploadReceipt(File(receipt.file.file.path));
    if (!mounted) return;
    setState(() {
      receipt.uploading = false;
      result.fold(
        (e) => receipt.error = NetworkExceptions.localizedMessage(context, e),
        (uploaded) => receipt.uploaded = uploaded,
      );
    });
  }

  Map<String, String> _validate(AppLocalizations l10n) {
    final errors = <String, String>{};
    if (_method == null) errors['method'] = l10n.fieldRequired;
    final amount = double.tryParse(_amount.text.trim().replaceAll(',', ''));
    if (amount == null || amount <= 0) {
      errors['amount_original'] = l10n.pleaseEnterValidAmount;
    }
    if (_currency == null || _currency!.isEmpty) {
      errors['currency_original'] = l10n.fieldRequired;
    }
    final reference = _reference.text.trim();
    if (reference.isEmpty) {
      errors['reference_number'] = l10n.fieldRequired;
    } else if (reference.length > 100) {
      errors['reference_number'] = l10n.maxCharacters(100);
    }
    if (_notes.text.trim().length > 1000) {
      errors['notes'] = l10n.maxCharacters(1000);
    }
    if (_receipts.any((r) => r.uploading || r.uploaded == null)) {
      errors['media_item_ids'] = l10n.receiptsNotReady;
    }
    return errors;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final l10n = AppLocalizations.of(context)!;
    final errors = _validate(l10n);
    setState(() => _errors = errors);
    if (errors.isNotEmpty) return;

    final now = DateTime.now();
    final pickedToday = _paidAt.year == now.year &&
        _paidAt.month == now.month &&
        _paidAt.day == now.day;

    setState(() => _submitting = true);
    final result = await _repository.reportPayment(ReportPaymentParams(
      method: _method!.method,
      paymentAccountId: _account?.id,
      amountOriginal: _amount.text.trim().replaceAll(',', ''),
      currencyOriginal: _currency!,
      referenceNumber: _reference.text.trim(),
      bankName: _method!.isBankTransfer ? _bankName.text.trim() : null,
      // A day picked from the sheet has no time; today means "just now",
      // and an earlier day is sent at midday so no timezone shifts it.
      paidAt: pickedToday
          ? now
          : DateTime(_paidAt.year, _paidAt.month, _paidAt.day, 12),
      notes: _notes.text.trim(),
      mediaItemIds: [for (final r in _receipts) r.uploaded!.id],
    ));
    if (!mounted) return;
    setState(() => _submitting = false);

    final created = result.fold((_) => null, (value) => value);
    if (created != null) {
      SubscriptionGuardHelper.refreshAccess(force: true);
      AppSnackbar.showSuccess(
        context,
        title: l10n.paymentReportedTitle,
        message: created.message.isEmpty ? l10n.paymentReportedBody : created.message,
      );
      context.pop(true);
      return;
    }

    final failure = result.fold((e) => e, (_) => null)!;
    final message = NetworkExceptions.localizedMessage(context, failure);
    failure.maybeWhen(
      badRequest: (_, fields) {
        setState(() => _errors = _mapFieldErrors(fields ?? const {}));
        AppSnackbar.showError(context, title: l10n.errorTitle, message: message);
      },
      unprocessableEntity: (_) {
        // No exchange rate for that currency right now.
        setState(() => _errors = {'currency_original': message});
      },
      conflict: (_) => _showConflict(message),
      orElse: () =>
          AppSnackbar.showError(context, title: l10n.errorTitle, message: message),
    );
  }

  /// `media_item_ids.0` and friends all belong to the receipts section.
  Map<String, String> _mapFieldErrors(Map<String, String> fields) {
    final mapped = <String, String>{};
    fields.forEach((key, value) {
      final field = key.startsWith('media_item_ids') ? 'media_item_ids' : key;
      mapped[field] = mapped.containsKey(field) ? '${mapped[field]}\n$value' : value;
    });
    return mapped;
  }

  /// Already reported under that reference, or five reports already waiting.
  /// The server's sentence says which; the way on is the reports list.
  Future<void> _showConflict(String message) async {
    final l10n = AppLocalizations.of(context)!;
    final open = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: ColorManager.of(context).cardBg,
        content: Text(
          message,
          style: TextStyle(fontFamily: FontHelper.fontFamily(context)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.close),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.reportedTransfersTitle),
          ),
        ],
      ),
    );
    if (open == true && mounted) {
      context.pushReplacementNamed(AppRoutesNames.clinicPayments);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return AdaptivePageScaffold(
      backgroundColor: c.scaffoldBg,
      title: l10n.reportTransferTitle,
      maxContentWidth: 760,
      mobileHeader: FormTopBar(
        title: l10n.reportTransferTitle,
        onBack: () => context.pop(),
      ),
      body: _body(context, l10n),
      bottomNavigationBar: _loading || _methods.isEmpty
          ? null
          : FormActionBar(
              label: l10n.submitForReview,
              busy: _submitting,
              onPressed: _submit,
            ),
    );
  }

  Widget _body(BuildContext context, AppLocalizations l10n) {
    if (_loading) return const BillingListSkeleton();
    if (_loadError != null || _methods.isEmpty) {
      return ListView(
        padding: EdgeInsets.all(14.w),
        children: [
          if (_loadError != null)
            StateCard(
              icon: Icons.cloud_off_outlined,
              tone: ColorManager.error,
              title: l10n.billingLoadFailed,
              message: NetworkExceptions.localizedMessage(context, _loadError!),
              actionLabel: l10n.retry,
              onAction: _load,
            )
          else
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

    final method = _method;
    final invoice = _invoice;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 24.h),
        children: [
          if (invoice != null && invoice.isOpen) ...[
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.amountToTransferFor(invoice.number),
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 11.sp,
                      color: ColorManager.of(context).textTertiary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  AmountsView(
                    amounts: invoice.amounts,
                    fallbackUsd: invoice.remainingUsd,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
          ],
          FormSectionCard(
            title: l10n.paymentMethod,
            children: [
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  for (final m in _methods)
                    FormChip(
                      label: m.name,
                      selected: m.method == method?.method,
                      onTap: () => setState(() => _selectMethod(m)),
                    ),
                ],
              ),
              if (_errors['method'] != null)
                FormErrorLine(message: _errors['method']!),
              if (method != null && method.accounts.length > 1)
                FormFieldShell(
                  label: l10n.paymentDestination,
                  errorText: _errors['payment_account_id'],
                  child: Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      for (final a in method.accounts)
                        FormChip(
                          label: '${a.accountName} · ${a.currency}',
                          selected: a.id == _account?.id,
                          onTap: () => setState(() => _selectAccount(a)),
                        ),
                    ],
                  ),
                ),
              if (_account != null) _AccountLine(account: _account!),
            ],
          ),
          SizedBox(height: 8.h),
          FormSectionCard(
            title: l10n.transferDetailsTitle,
            children: [
              FormTextField(
                label: l10n.amountSent,
                controller: _amount,
                required: true,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textDirection: TextDirection.ltr,
                errorText: _errors['amount_original'],
                onChanged: () => _amountEdited = true,
              ),
              if (_account != null)
                FormPickerField(
                  label: l10n.currency,
                  value: _currency,
                  required: true,
                  errorText: _errors['currency_original'],
                  textDirection: TextDirection.ltr,
                )
              else
                FormDropdownField<String>(
                  label: l10n.currency,
                  value: _currency,
                  items: _currencyOptions(context),
                  itemLabel: (code) => code,
                  required: true,
                  errorText: _errors['currency_original'],
                  onChanged: (code) => setState(() => _setCurrency(code)),
                ),
              FormTextField(
                label: l10n.transactionReferenceLabel,
                controller: _reference,
                required: true,
                hintText: l10n.transactionReferenceHint,
                textDirection: TextDirection.ltr,
                errorText: _errors['reference_number'],
              ),
              if (method?.isBankTransfer ?? false)
                FormTextField(
                  label: l10n.bankNameOptional,
                  controller: _bankName,
                  errorText: _errors['bank_name'],
                ),
              FormDateField(
                label: l10n.transferDate,
                value: _paidAt,
                errorText: _errors['paid_at'],
                onTap: () async {
                  final picked = await DatePickerSheet.show(
                    context,
                    title: l10n.transferDate,
                    initial: _paidAt,
                    maximum: DateTime.now(),
                  );
                  if (picked != null && mounted) {
                    setState(() => _paidAt = picked);
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 8.h),
          FormSectionCard(
            title: l10n.receiptsTitle,
            trailing: CountPill.label(
              '${_receipts.length}/${ReportPaymentParams.maxReceipts}',
            ),
            children: [
              for (final r in _receipts)
                _ReceiptRow(
                  receipt: r,
                  onRetry: () => _upload(r),
                  onRemove: () => setState(() => _receipts.remove(r)),
                ),
              if (_receipts.length < ReportPaymentParams.maxReceipts)
                DentaOutlineButton(
                  label: l10n.addReceipt,
                  icon: Icons.add_photo_alternate_outlined,
                  expand: true,
                  tone: ColorManager.primary,
                  onTap: _pickReceipts,
                ),
              Text(
                l10n.receiptFormatsHint,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 11.sp,
                  color: ColorManager.of(context).textTertiary,
                ),
              ),
              if (_errors['media_item_ids'] != null)
                FormErrorLine(message: _errors['media_item_ids']!),
            ],
          ),
          SizedBox(height: 8.h),
          FormSectionCard(
            title: l10n.notes,
            children: [
              FormTextField(
                label: '',
                controller: _notes,
                maxLines: 3,
                hintText: l10n.notesHint,
                errorText: _errors['notes'],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            l10n.reportTransferExplainer,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 11.sp,
              height: 1.45,
              color: ColorManager.of(context).textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

/// The chosen destination's number, copyable, so it can be checked against
/// what was typed into the bank or wallet app.
class _AccountLine extends StatelessWidget {
  const _AccountLine({required this.account});

  final PaymentAccountEntity account;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: account.accountNumber));
        if (context.mounted) AppSnackbar.showSuccess(context, title: l10n.copied);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: c.cardBgSecondary,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${account.accountName} · ${account.accountNumber}',
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 12.sp,
                  color: c.textSecondary,
                ),
              ),
            ),
            Icon(Icons.copy_rounded, size: 16.w, color: c.textTertiary),
          ],
        ),
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  const _ReceiptRow({
    required this.receipt,
    required this.onRetry,
    required this.onRemove,
  });

  final _Receipt receipt;
  final VoidCallback onRetry;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final failed = receipt.error != null;

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: failed ? ColorManager.error.withValues(alpha: 0.4) : c.borderLight,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              width: 40.w,
              height: 40.w,
              child: receipt.file.isImage
                  ? Image.file(receipt.file.file, fit: BoxFit.cover)
                  : ColoredBox(
                      color: c.cardBg,
                      child: Icon(
                        Icons.picture_as_pdf_outlined,
                        color: c.textSecondary,
                      ),
                    ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  receipt.file.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  receipt.uploading
                      ? l10n.uploading
                      : (receipt.error ?? l10n.receiptUploaded),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 11.sp,
                    color: failed ? ColorManager.error : c.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          if (receipt.uploading)
            SizedBox(
              width: 18.w,
              height: 18.w,
              child: const CircularProgressIndicator(strokeWidth: 2),
            )
          else if (failed)
            IconButton(
              tooltip: l10n.retry,
              onPressed: onRetry,
              icon: Icon(Icons.refresh_rounded, color: c.textSecondary),
            ),
          IconButton(
            tooltip: l10n.remove,
            onPressed: receipt.uploading ? null : onRemove,
            icon: Icon(Icons.close_rounded, color: c.textSecondary),
          ),
        ],
      ),
    );
  }
}
