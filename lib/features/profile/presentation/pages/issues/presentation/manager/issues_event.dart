part of 'issues_bloc.dart';

@freezed
class IssuesEvent with _$IssuesEvent {
  /// Fetches the first page of reports, and the category and status lists
  /// alongside it. Dispatched when the screen opens, from Retry, and on pull
  /// to refresh — which is also how expired attachment links get renewed.
  const factory IssuesEvent.load() = _Load;

  /// Fetches the next page. Ignored when one is already in flight or the
  /// last page is already shown.
  const factory IssuesEvent.loadMore() = _LoadMore;

  /// Re-fetches only the category list, for the retry inside the form when
  /// that one call was the thing that failed.
  const factory IssuesEvent.reloadCategories() = _ReloadCategories;

  /// Files a new report. [mediaItemIds] are already-uploaded screenshots.
  const factory IssuesEvent.submit({
    required String category,
    required String title,
    required String description,
    @Default(<String>[]) List<String> mediaItemIds,
  }) = _Submit;
}
