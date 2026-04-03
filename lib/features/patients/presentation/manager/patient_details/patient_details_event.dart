part of 'patient_details_bloc.dart';

@freezed
class PatientDetailsEvent with _$PatientDetailsEvent {
  const factory PatientDetailsEvent.loadPatientDetails(String patientId) =
      _LoadPatientDetails;

  const factory PatientDetailsEvent.markCaseAsFinished({
    required String patientId,
    required String caseId,
    String? title,
  }) = _MarkCaseAsFinished;

  const factory PatientDetailsEvent.addPayment({
    required String patientId,
    required String caseId,
    required double amount,
    required String currencyId,
    required String caseCurrencyId,
    required double amountInCaseCurrency,
    required double exchangeRate,
    String? notes,
  }) = _AddPayment;
}
