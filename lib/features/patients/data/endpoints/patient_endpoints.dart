class PatientEndpoints {
  PatientEndpoints._();

  static const String patients = '/clinics/patients';
  static const String teeth = '/teeth';
  static const String coreTreatments = '/core-treatments';

  static String patientDetails(String patientId) =>
      '/clinics/patients/$patientId';

  static String updatePatient(String patientId) =>
      '/clinics/patients/$patientId';

  static String detachPatient(String patientId) =>
      '/clinics/patients/$patientId/detach';

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

  static String updateTreatmentPlanItem(
          String patientId, String caseId, String itemId) =>
      '/clinics/patients/$patientId/cases/$caseId/treatment-plan-items/$itemId';

  static String payments(String patientId, String caseId) =>
      '/clinics/patients/$patientId/cases/$caseId/payments';

  static String updateCaseCosts(String patientId, String caseId) =>
      '/clinics/patients/$patientId/cases/$caseId/costs';

  static String updateCase(String patientId, String caseId) =>
      '/clinics/patients/$patientId/cases/$caseId';

  static String reactivateCase(String patientId, String caseId) =>
      '/clinics/patients/$patientId/cases/$caseId/reactivate';

  /// Case attachments are their own sub-resource: GET to list, POST to
  /// attach uploaded media ids. The parent case route rejects PATCH (405),
  /// so attachments are never written through [updateCase].
  static String caseAttachments(String patientId, String caseId) =>
      '/clinics/patients/$patientId/cases/$caseId/attachments';

  static String caseAttachment(
    String patientId,
    String caseId,
    String attachmentId,
  ) =>
      '/clinics/patients/$patientId/cases/$caseId/attachments/$attachmentId';
}
