/// Endpoints backing the Report an Issue screen (the tickets API).
///
/// `Authorization`, `Accept-Language` and `X-Selected-Clinic-id` are all
/// attached by [AuthInterceptor] on every request, so nothing here has to
/// pass them by hand. The clinic header is *required* on create and merely
/// ignored on the reads, which is why sending it everywhere is safe.
class IssueEndpoints {
  IssueEndpoints._();

  /// GET - the caller's own reports, paginated, `updated_at` descending.
  /// POST - files a new one.
  static const String tickets = '/tickets';

  /// GET - `{value, label}` pairs for the category dropdown. Labels arrive
  /// already translated to `Accept-Language`.
  static const String categories = '/tickets/categories';

  /// GET - `{value, label}` pairs used to label a report's status.
  static const String statuses = '/tickets/statuses';
}
