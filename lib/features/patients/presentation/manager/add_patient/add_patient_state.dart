part of 'add_patient_bloc.dart';

@freezed
class AddPatientState with _$AddPatientState {
  const factory AddPatientState.initial() = _Initial;
  const factory AddPatientState.saving() = _Saving;
  const factory AddPatientState.success(PatientEntity patient) = _Success;
  const factory AddPatientState.error(String message) = _Error;
}
