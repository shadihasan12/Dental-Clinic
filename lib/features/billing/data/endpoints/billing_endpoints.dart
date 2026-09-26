/// Every billing call the app makes. Nothing in the billing surface is
/// paginated except the plans list, which lives with the auth endpoints.
class BillingEndpoints {
  BillingEndpoints._();

  /// GET - the cycles this clinic has been through (the history screen).
  static const String periods = '/subscriptions/periods';

  /// GET - what a whole cycle would cost - new, or a renewal - and whether
  /// the app may ask.
  static const String quote = '/subscriptions/quote';

  /// POST - ask to be billed for it. Creates an invoice, not a subscription.
  static const String requests = '/subscriptions/requests';

  /// GET / POST - moving up to a bigger plan now, for the rest of the cycle.
  static const String upgradeQuote = '/subscriptions/upgrade/quote';
  static const String upgradeRequests = '/subscriptions/upgrade/requests';

  /// GET - the add-ons on sale, and the units the clinic holds.
  static const String addons = '/subscriptions/addons';

  /// GET / POST - more add-on units now, for the rest of the cycle.
  static const String addonsQuote = '/subscriptions/addons/quote';
  static const String addonsRequests = '/subscriptions/addons/requests';

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
}
