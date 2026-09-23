/// Every billing call the app makes. Nothing in the billing surface is
/// paginated except the plans list, which lives with the auth endpoints.
class BillingEndpoints {
  BillingEndpoints._();

  /// GET - the cycles this clinic has been through (the history screen).
  static const String periods = '/subscriptions/periods';

  /// GET - what buying a plan would cost, and whether the app may ask.
  static const String quote = '/subscriptions/quote';

  /// POST - ask to be billed. Creates an OPEN invoice, not a subscription.
  static const String requests = '/subscriptions/requests';

  /// GET - what one plan includes. Takes the plan id or the version id.
  static String planFeatures(String planId) => '/plans/$planId/features';

  /// GET - what was billed, newest first.
  static const String invoices = '/invoices';
  static String invoice(String id) => '/invoices/$id';

  /// GET - where to send money.
  static const String paymentMethods = '/billing/payment-methods';

  /// POST multipart - the transfer slip. Not `/media-items`: that is behind
  /// the media feature, which an expired clinic no longer has.
  static const String receipts = '/clinic-payments/receipts';

  /// POST - report a transfer (PENDING). GET - every reported transfer.
  static const String payments = '/clinic-payments';
  static String payment(String id) => '/clinic-payments/$id';
  static String cancelPayment(String id) => '/clinic-payments/$id/cancel';

  /// GET - the current clinic, carrying `credit_balance_usd` (the wallet)
  /// for an admin. Needs the clinic header, unlike `/users/clinics`.
  static const String clinic = '/clinics';
}
