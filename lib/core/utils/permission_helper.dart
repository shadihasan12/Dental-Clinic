import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';

/// Helper class for checking role-based permissions within a clinic
class PermissionHelper {
  PermissionHelper._();

  /// Check if the user can manage staff (invite, remove, change roles)
  /// Only admins can manage staff
  static bool canManageStaff(ClinicRole? role) {
    return role == ClinicRole.admin;
  }

  /// Check if the user can directly delete a patient without approval
  /// Only admins can delete patients directly
  static bool canDeletePatient(ClinicRole? role) {
    return role == ClinicRole.admin;
  }

  /// Check if the user can add a patient
  /// All clinic members can add patients
  static bool canAddPatient(ClinicRole? role) {
    return role != null;
  }

  /// Check if the user needs approval for deleting a patient
  /// Dentists and receptionists need admin approval
  static bool needsApprovalForDelete(ClinicRole? role) {
    return role == ClinicRole.receptionist || role == ClinicRole.dentist;
  }

  /// Check if the user can invite new members
  /// Only admins can invite members
  static bool canInviteMembers(ClinicRole? role) {
    return role == ClinicRole.admin;
  }

  /// Check if the user can approve requests (patient deletions, etc.)
  /// Only admins can approve requests
  static bool canApproveRequests(ClinicRole? role) {
    return role == ClinicRole.admin;
  }

  /// Check if the user can view clinic settings
  /// Only admins can view/edit clinic settings
  static bool canViewClinicSettings(ClinicRole? role) {
    return role == ClinicRole.admin;
  }

  /// Check if the user can update clinic information
  /// Only admins can update clinic info
  static bool canUpdateClinicInfo(ClinicRole? role) {
    return role == ClinicRole.admin;
  }

  /// Check if the user can view all patients in the clinic
  /// All clinic members can view patients
  static bool canViewPatients(ClinicRole? role) {
    return role != null;
  }

  /// Check if the user can view appointments
  /// All clinic members can view appointments
  static bool canViewAppointments(ClinicRole? role) {
    return role != null;
  }

  /// Check if the user can create appointments
  /// All clinic members can create appointments
  static bool canCreateAppointment(ClinicRole? role) {
    return role != null;
  }

  /// Check if the user can cancel appointments
  /// All clinic members can cancel appointments
  static bool canCancelAppointment(ClinicRole? role) {
    return role != null;
  }

  /// Check if the user can view clinic statistics/reports
  /// Only admins can view full statistics
  static bool canViewStatistics(ClinicRole? role) {
    return role == ClinicRole.admin;
  }

  /// Check if the user can leave the clinic
  /// Dentists and receptionists can leave; admins cannot leave (must transfer ownership)
  static bool canLeaveClinic(ClinicRole? role) {
    return role == ClinicRole.dentist || role == ClinicRole.receptionist;
  }

  /// Get a human-readable role name
  static String getRoleName(ClinicRole? role) {
    switch (role) {
      case ClinicRole.admin:
        return 'Admin';
      case ClinicRole.dentist:
        return 'Dentist';
      case ClinicRole.receptionist:
        return 'Receptionist';
      case ClinicRole.secretary:
        return 'Secretary';
      case null:
        return 'Unknown';
    }
  }

  /// Get a description of what the role can do
  static String getRoleDescription(ClinicRole role) {
    switch (role) {
      case ClinicRole.admin:
        return 'Full access to manage clinic, staff, patients, and settings';
      case ClinicRole.dentist:
        return 'Can view and manage patients and appointments';
      case ClinicRole.receptionist:
        return 'Can add patients and manage appointments. Patient deletions require admin approval';
      case ClinicRole.secretary:
        return 'Can manage appointments and administrative tasks';
    }
  }

  /// Get available actions for a role in the patient context
  static List<PatientAction> getPatientActions(ClinicRole? role) {
    if (role == null) return [];

    final actions = <PatientAction>[
      PatientAction.view,
      PatientAction.edit,
    ];

    if (canDeletePatient(role)) {
      actions.add(PatientAction.delete);
    } else if (needsApprovalForDelete(role)) {
      actions.add(PatientAction.requestDelete);
    }

    return actions;
  }
}

/// Enum for patient-related actions
enum PatientAction {
  view,
  edit,
  delete,
  requestDelete,
}

/// Extension on PatientAction for display
extension PatientActionExtension on PatientAction {
  String get label {
    switch (this) {
      case PatientAction.view:
        return 'View';
      case PatientAction.edit:
        return 'Edit';
      case PatientAction.delete:
        return 'Delete';
      case PatientAction.requestDelete:
        return 'Request Delete';
    }
  }

  String get description {
    switch (this) {
      case PatientAction.view:
        return 'View patient details';
      case PatientAction.edit:
        return 'Edit patient information';
      case PatientAction.delete:
        return 'Permanently delete patient';
      case PatientAction.requestDelete:
        return 'Submit deletion request for admin approval';
    }
  }
}
