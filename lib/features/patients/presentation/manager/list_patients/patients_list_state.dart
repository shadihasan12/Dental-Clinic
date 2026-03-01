part of 'patients_list_bloc.dart';

@freezed
class PatientsListState with _$PatientsListState {
  const factory PatientsListState.initial() = _Initial;
  const factory PatientsListState.loading() = _Loading;
  const factory PatientsListState.loaded({
    required List<PatientEntity> patients,
    @Default(false) bool hasMore,
  }) = _Loaded;
  const factory PatientsListState.loadingMore({
    required List<PatientEntity> patients,
  }) = _LoadingMore;
  const factory PatientsListState.error(String message) = _Error;
}
