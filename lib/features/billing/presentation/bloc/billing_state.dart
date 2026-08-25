part of 'billing_bloc.dart';

@freezed
class BillingState with _$BillingState {
  const factory BillingState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    @Default([]) List<InvoiceEntity> invoices,
    String? clinicId,
    InvoiceEntity? activeInvoice,
    PaymentInstructions? activeInstructions,
    String? error,

    // One-shot flags consumed by the UI in BlocListener.
    InvoiceEntity? createdInvoice,
    @Default(false) bool proofSubmitted,
  }) = _BillingState;

  const BillingState._();

  /// Most recent open invoice — drives the "you have an unpaid invoice"
  /// surfaces on the billing dashboard.
  InvoiceEntity? get latestOpen {
    for (final i in invoices) {
      if (i.isOpen) return i;
    }
    return null;
  }
}
