part of 'billing_bloc.dart';

@freezed
class BillingEvent with _$BillingEvent {
  /// Fetch invoices for the clinic.
  const factory BillingEvent.loadInvoices(String clinicId) = _LoadInvoices;

  /// Generate a new pending invoice for the chosen plan + cycle.
  const factory BillingEvent.createInvoice({
    required String clinicId,
    required SubscriptionPlanEntity plan,
    required BillingCycle cycle,
    @Default(false) bool isRenewal,
  }) = _CreateInvoice;

  /// Set the invoice the user is currently viewing.
  const factory BillingEvent.selectInvoice(InvoiceEntity invoice) =
      _SelectInvoice;

  /// Attach payment proof — flips the invoice to underReview.
  const factory BillingEvent.submitProof({
    required String invoiceId,
    required File receipt,
    required String referenceNumber,
    required ManualPaymentMethod method,
    String? notes,
  }) = _SubmitProof;

  /// Reset one-shot flags after the UI has consumed them.
  const factory BillingEvent.clearFlags() = _ClearFlags;

  /// Admin action — flips the invoice to paid and activates the clinic
  /// subscription. Today this is wired to a debug button on the dentist
  /// app; in production it lives on the admin side and the dentist's app
  /// receives the update through the change stream.
  const factory BillingEvent.adminApproveInvoice(String invoiceId) =
      _AdminApproveInvoice;

  /// Admin action — rejects the invoice with an optional reason.
  const factory BillingEvent.adminRejectInvoice({
    required String invoiceId,
    String? reason,
  }) = _AdminRejectInvoice;

  /// Internal — emitted by the repository's change stream.
  const factory BillingEvent.invoiceMutated(InvoiceEntity invoice) =
      _InvoiceMutated;
}
