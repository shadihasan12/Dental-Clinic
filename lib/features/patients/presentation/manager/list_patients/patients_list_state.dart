part of 'patients_list_bloc.dart';

@freezed
class PatientsListState with _$PatientsListState {
  const factory PatientsListState.initial() = _Initial;
  const factory PatientsListState.loading() = _Loading;
  const factory PatientsListState.loaded(List<PatientEntity> patients) =
      _Loaded;
  const factory PatientsListState.error(String message) = _Error;
}
