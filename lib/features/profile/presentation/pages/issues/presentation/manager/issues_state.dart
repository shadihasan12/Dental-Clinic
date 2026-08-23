part of 'issues_bloc.dart';

enum IssuesStatus { initial, loading, success, failure }

@freezed
class IssuesState with _$IssuesState {
  const factory IssuesState({
    @Default(IssuesStatus.initial) IssuesStatus status,

    /// Rendered in the order held here — newest first, which is the order
    /// the list endpoint is expected to return.
    @Default(<IssueEntity>[]) List<IssueEntity> issues,

    /// Set when the list could not be loaded. The form still works; only
    /// the list below is replaced by the error card.
    String? errorMessage,

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
}
