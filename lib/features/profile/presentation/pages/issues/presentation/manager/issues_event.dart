part of 'issues_bloc.dart';

@freezed
class IssuesEvent with _$IssuesEvent {
  /// Fetches the caller's reports. Dispatched when the screen opens and
  /// from the error card's Retry.
  const factory IssuesEvent.load() = _Load;

  /// Files a new report. Both fields are required; the bloc trims and
  /// rejects blanks rather than trusting the form.
  const factory IssuesEvent.submit({
    required String title,
    required String description,
  }) = _Submit;
}
