class PatientEndpoints {
  PatientEndpoints._();

  static const String patients = '/clinics/patients';
  static const String teeth = '/teeth';
  static const String coreTreatments = '/core-treatments';

  static String patientDetails(String patientId) =>
      '/clinics/patients/$patientId';

  static String activeCase(String patientId) =>
      '/patients/$patientId/cases/active';

  static String cases(String patientId) =>
      '/clinics/patients/$patientId/cases';

  static String createCase(String patientId) =>
      '/clinics/patients/$patientId/cases';

  static String addTreatmentPlanItem(String patientId, String caseId) =>
      '/clinics/patients/$patientId/cases/$caseId/treatment-plan-items';

  static String completeCase(String patientId, String caseId) =>
      '/clinics/patients/$patientId/cases/$caseId/complete';

  static String payments(String patientId, String caseId) =>
      '/clinics/patients/$patientId/cases/$caseId/payments';
}
