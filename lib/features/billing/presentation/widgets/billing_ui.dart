import 'package:dartz/dartz.dart' show Either;
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/denta_refresh.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/billing_line_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/clinic_payment_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' hide TextDirection;

// Shared pieces of the billing screens: how a status reads and what hue it
// takes, how a USD figure is written, and one loader for the read-only pages.

/// `$59.97`. Only for the USD figures the server holds; any other currency
/// is shown from the server's own `display` string, never converted here.
String formatUsd(double value) {
  final formatted = NumberFormat.currency(
    locale: 'en',
    symbol: r'$',
    decimalDigits: 2,
  ).format(value.abs());
  return value < 0 ? '-$formatted' : formatted;
}

/// A decimal written without a trailing `.0` - `719640`, `59.97`.
String formatPlainAmount(double value) {
  if (value == value.roundToDouble()) return value.toStringAsFixed(0);
  return value.toString();
}

String invoiceStatusLabel(AppLocalizations l10n, InvoiceEntity invoice) {
  if (invoice.isCreditNote) return l10n.invoiceCreditNote;
  switch (invoice.status) {
    case InvoiceStatus.open:
      return invoice.isOverdue ? l10n.invoiceStatusOverdue : l10n.invoiceStatusOpen;
    case InvoiceStatus.paid:
      return l10n.invoiceStatusPaid;
    case InvoiceStatus.voided:
      return l10n.invoiceStatusVoid;
    case InvoiceStatus.draft:
    case InvoiceStatus.uncollectible:
    case InvoiceStatus.unknown:
      return l10n.invoiceStatusOther;
  }
}

Color invoiceTone(InvoiceEntity invoice) {
  if (invoice.isCreditNote) return ColorManager.info;
  switch (invoice.status) {
    case InvoiceStatus.open:
      return invoice.isOverdue ? ColorManager.error : ColorManager.warning;
    case InvoiceStatus.paid:
      return ColorManager.success;
    case InvoiceStatus.voided:
    case InvoiceStatus.draft:
    case InvoiceStatus.uncollectible:
    case InvoiceStatus.unknown:
      return ColorManager.gray500;
  }
}

String paymentStatusLabel(AppLocalizations l10n, ClinicPaymentStatus status) {
  switch (status) {
    case ClinicPaymentStatus.pending:
      return l10n.paymentStatusPending;
    case ClinicPaymentStatus.verified:
      return l10n.paymentStatusVerified;
    case ClinicPaymentStatus.rejected:
      return l10n.paymentStatusRejected;
    case ClinicPaymentStatus.cancelled:
      return l10n.paymentStatusCancelled;
    case ClinicPaymentStatus.unknown:
      return l10n.invoiceStatusOther;
  }
}

Color paymentTone(ClinicPaymentStatus status) {
  switch (status) {
    case ClinicPaymentStatus.pending:
      return ColorManager.warning;
    case ClinicPaymentStatus.verified:
      return ColorManager.success;
    case ClinicPaymentStatus.rejected:
      return ColorManager.error;
    case ClinicPaymentStatus.cancelled:
    case ClinicPaymentStatus.unknown:
      return ColorManager.gray500;
  }
}

/// The payment method's own name when the methods list is at hand, else a
/// readable form of the code (`SHAM_CASH` -> `Sham Cash`).
String paymentMethodLabel(String method, [Map<String, String>? names]) {
  final known = names?[method];
  if (known != null && known.isNotEmpty) return known;
  return method
      .split('_')
      .where((p) => p.isNotEmpty)
      .map((p) => p[0] + p.substring(1).toLowerCase())
      .join(' ');
}

String billingPeriodLabel(
  AppLocalizations l10n,
  BillingPeriod? period,
  int quantity,
) {
  switch (period) {
    case BillingPeriod.monthly:
      return l10n.billingMonthsCount(quantity);
    case BillingPeriod.yearly:
      return l10n.billingYearsCount(quantity);
    case null:
      return l10n.freeTrial;
  }
}

/// A figure to transfer: the first currency large, the rest beneath it.
class AmountsView extends StatelessWidget {
  const AmountsView({super.key, required this.amounts, this.fallbackUsd});

  final List<PriceEntity> amounts;

  /// Shown when the server priced nothing - a paid invoice, say.
  final double? fallbackUsd;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final lines = amounts.map((a) => a.display).toList();
    if (lines.isEmpty && fallbackUsd != null) lines.add(formatUsd(fallbackUsd!));
    if (lines.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          lines.first,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontFamily: family,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: c.textPrimary,
          ),
        ),
        for (final other in lines.skip(1))
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              other,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontFamily: family,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: c.textSecondary,
              ),
            ),
          ),
      ],
    );
  }
}

/// Label on the start side, value on the end side, one line of a summary.
class BillingInfoRow extends StatelessWidget {
  const BillingInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.valueTone,
    this.ltrValue = false,
  });

  final String label;
  final String value;
  final Color? valueTone;

  /// For account numbers, references and money, which read left to right in
  /// Arabic too.
  final bool ltrValue;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: family,
                fontSize: 12.sp,
                color: c.textTertiary,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Flexible(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.end,
              textDirection: ltrValue ? TextDirection.ltr : null,
              style: TextStyle(
                fontFamily: family,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
                color: valueTone ?? c.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The lines of an invoice or a quote, with the total underneath.
class BillingLinesView extends StatelessWidget {
  const BillingLinesView({super.key, required this.lines, required this.total});

  final List<BillingLineEntity> lines;
  final double total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final line in lines)
          BillingInfoRow(
            label: line.description,
            value: formatUsd(line.amountUsd),
            ltrValue: true,
          ),
        Divider(color: c.borderLight, height: 14.h),
        BillingInfoRow(
          label: l10n.billingTotalUsd,
          value: formatUsd(total),
          ltrValue: true,
        ),
      ],
    );
  }
}

/// Loads one thing and shows it, for the read-only billing pages: a shimmer
/// while the request is out, the server's reason with a retry when it fails,
/// and pull-to-refresh once it has landed.
class BillingAsync<T> extends StatefulWidget {
  const BillingAsync({
    super.key,
    required this.load,
    required this.builder,
  });

  final Future<Either<NetworkExceptions, T>> Function() load;

  /// [reload] refetches in place, for after an action on the page.
  final Widget Function(BuildContext context, T value, Future<void> Function() reload)
      builder;

  @override
  State<BillingAsync<T>> createState() => _BillingAsyncState<T>();
}

class _BillingAsyncState<T> extends State<BillingAsync<T>> {
  T? _value;
  NetworkExceptions? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  Future<void> _reload() async {
    final result = await widget.load();
    if (!mounted) return;
    setState(() {
      _loading = false;
      result.fold(
        (error) => _error = error,
        (value) {
          _value = value;
          _error = null;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_loading) return const BillingListSkeleton();

    final value = _value;
    if (value == null) {
      return ListView(
        padding: EdgeInsets.all(14.w),
        children: [
          StateCard(
            icon: Icons.cloud_off_outlined,
            tone: ColorManager.error,
            title: l10n.billingLoadFailed,
            message: _error == null
                ? null
                : NetworkExceptions.localizedMessage(context, _error!),
            actionLabel: l10n.retry,
            onAction: () {
              setState(() => _loading = true);
              _reload();
            },
          ),
        ],
      );
    }

    return DentaRefresh(
      onRefresh: _reload,
      child: widget.builder(context, value, _reload),
    );
  }
}

/// A header block and a few rows in shimmer, so a billing page keeps its
/// shape while its request is out.
class BillingListSkeleton extends StatelessWidget {
  const BillingListSkeleton({super.key, this.rows = 3});

  final int rows;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    Widget block(double height) => Container(
          height: height,
          decoration: BoxDecoration(
            color: c.cardBg,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: c.borderLight),
          ),
        );

    return AppShimmer(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h),
        children: [
          block(110.h),
          SizedBox(height: 16.h),
          ShimmerBox(width: 130.w, height: 13.h),
          SizedBox(height: 10.h),
          for (var i = 0; i < rows; i++) ...[
            if (i > 0) SizedBox(height: 8.h),
            block(72.h),
          ],
        ],
      ),
    );
  }
}
