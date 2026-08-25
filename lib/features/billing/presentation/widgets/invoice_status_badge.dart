import 'package:dental_clinic_app/custom_widgets/status_badge.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class InvoiceStatusBadge extends StatelessWidget {
  const InvoiceStatusBadge({super.key, required this.status});

  final InvoiceStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return StatusBadge(
      label: _label(status, l10n),
      type: _type(status),
      showDot: true,
    );
  }

  static String _label(InvoiceStatus status, AppLocalizations l10n) {
    switch (status) {
      case InvoiceStatus.pending:
        return l10n.invoiceStatusPending;
      case InvoiceStatus.underReview:
        return l10n.invoiceStatusUnderReview;
      case InvoiceStatus.paid:
        return l10n.invoiceStatusPaid;
      case InvoiceStatus.rejected:
        return l10n.invoiceStatusRejected;
      case InvoiceStatus.cancelled:
        return l10n.invoiceStatusCancelled;
    }
  }

  static StatusType _type(InvoiceStatus status) {
    switch (status) {
      case InvoiceStatus.pending:
        return StatusType.pending;
      case InvoiceStatus.underReview:
        return StatusType.inProgress;
      case InvoiceStatus.paid:
        return StatusType.success;
      case InvoiceStatus.rejected:
        return StatusType.error;
      case InvoiceStatus.cancelled:
        return StatusType.inactive;
    }
  }
}
