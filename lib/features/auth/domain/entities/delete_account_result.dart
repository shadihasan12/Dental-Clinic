/// What the backend scheduled when the account deletion was accepted.
///
/// Deletion is a 30-day soft delete: the account stops working immediately,
/// and signing back in during the window cancels it. The dates come from the
/// server rather than being computed here, because the clock that decides
/// when the data is actually purged is the server's.
class DeleteAccountResult {
  const DeleteAccountResult({this.purgeAt, this.recoveryDays});

  /// When the data is destroyed for good. Null when the server did not say -
  /// the confirmation then talks about the window in days, or not at all.
  final DateTime? purgeAt;

  /// Length of the recovery window. Null when the server did not say.
  final int? recoveryDays;

  factory DeleteAccountResult.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final map = data is Map<String, dynamic> ? data : const <String, dynamic>{};

    final rawPurge = map['purge_at'];
    final rawDays = map['recovery_days'];

    return DeleteAccountResult(
      purgeAt: rawPurge is String ? DateTime.tryParse(rawPurge) : null,
      recoveryDays: rawDays is num
          ? rawDays.toInt()
          : (rawDays is String ? int.tryParse(rawDays) : null),
    );
  }
}
