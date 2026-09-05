part of 'issues_bloc.dart';

enum IssuesStatus { initial, loading, success, failure }

@freezed
class IssuesState with _$IssuesState {
  const factory IssuesState({
    @Default(IssuesStatus.initial) IssuesStatus status,

    /// Rendered in the order held here, which is the server's:
    /// `updated_at` descending, so whatever support just touched is on top.
    @Default(<IssueEntity>[]) List<IssueEntity> issues,

    /// Page most recently loaded, and the highest page there is.
    @Default(1) int page,
    @Default(1) int lastPage,

    /// True while a *further* page is loading — the list stays on screen and
    /// only the footer shows a spinner.
    @Default(false) bool isLoadingMore,

    /// Set when the list could not be loaded. The form still works; only
    /// the list below is replaced by the error card.
    String? errorMessage,

    /// Categories for the compose form, straight from the API.
    @Default(<IssueOptionEntity>[]) List<IssueOptionEntity> categories,

    /// Set when the category list failed. Without it there is nothing valid
    /// to send, so the form offers a retry instead of a dropdown.
    String? categoriesError,
    @Default(false) bool isLoadingCategories,

    /// Status labels, keyed by wire value when rendering a report.
    @Default(<IssueOptionEntity>[]) List<IssueOptionEntity> statuses,

    /// True while a create is in flight — the button shows a spinner and
    /// stops accepting taps.
    @Default(false) bool isSubmitting,

    /// Set when a create was rejected. Shown against the form, not the
    /// list, because that is what the user has to act on.
    String? submitError,

    /// Raised for exactly one emission after a successful create so the
    /// page can clear the fields and confirm. Consumers must not treat it
    /// as durable state.
    @Default(false) bool justCreated,
  }) = _IssuesState;

  const IssuesState._();

  /// Only the list area swaps to a skeleton; the form stays usable.
  bool get isLoadingList =>
      status == IssuesStatus.loading || status == IssuesStatus.initial;

  bool get hasIssues => issues.isNotEmpty;

  bool get hasMore => page < lastPage;

  /// The server's translated label for a wire value, or the raw value when
  /// the list has not loaded or the server has grown a value this build has
  /// never heard of.
  String labelForStatus(String value) => _label(statuses, value);

  String labelForCategory(String value) => _label(categories, value);

  static String _label(List<IssueOptionEntity> options, String value) {
    for (final option in options) {
      if (option.value == value) return option.label;
    }
    return value;
  }
}
