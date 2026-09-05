import 'package:freezed_annotation/freezed_annotation.dart';

part 'issue_entity.freezed.dart';

/// Where a report has got to.
///
/// The server owns the value; the app never sets it, it only renders it. The
/// wire constants are `OPEN`, `IN_PROGRESS`, `RESOLVED` and `CLOSED` — this
/// enum exists only to pick a colour and an icon, which is why anything
/// unrecognised lands on [unknown] and is shown with its raw label rather
/// than swallowed.
enum IssueStatus {
  open,
  inProgress,
  resolved,
  closed,
  unknown;

  static IssueStatus fromWire(String? value) {
    switch (value?.trim().toUpperCase()) {
      case 'OPEN':
        return IssueStatus.open;
      case 'IN_PROGRESS':
        return IssueStatus.inProgress;
      case 'RESOLVED':
        return IssueStatus.resolved;
      case 'CLOSED':
        return IssueStatus.closed;
      default:
        return IssueStatus.unknown;
    }
  }
}

/// One screenshot on a report.
///
/// Both URLs are signed and expire an hour after the server issued them, so
/// they are usable for as long as the list that carried them is fresh and no
/// longer. Never cache them; re-fetch the list instead.
@freezed
class IssueAttachmentEntity with _$IssueAttachmentEntity {
  const factory IssueAttachmentEntity({
    required String mediaItemId,
    required String viewUrl,
    required String downloadUrl,
  }) = _IssueAttachmentEntity;
}

/// A category or status as the API defines it: a stable [value] to send back
/// and a [label] the server has already translated.
@freezed
class IssueOptionEntity with _$IssueOptionEntity {
  const factory IssueOptionEntity({
    required String value,
    required String label,
  }) = _IssueOptionEntity;
}

@freezed
class IssueEntity with _$IssueEntity {
  const factory IssueEntity({
    required String id,

    /// Wire value, e.g. `BUG`. Labelled from the categories endpoint.
    @Default('') String category,

    /// Wire value, e.g. `OPEN`. Labelled from the statuses endpoint.
    @Default('') String status,
    required String title,
    required String description,
    @Default(<IssueAttachmentEntity>[]) List<IssueAttachmentEntity> attachments,
    DateTime? createdAt,

    /// Moves when support acts on the report, and the list is sorted by it —
    /// this is the "last activity", not the filing date.
    DateTime? updatedAt,
  }) = _IssueEntity;

  const IssueEntity._();

  IssueStatus get statusKind => IssueStatus.fromWire(status);

  bool get hasAttachments => attachments.isNotEmpty;
}

/// One page of reports and where it sits in the whole list.
@freezed
class IssuePageEntity with _$IssuePageEntity {
  const factory IssuePageEntity({
    @Default(<IssueEntity>[]) List<IssueEntity> items,
    @Default(1) int page,
    @Default(1) int lastPage,
    @Default(0) int total,
  }) = _IssuePageEntity;

  const IssuePageEntity._();

  bool get hasMore => page < lastPage;
}
