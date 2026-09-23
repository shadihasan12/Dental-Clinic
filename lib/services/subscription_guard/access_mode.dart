/// What the clinic's subscription allows right now.
///
/// The backend derives it from the subscription's status in one place and
/// returns it from `/subscriptions/status`, `/features/clinic-permissions`
/// and inside `meta` on every 402. The app decides what to enable from this,
/// never from the raw status.
enum AccessMode {
  /// TRIALING: everything the plan grants that is flagged for the trial.
  trial,

  /// ACTIVE or GRACE: everything the plan grants.
  full,

  /// EXPIRED: reads only. Every write outside billing answers 402.
  readOnly,

  /// PENDING_ACTIVATION or CANCELED: the subscription and payment screens,
  /// nothing else - not even reads.
  billingOnly,

  /// No subscription row at all. Nothing works, not even paying.
  none,

  /// Not heard from the server yet (or a value this build does not know).
  /// Treated as permissive: the server is the one that refuses.
  unknown;

  static AccessMode fromApi(String? value) {
    switch (value) {
      case 'trial':
        return AccessMode.trial;
      case 'full':
        return AccessMode.full;
      case 'read_only':
        return AccessMode.readOnly;
      case 'billing_only':
        return AccessMode.billingOnly;
      case 'none':
        return AccessMode.none;
      default:
        return AccessMode.unknown;
    }
  }

  /// Creates, edits and deletes outside billing are allowed.
  bool get canWrite =>
      this == AccessMode.trial ||
      this == AccessMode.full ||
      this == AccessMode.unknown;

  /// Nothing but the subscription screen is reachable.
  bool get isLocked =>
      this == AccessMode.billingOnly || this == AccessMode.none;
}
