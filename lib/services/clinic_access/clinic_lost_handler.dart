import 'dart:async';

import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/routes_manager.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/get_my_clinics_use_case.dart';
import 'package:dental_clinic_app/features/root/presentation/pages/root_page.dart';
import 'package:dental_clinic_app/services/clinic_access/clinic_access_guard.dart';
import 'package:dental_clinic_app/services/permissions/root_tabs.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

/// What the "no longer a member" screen shows.
class ClinicLostArgs {
  const ClinicLostArgs({this.title, this.message, this.clinicName});

  /// The notice's own title and body; null after a refusal, where the screen
  /// falls back to neutral copy naming [clinicName].
  final String? title;
  final String? message;
  final String? clinicName;
}

/// The one place the app reacts to losing a clinic.
///
/// The open clinic: the user is taken out of it straight away - its
/// selection and cached role dropped, the lock it may have had forgotten -
/// and put on a screen they cannot back out of into it, which offers the
/// clinics they still have.
///
/// Any other clinic - a notice about one they do not have open, or a late
/// answer to a request sent before a switch: nothing interrupts them. The
/// cached clinic count is brought up to date, and that is all.
@lazySingleton
class ClinicLostHandler {
  ClinicLostHandler(
    this._guard,
    this._tokenStorage,
    this._userStorage,
    this._subscriptionGuard,
    this._getMyClinics,
  );

  final ClinicAccessGuard _guard;
  final TokenStorage _tokenStorage;
  final UserStorage _userStorage;
  final SubscriptionGuard _subscriptionGuard;
  final GetMyClinicsUseCase _getMyClinics;
  StreamSubscription<ClinicLossNotice>? _subscription;

  void start() {
    _subscription ??= _guard.losses.listen(_onLoss);
  }

  Future<void> _onLoss(ClinicLossNotice notice) async {
    if (!_tokenStorage.hasToken()) return;

    if (notice.clinicId != _tokenStorage.getClinicId()) {
      unawaited(_refreshClinicCount());
      return;
    }

    // A notice can be old - an inbox row about a clinic the user was added
    // back to since. The refusal is the server saying it now; a notice is
    // checked against the list first, and a failed check counts as lost.
    if (notice.source != ClinicLossSource.refusal) {
      final result = await _getMyClinics();
      final stillMember = result.fold(
        (_) => false,
        (clinics) => clinics.any((m) => m.clinicId == notice.clinicId),
      );
      if (stillMember) {
        _guard.forget(notice.clinicId);
        return;
      }
      // Switched away while that was being checked: nothing to leave.
      if (notice.clinicId != _tokenStorage.getClinicId()) return;
    }

    await _leaveOpenClinic(notice);
  }

  Future<void> _leaveOpenClinic(ClinicLossNotice notice) async {
    _guard.leavingOpenClinic = true;
    final clinicName = _userStorage.getClinicName();

    // Every later request goes out without the clinic, so nothing more is
    // asked of it; the answers still on their way are refused and dropped.
    await _tokenStorage.clearClinicId();
    await _userStorage.clearActiveClinic();
    _subscriptionGuard.reset();
    RootPage.selectedTab.value = RootTab.home.index;
    UserStorage.notifyProfileUpdated();

    final args = ClinicLostArgs(
      title: notice.title,
      message: notice.body,
      clinicName: clinicName,
    );

    // May be reached from an interceptor mid-frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = rootNavigatorKey.currentContext;
      if (context == null) return;
      // `go`, not `push`: the clinic's whole stack goes, so its pages stop
      // loading and nothing is left to go back to.
      GoRouter.of(context).goNamed(AppRoutesNames.clinicLost, extra: args);
    });
  }

  Future<void> _refreshClinicCount() async {
    final result = await _getMyClinics();
    result.fold(
      (_) {},
      (clinics) => _userStorage.saveClinicCount(clinics.length),
    );
  }
}
