class SubscriptionEndpoints {
  SubscriptionEndpoints._();

  /// GET - where the subscription stands, with its dates and `access_mode`.
  static const String status = '/subscriptions/status';

  /// GET - seats and storage used vs allowed.
  static const String usage = '/subscriptions/usage';
}
