import 'dart:async';

import 'package:dental_clinic_app/services/subscription_guard/access_mode.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

/// A 402 the server just sent, for the one handler that reacts to it.
class PaymentRequiredNotice {
  const PaymentRequiredNotice({
    required this.message,
    required this.mode,
    this.subscriptionStatus,
  });

  /// Already translated by the server, written to be shown as it is.
  final String message;
  final AccessMode mode;
  final String? subscriptionStatus;
}

/// Single source of truth for "what may this clinic do right now?".
///
/// Holds the clinic's [AccessMode], fed from three places: the permissions
/// call (`meta.access_mode`), the status call, and every 402 the
/// [AuthInterceptor] sees. The last is why this cannot wait for the next
/// permissions call - a 402 is the server saying the cached mode is stale.
///
/// A process-wide singleton with no dependencies, so the interceptor can
/// write to it without a dependency cycle through the API client.
@lazySingleton
class SubscriptionGuard {
  /// The current mode. Listen to it to rebuild on a change.
  final ValueNotifier<AccessMode> mode = ValueNotifier(AccessMode.unknown);

  /// The raw status that came with [mode], e.g. `EXPIRED`.
  String? subscriptionStatus;

  /// The server's own sentence from the last 402, shown on the lock screen.
  String? lastMessage;

  final StreamController<PaymentRequiredNotice> _notices =
      StreamController.broadcast();

  /// One event per 402 received.
  Stream<PaymentRequiredNotice> get notices => _notices.stream;

  AccessMode get current => mode.value;

  /// True if create/edit/delete actions should be offered right now.
  bool get isActive => current.canWrite;

  bool get isReadOnly => current == AccessMode.readOnly;

  bool get isLocked => current.isLocked;

  /// Records what the server said. A null [accessMode] leaves the mode as it
  /// is - not every response carries one.
  void update({String? accessMode, String? status}) {
    if (accessMode == null) return;
    subscriptionStatus = status ?? subscriptionStatus;
    mode.value = AccessMode.fromApi(accessMode);
  }

  /// Called by the interceptor on every 402.
  void reportPaymentRequired({
    required String message,
    String? accessMode,
    String? status,
  }) {
    update(accessMode: accessMode, status: status);
    if (message.isNotEmpty) lastMessage = message;
    _notices.add(PaymentRequiredNotice(
      message: message,
      mode: current,
      subscriptionStatus: status ?? subscriptionStatus,
    ));
  }

  /// Forgets the previous clinic's mode on a clinic switch or a logout, so
  /// one clinic's lock never leaks onto another.
  void reset() {
    subscriptionStatus = null;
    lastMessage = null;
    mode.value = AccessMode.unknown;
  }
}
