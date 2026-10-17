import 'dart:async';

import 'package:injectable/injectable.dart';

/// Why the app learnt that a clinic is no longer the user's.
enum ClinicLossSource {
  /// A request for it answered 403 `meta.reason: not_clinic_member`. Says
  /// nothing about why - removed, closed, or never theirs.
  refusal,

  /// A `clinic_removed` push or inbox notice.
  removed,

  /// A `clinic_closed` push or inbox notice.
  closed,
}

/// One clinic the user just lost, for the one handler that reacts to it.
class ClinicLossNotice {
  const ClinicLossNotice({
    required this.clinicId,
    required this.source,
    this.title,
    this.body,
  });

  final String clinicId;
  final ClinicLossSource source;

  /// The notice's own title and body, in the user's language. Null for a
  /// refusal, whose screen uses neutral copy instead.
  final String? title;
  final String? body;
}

/// Where the app learns that a clinic stopped being the user's - taken out
/// of its staff, or the clinic closed.
///
/// Two signals feed it, and both are needed: the push is the fast one, the
/// refusal the sure one (a push can be switched off or never arrive; the
/// first request for the clinic always answers). The auth interceptor
/// reports every refusal, the notification wiring every notice.
///
/// Each clinic is reported once. A screen loads several lists together, and
/// all of them are refused at the same moment; only the first may start the
/// flow. A clinic the user is later added back to is [forget]-ed when it is
/// selected again, so a new loss of it is reported afresh.
///
/// A process-wide singleton with no dependencies, so the interceptor can
/// write to it without a cycle through the API client.
@lazySingleton
class ClinicAccessGuard {
  final StreamController<ClinicLossNotice> _losses =
      StreamController.broadcast();

  final Set<String> _reported = {};

  /// One event per clinic lost.
  Stream<ClinicLossNotice> get losses => _losses.stream;

  /// True while the user is being taken out of the open clinic: the
  /// requests still in flight for it fail, and their errors are not worth
  /// showing on top of the screen that explains why.
  bool leavingOpenClinic = false;

  /// From the auth interceptor: a request sent for [clinicId] was refused
  /// because the user is not a member of it.
  void reportRefusal(String clinicId) =>
      _report(ClinicLossNotice(
        clinicId: clinicId,
        source: ClinicLossSource.refusal,
      ));

  /// From a `clinic_removed` / `clinic_closed` push or inbox row.
  void reportNotice({
    required String clinicId,
    required bool closed,
    String? title,
    String? body,
  }) =>
      _report(ClinicLossNotice(
        clinicId: clinicId,
        source: closed ? ClinicLossSource.closed : ClinicLossSource.removed,
        title: title,
        body: body,
      ));

  void _report(ClinicLossNotice notice) {
    if (notice.clinicId.isEmpty || !_reported.add(notice.clinicId)) return;
    _losses.add(notice);
  }

  /// The user selected [clinicId] again - added back to it. A later loss of
  /// it must start the flow again.
  void forget(String clinicId) => _reported.remove(clinicId);

  /// A new session starts from nothing.
  void reset() {
    _reported.clear();
    leavingOpenClinic = false;
  }
}
