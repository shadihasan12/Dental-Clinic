part of 'patient_details_bloc.dart';

@freezed
class PatientDetailsEvent with _$PatientDetailsEvent {
  const factory PatientDetailsEvent.loadPatientDetails(String patientId) =
      _LoadPatientDetails;

  const factory PatientDetailsEvent.markCaseAsFinished() = _MarkCaseAsFinished;
}
