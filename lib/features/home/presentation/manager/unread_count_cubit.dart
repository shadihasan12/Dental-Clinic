import 'dart:async';

import 'package:dental_clinic_app/core/services/notifications/notification_service.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/home/domain/use_cases/get_unread_count_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// The badge number, shared by everything that shows it (today the home
/// header's bell).
///
/// A singleton on purpose: the count is a property of the account, not of any
/// one screen, and several responses carry a fresh value. Every endpoint that
/// returns `unread_count` — the list, read, unread, read-all — feeds it
/// through [set], so the badge stays current without its own request.
///
/// [refresh] exists for the cases where nothing else just returned a count:
/// app launch, sign-in, and returning to the foreground.
@lazySingleton
class UnreadCountCubit extends Cubit<int> {
  UnreadCountCubit({
    required GetUnreadCountUseCase getUnreadCount,
    required TokenStorage tokenStorage,
    required NotificationService notificationService,
  })  : _getUnreadCount = getUnreadCount,
        _tokenStorage = tokenStorage,
        super(0) {
    // A push that arrives while the app is open bumps the badge immediately;
    // the next response carrying `unread_count` corrects it if it drifts.
    _pushSubscription =
        notificationService.onPushReceived.listen((_) => emit(state + 1));
  }

  final GetUnreadCountUseCase _getUnreadCount;
  final TokenStorage _tokenStorage;
  StreamSubscription<void>? _pushSubscription;

  /// Adopt a count that just came back on another response.
  void set(int count) {
    if (isClosed) return;
    final next = count < 0 ? 0 : count;
    if (next != state) emit(next);
  }

  /// Pull the count on its own — `GET /notifications/unread-count`.
  Future<void> refresh() async {
    // The endpoint is authenticated; signed out there is nothing to count.
    if (!_tokenStorage.hasToken()) {
      set(0);
      return;
    }
    final result = await _getUnreadCount(NoParams());
    result.fold((_) {/* keep the last known value */}, set);
  }

  /// Signed-out state: no account, no badge.
  void clear() => set(0);

  @override
  Future<void> close() async {
    await _pushSubscription?.cancel();
    return super.close();
  }
}
