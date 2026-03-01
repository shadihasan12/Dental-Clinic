class PatientEndpoints {
  PatientEndpoints._();

  static const String patients = '/patients';

  static String patientDetails(String patientId) => '/patients/$patientId';

  static String activeCase(String patientId) =>
      '/patients/$patientId/cases/active';

  static String completedCases(String patientId) =>
      '/patients/$patientId/cases/completed';

  static String addTreatment(String patientId) =>
      '/patients/$patientId/treatments';
}
