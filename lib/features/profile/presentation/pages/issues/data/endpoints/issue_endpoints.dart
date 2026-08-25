/// Endpoints backing the Report an Issue screen.
///
/// The backend for this feature is still being built, so the paths are
/// intentionally blank. Fill both in once they exist — nothing else in the
/// feature needs to change, because [IssueRemoteDataSource] already shapes
/// the request and response around the contract documented below.
///
/// Expected contract:
///
/// `GET <issues>` → the caller's own reports, newest first.
/// ```json
/// { "data": [
///     { "id": "…", "title": "…", "description": "…",
///       "status": "pending" | "in_progress" | "done",
///       "created_at": "2026-08-22T14:03:00Z" }
/// ] }
/// ```
///
/// `POST <issues>` → creates one. Body `{ "title": "…", "description": "…" }`.
/// Responds with the created record in the same shape, under `data`.
/// The server owns `status`; a new report is expected back as `pending`.
class IssueEndpoints {
  IssueEndpoints._();

  /// GET - list the current user's reports.
  // TODO(backend): set to the real path, e.g. '/support/issues'.
  static const String issues = '';

  /// POST - create a report. Same path as the list in a REST design; kept
  /// separate so a different create route needs no code change.
  // TODO(backend): set to the real path, e.g. '/support/issues'.
  static const String createIssue = '';

  /// Guard used by the data source so a blank path fails loudly and early
  /// instead of firing a request at the API root.
  static bool get isConfigured => issues.isNotEmpty && createIssue.isNotEmpty;
}
