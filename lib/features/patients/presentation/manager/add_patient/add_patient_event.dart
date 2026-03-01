part of 'add_patient_bloc.dart';

@freezed
class AddPatientEvent with _$AddPatientEvent {
  const factory AddPatientEvent.submit(PatientEntity patient) = _Submit;
}
