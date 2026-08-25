/// Audit trail entry attached to many API responses (expenses,
/// appointments, cases, patients, invitations, clinic users, treatment
/// plan items, etc).
///
/// The backend appends one entry per significant action — `CREATE` is
/// always present; future events (`UPDATE`, `DELETE`, etc.) will arrive
/// in the same shape. UI today only surfaces the CREATE entry via
/// `AddedByLabel`, but the full list is parsed and stored on each
/// entity so we can show edit history later without re-touching every
/// model.
class AuditEntry {
  const AuditEntry({
    required this.id,
    required this.event,
    required this.userId,
    required this.userFullname,
  });

  final String id;

  /// Raw event string from the API ("CREATE", "UPDATE", …). Kept as a
  /// String (not an enum) so a new event type from the backend doesn't
  /// crash deserialization.
  final String event;
  final String userId;
  final String userFullname;

  bool get isCreate => event.toUpperCase() == 'CREATE';
  bool get isUpdate => event.toUpperCase() == 'UPDATE';

  factory AuditEntry.fromJson(Map<String, dynamic> json) {
    return AuditEntry(
      id: (json['id'] ?? '').toString(),
      event: (json['event'] ?? '').toString(),
      userId: (json['user_id'] ?? '').toString(),
      userFullname: (json['user_fullname'] ?? '').toString(),
    );
  }

  /// Convenience: tolerant parse of the `audits` array. Accepts null
  /// or missing keys and returns an empty list, so callers can pass
  /// `AuditEntry.listFromJson(json['audits'])` unconditionally.
  static List<AuditEntry> listFromJson(dynamic raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map<String, dynamic>>()
        .map(AuditEntry.fromJson)
        .toList(growable: false);
  }
}
