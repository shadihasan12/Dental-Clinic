import 'dart:async';

import 'package:dental_clinic_app/features/subscription/domain/entities/user_subscription_entity.dart';
import 'package:injectable/injectable.dart';

/// Single source of truth for "is this clinic allowed to use premium
/// features right now?". Other parts of the app (FABs, write actions)
/// query this gate before performing the action.
///
/// The gate starts populated with a mock trial subscription so dev builds
/// behave exactly like today (write actions allowed). Once the real
/// subscription is loaded — whether from the [SubscriptionBloc] or a future
/// remote sync — call [update] with the entity and the gate flips to that.
///
/// Why a separate service rather than reading the bloc directly? The bloc
/// is registered as a factory and lives at the page level, so different
/// screens see different instances. The gate is a process-wide singleton
/// so any code path can ask `isActive` without needing a BlocProvider in
/// scope.
@lazySingleton
class SubscriptionGuard {
  SubscriptionGuard() {
    // Default to a fresh trial — matches the mocked behavior of
    // SubscriptionBloc._onLoadSubscription. Replace with `null` (or a
    // remote check) once real subscriptions are live.
    _current = TrialConfig.createTrial(userId: 'mock_user');
    _controller.add(_current);
  }

  UserSubscriptionEntity? _current;
  final StreamController<UserSubscriptionEntity?> _controller =
      StreamController.broadcast();

  UserSubscriptionEntity? get current => _current;

  Stream<UserSubscriptionEntity?> get stream => _controller.stream;

  /// True if write/premium actions should be allowed right now.
  bool get isActive => _current?.isValid ?? false;

  /// Inverse convenience for read-only banners.
  bool get isReadOnly => !isActive;

  /// Call after every load/transition of the user's subscription.
  void update(UserSubscriptionEntity? subscription) {
    _current = subscription;
    _controller.add(subscription);
  }

  /// Debug-only: simulate an expired subscription so the read-only path
  /// can be demoed without touching the system clock.
  void debugForceExpired() {
    final now = DateTime.now();
    _current = (_current ?? TrialConfig.createTrial(userId: 'mock_user'))
        .copyWith(
      status: SubscriptionStatus.expired,
      currentPeriodEnd: now.subtract(const Duration(days: 1)),
    );
    _controller.add(_current);
  }
}
