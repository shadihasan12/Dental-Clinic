part of 'patients_list_bloc.dart';

@freezed
class PatientsListEvent with _$PatientsListEvent {
  const factory PatientsListEvent.loadPatients() = _LoadPatients;
}
