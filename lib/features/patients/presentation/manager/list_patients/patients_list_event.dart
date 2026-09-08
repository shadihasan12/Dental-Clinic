part of 'patients_list_bloc.dart';

@freezed
class PatientsListEvent with _$PatientsListEvent {
  const factory PatientsListEvent.loadPatients() = _LoadPatients;
  const factory PatientsListEvent.loadMore() = _LoadMore;

  /// A name fragment typed into the search field. Blank clears the search and
  /// returns to the paginated roster.
  const factory PatientsListEvent.search(String query) = _Search;
}
