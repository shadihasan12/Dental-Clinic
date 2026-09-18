/// What `GET /auth/account/deletion-preview` says deleting this account will
/// do, and the reasons the user may pick from.
///
/// Read-only and informational. Nothing here is sent back: the server acts on
/// the real state at deletion time, not on these numbers, so they exist to
/// let the user read what they are agreeing to before they agree to it -
/// which is the part both stores actually require.
///
/// Deliberately not cached. A colleague can book an appointment between the
/// screen opening and the button being pressed, and a stale "3 appointments
/// will be cancelled" is worse than a fresh one that costs a request.
class AccountDeletionPreview {
  const AccountDeletionPreview({
    required this.canDelete,
    required this.reasons,
    required this.clinicsToClose,
    required this.clinicsToLeave,
    required this.cancelledAppointments,
    required this.archivedCases,
    required this.cancelledSentInvitations,
  });

  /// False only for a super-admin token, which never reaches this app in
  /// practice. When false the form is not shown at all - the delete call
  /// would answer 403.
  final bool canDelete;

  /// Always the full list, in the server's order, already translated into the
  /// language the request asked for. Never build these labels locally.
  final List<AccountDeletionReason> reasons;

  /// Clinics the user owns. Each one closes with the account, taking its
  /// staff, appointments and cases with it.
  final List<ClinicToClose> clinicsToClose;

  /// Clinics the user only works in. These keep running; the user leaves.
  final List<ClinicToLeave> clinicsToLeave;

  final int cancelledAppointments;
  final int archivedCases;
  final int cancelledSentInvitations;

  /// Whether the user owns anything, which is what decides how severe the
  /// disclosure has to read: leaving a clinic and closing one are not the
  /// same act and must not share a sentence.
  bool get closesClinics => clinicsToClose.isNotEmpty;

  /// The owned clinic the copy talks about. The backend allows more than one,
  /// but a single owner with two clinics is rare enough that the screen names
  /// the first and counts the rest.
  ClinicToClose? get primaryOwnedClinic =>
      clinicsToClose.isEmpty ? null : clinicsToClose.first;

  factory AccountDeletionPreview.fromJson(Map<String, dynamic> json) {
    List<T> listOf<T>(Object? raw, T Function(Map<String, dynamic>) parse) {
      if (raw is! List) return const [];
      return raw
          .whereType<Map>()
          .map((e) => parse(Map<String, dynamic>.from(e)))
          .toList();
    }

    return AccountDeletionPreview(
      // Absent reads as true: the form refusing to appear because a field was
      // missing would be a worse failure than a delete call that comes back
      // 403 with an explanation.
      canDelete: json['can_delete'] is bool ? json['can_delete'] as bool : true,
      reasons: listOf(json['reasons'], AccountDeletionReason.fromJson),
      clinicsToClose: listOf(json['clinics_to_close'], ClinicToClose.fromJson),
      clinicsToLeave: listOf(json['clinics_to_leave'], ClinicToLeave.fromJson),
      cancelledAppointments: _int(json['will_be_cancelled_appointments']),
      archivedCases: _int(json['will_be_archived_cases']),
      cancelledSentInvitations: _int(
        json['will_be_cancelled_sent_invitations'],
      ),
    );
  }
}

/// One entry of the reason picker.
class AccountDeletionReason {
  const AccountDeletionReason({
    required this.value,
    required this.label,
    required this.needsNote,
  });

  /// The enum string echoed back as `reason`. Case-sensitive; never the label.
  final String value;

  /// Display text, already in the caller's language.
  final String label;

  /// True only for `OTHER`. The backend does not enforce the note, so this
  /// reveals the field rather than gating the button - a user who wants out
  /// should not be held there by a survey.
  final bool needsNote;

  factory AccountDeletionReason.fromJson(Map<String, dynamic> json) =>
      AccountDeletionReason(
        value: json['value'] as String? ?? '',
        label: json['label'] as String? ?? '',
        needsNote: json['needs_note'] as bool? ?? false,
      );
}

/// A clinic the user owns, which closes entirely.
class ClinicToClose {
  const ClinicToClose({
    required this.id,
    required this.name,
    required this.type,
    required this.membersCount,
  });

  final String id;
  final String name;

  /// `INDIVIDUAL` or `CENTER`. A one-person clinic closing and a staffed
  /// center closing warrant different wording, so the type is kept rather
  /// than inferred from the member count.
  final String type;

  /// Everyone in the clinic, the user included. 1 means they are alone.
  final int membersCount;

  bool get isCenter => type.toUpperCase() == 'CENTER';

  /// Members other than the user - what the warning counts, since the user
  /// already knows they are leaving.
  int get otherMembers => membersCount > 1 ? membersCount - 1 : 0;

  factory ClinicToClose.fromJson(Map<String, dynamic> json) => ClinicToClose(
    id: json['clinic_id'] as String? ?? '',
    name: json['name'] as String? ?? '',
    type: json['type'] as String? ?? '',
    membersCount: _int(json['members_count']),
  );
}

/// A clinic the user is only a member of, which carries on without them.
class ClinicToLeave {
  const ClinicToLeave({required this.id, required this.name});

  final String id;
  final String name;

  factory ClinicToLeave.fromJson(Map<String, dynamic> json) => ClinicToLeave(
    id: json['clinic_id'] as String? ?? '',
    name: json['name'] as String? ?? '',
  );
}

int _int(Object? raw) {
  if (raw is num) return raw.toInt();
  if (raw is String) return int.tryParse(raw) ?? 0;
  return 0;
}
