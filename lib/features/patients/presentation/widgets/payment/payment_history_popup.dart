import 'dart:async';

import 'package:dental_clinic_app/custom_widgets/adaptive_sheet.dart';
import 'package:dental_clinic_app/core/models/audit_entry.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/features/patients/data/models/payment.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/currency/currency_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';

class PaymentHistoryPopup extends StatefulWidget {
  final String caseTitle;
  final Future<List<Payment>> Function() onLoadPayments;
  final double totalCost;
  final double paidAmount;

  /// Used only when a payment does not carry its own currency, so an older
  /// record still reads as money rather than as a bare number.
  final String? caseCurrencyCode;

  const PaymentHistoryPopup({
    super.key,
    required this.caseTitle,
    required this.onLoadPayments,
    required this.totalCost,
    required this.paidAmount,
    this.caseCurrencyCode,
  });

  static Future<void> show(
    BuildContext context, {
    required String caseTitle,
    required Future<List<Payment>> Function() onLoadPayments,
    required double totalCost,
    required double paidAmount,
    String? caseCurrencyCode,
  }) {
    return showAppSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PaymentHistoryPopup(
        caseTitle: caseTitle,
        onLoadPayments: onLoadPayments,
        totalCost: totalCost,
        paidAmount: paidAmount,
        caseCurrencyCode: caseCurrencyCode,
      ),
    );
  }

  @override
  State<PaymentHistoryPopup> createState() => _PaymentHistoryPopupState();
}

class _PaymentHistoryPopupState extends State<PaymentHistoryPopup> {
  List<Payment>? _payments;
  bool _isLoading = true;

  StreamSubscription<CurrencyState>? _currencySub;

  @override
  void initState() {
    super.initState();
    _loadPayments();
    // A currency changed by an edit is named by its code, from the list the
    // app holds. Usually loaded already; asked for here when it is not.
    final currencies = getIt<CurrencyBloc>();
    final loaded = currencies.state.maybeWhen(
      loaded: (_) => true,
      orElse: () => false,
    );
    if (!loaded) {
      _currencySub = currencies.stream.listen((_) {
        if (mounted) setState(() {});
      });
      currencies.add(const CurrencyEvent.load());
    }
  }

  @override
  void dispose() {
    _currencySub?.cancel();
    super.dispose();
  }

  Future<void> _loadPayments() async {
    try {
      final payments = await widget.onLoadPayments();
      if (mounted) {
        setState(() {
          _payments = payments;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _payments = [];
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 0.75.sh),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          HideInDialog(child: Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ColorManager.of(context).border,
              borderRadius: BorderRadius.circular(2.r),
            ),
          )),

          // Header
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.paymentHistory,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.of(context).textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    size: 24.w,
                    color: ColorManager.of(context).textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Payments list
          Flexible(
            child: _isLoading
                ? const _PaymentHistorySkeleton()
                : _payments!.isEmpty
                ? _buildEmptyState(context)
                : ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(16.w),
                    itemCount: _payments!.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      return _buildPaymentItem(context, _payments![index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentItem(BuildContext context, Payment payment) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBgSecondary,
        borderRadius: BorderRadiusManager.md,
        border: Border.all(color: ColorManager.of(context).borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPaymentRow(context, payment),
          if (payment.audits.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Divider(height: 1, color: ColorManager.of(context).borderLight),
            SizedBox(height: 8.h),
            for (final entry in payment.audits) _buildAuditEntry(context, entry),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentRow(BuildContext context, Payment payment) {
    return Row(
        children: [
          // Icon
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: ColorManager.of(context).borderLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.payments_outlined,
              size: 20.w,
              color: ColorManager.grey,
            ),
          ),

          SizedBox(width: 12.w),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment.notes ?? AppLocalizations.of(context)!.payment,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w500,
                    color: ColorManager.of(context).textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      AppDate.medium(context, payment.createdAt),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        color: ColorManager.of(context).textSecondary,
                      ),
                    ),
                    SizedBox(width: 8.w),
                  ],
                ),
              ],
            ),
          ),

          // Amount, in the currency it was actually taken in. A case priced
          // in USD can be settled in SYP, so a hardcoded $ mislabelled the
          // figure by whatever the exchange rate happened to be.
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatAmount(payment),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w500,
                  color: ColorManager.healthGreen,
                ),
              ),
              if (_conversionLabel(payment) != null) ...[
                SizedBox(height: 2.h),
                Text(
                  _conversionLabel(payment)!,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: ColorManager.of(context).textTertiary,
                  ),
                ),
              ],
            ],
          ),
        ],
    );
  }

  /// One line of a payment's history: who recorded it or edited it, when,
  /// and - for an edit - what each field it touched held before and after.
  Widget _buildAuditEntry(BuildContext context, AuditEntry entry) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final name =
        entry.isDeletedUser ? l10n.deletedUser : entry.userFullname.trim();
    final who = entry.isUpdate
        ? l10n.paymentEditedBy(name)
        : l10n.paymentRecordedBy(name);
    final when = entry.createdAt;

    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            when == null ? who : '$who · ${AppDate.medium(context, when)}',
            style: TextStyle(
              fontSize: 11.sp,
              fontFamily: family,
              color: c.textSecondary,
            ),
          ),
          for (final change in Payment.changesIn(entry))
            Padding(
              padding: EdgeInsetsDirectional.only(start: 10.w, top: 2.h),
              child: Text(
                '${_auditFieldLabel(l10n, change.field)}: '
                '${_auditValue(change.field, change.before)} → '
                '${_auditValue(change.field, change.after)}',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: family,
                  color: c.textTertiary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _auditFieldLabel(AppLocalizations l10n, String field) {
    switch (field) {
      case 'amount':
        return l10n.amount;
      case 'amount_in_case_currency':
        return l10n.amountInCaseCurrencyLabel;
      case 'exchange_rate':
        return l10n.exchangeRate;
      case 'notes':
        return l10n.notes;
      default:
        // currency_id, case_currency_id
        return l10n.currency;
    }
  }

  /// A history value as it reads: a figure without its padding zeros, a
  /// currency by its code, a note as written.
  String _auditValue(String field, Object? value) {
    if (value == null || '$value'.isEmpty) return '—';
    switch (field) {
      case 'notes':
        return '$value';
      case 'currency_id':
      case 'case_currency_id':
        return _currencyCodeOf('$value') ?? '—';
      default:
        final figure = Payment.auditFigure(value);
        return figure == null
            ? '$value'
            : NumberFormat('#,##0.######', 'en').format(figure);
    }
  }

  /// The code of a currency id, from the list the app already holds. Null
  /// until that list has loaded - the id itself says nothing to a reader.
  String? _currencyCodeOf(String id) {
    return getIt<CurrencyBloc>().state.maybeWhen(
      loaded: (currencies) {
        for (final currency in currencies) {
          if (currency.id == id) return currency.currencyCode;
        }
        return null;
      },
      orElse: () => null,
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 48.w,
            color: ColorManager.of(context).textTertiary,
          ),
          SizedBox(height: 12.h),
          Text(
            AppLocalizations.of(context)!.noPaymentsYet,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontHelper.fontFamily(context),
              color: ColorManager.of(context).textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  /// `1,350 SYP` - the code trails the figure so it reads the same in Arabic
  /// and English, where a leading symbol would sit on the wrong side.
  String _formatAmount(Payment payment) {
    final code = payment.currencyCode ?? widget.caseCurrencyCode;
    final figure = payment.amount.toStringAsFixed(0);
    return code == null || code.isEmpty ? figure : '$figure $code';
  }

  /// Only shown when the payment was taken in something other than the case
  /// currency - otherwise the conversion says nothing the row does not.
  String? _conversionLabel(Payment payment) {
    final caseCode = widget.caseCurrencyCode;
    final paidCode = payment.currencyCode;
    final converted = payment.amountInCaseCurrency;
    if (caseCode == null || paidCode == null) return null;
    if (converted == null || paidCode == caseCode) return null;
    return '≈ ${converted.toStringAsFixed(0)} $caseCode';
  }
}

class _PaymentHistorySkeleton extends StatelessWidget {
  const _PaymentHistorySkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.all(16.w),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (_, _) => SizedBox(height: 12.h),
      itemBuilder: (_, _) => Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: ColorManager.of(context).cardBgSecondary,
          borderRadius: BorderRadiusManager.md,
          border: Border.all(color: ColorManager.of(context).borderLight),
        ),
        child: AppShimmer(
          child: Row(
            children: [
              ShimmerBox(
                width: 40.w,
                height: 40.w,
                radius: BorderRadius.circular(40.w),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: 140.w, height: 12.h),
                    SizedBox(height: 6.h),
                    ShimmerBox(width: 90.w, height: 10.h),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              ShimmerBox(width: 48.w, height: 14.h),
            ],
          ),
        ),
      ),
    );
  }
}
