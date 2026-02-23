class SubscriptionEndpoints {
  SubscriptionEndpoints._();

  static const String plans = '/subscription/plans';
  static const String subscribe = '/subscription/subscribe';
  static const String cancel = '/subscription/cancel';
  static String subscription(String userId) => '/subscription/$userId';
}
