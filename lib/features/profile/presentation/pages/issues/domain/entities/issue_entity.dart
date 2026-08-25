import 'package:freezed_annotation/freezed_annotation.dart';

part 'issue_entity.freezed.dart';

/// Where a report has got to. The server owns this value; the app never
/// sets it, it only renders it.
enum IssueStatus {
  /// Received, nobody has picked it up yet.
  pending,

  /// Someone is working on it.
  inProgress,

  /// Closed out.
  done;

  /// Maps the wire value. Anything unrecognised falls back to [pending]
  /// rather than throwing — a status the app has not been taught about
  /// should still show the report, not hide it behind an error.
  static IssueStatus fromWire(String? value) {
    switch (value?.trim().toLowerCase()) {
      case 'in_progress':
      case 'in-progress':
      case 'inprogress':
        return IssueStatus.inProgress;
      case 'done':
      case 'closed':
      case 'resolved':
        return IssueStatus.done;
      default:
        return IssueStatus.pending;
    }
  }
}

@freezed
class IssueEntity with _$IssueEntity {
  const factory IssueEntity({
    required String id,
    required String title,
    required String description,
    @Default(IssueStatus.pending) IssueStatus status,

    /// Absent until the server starts sending it; the card simply drops the
    /// date line rather than inventing one.
    DateTime? createdAt,
  }) = _IssueEntity;
}
