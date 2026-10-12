/// Audit trail entry attached to many API responses (expenses,
/// appointments, cases, patients, invitations, clinic users, treatment
/// plan items, etc).
///
/// The backend appends one entry per significant action — `CREATE` is
/// always present; future events (`UPDATE`, `DELETE`, etc.) will arrive
/// in the same shape. Most of the UI only surfaces the CREATE entry via
/// `AddedByLabel` - a case payment lists its whole history - but the
/// full list is parsed and stored on each entity so we can show edit
/// history later without re-touching every model.
class AuditEntry {
  const AuditEntry({
    required this.id,
    required this.event,
    required this.userId,
    required this.userFullname,
    this.createdAt,
    this.oldValues,
    this.newValues,
  });

  final String id;

  /// Raw event string from the API ("CREATE", "UPDATE", …). Kept as a
  /// String (not an enum) so a new event type from the backend doesn't
  /// crash deserialization.
  final String event;
  final String userId;
  final String userFullname;

  /// When the action happened. Null where the API leaves it out.
  final DateTime? createdAt;

  /// What the record held before the action and after it, keyed by the
  /// API's own field names and left raw - a figure arrives as a number or
  /// as a string, and only the model that owns the record knows which keys
  /// are figures.
  ///
  /// On `CREATE`, [oldValues] is null and [newValues] holds what was
  /// recorded; on `UPDATE`, both hold only the fields that changed.
  final Map<String, dynamic>? oldValues;
  final Map<String, dynamic>? newValues;

  bool get isCreate => event.toUpperCase() == 'CREATE';
  bool get isUpdate => event.toUpperCase() == 'UPDATE';

  /// The account behind the action has since been deleted: the API then
  /// sends a single space where the name was.
  bool get isDeletedUser => userFullname.trim().isEmpty;

  factory AuditEntry.fromJson(Map<String, dynamic> json) {
    final oldValues = json['old_values'];
    final newValues = json['new_values'];
    return AuditEntry(
      id: (json['id'] ?? '').toString(),
      event: (json['event'] ?? '').toString(),
      userId: (json['user_id'] ?? '').toString(),
      userFullname: (json['user_fullname'] ?? '').toString(),
      createdAt: DateTime.tryParse((json['created_at'] ?? '').toString()),
      oldValues: oldValues is Map<String, dynamic> ? oldValues : null,
      newValues: newValues is Map<String, dynamic> ? newValues : null,
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
