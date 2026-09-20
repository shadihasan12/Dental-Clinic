import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';

/// Translated name for a clinic role.
///
/// The role reaches the UI two ways - as a [ClinicRole] from a membership, and
/// as the bare enum name cached by `UserStorage.saveUserRole` - so both are
/// handled here rather than each screen mapping its own and drifting.
String clinicRoleLabel(AppLocalizations l10n, ClinicRole role) {
  switch (role) {
    case ClinicRole.admin:
      return l10n.roleAdmin;
    case ClinicRole.dentist:
      return l10n.roleDentist;
    case ClinicRole.secretary:
      return l10n.roleSecretary;
    case ClinicRole.receptionist:
      return l10n.roleReceptionist;
  }
}

/// Same, for the cached string. Returns null when nothing is stored or the
/// value is not one we know, so a caller can hide the line rather than
/// labelling everyone a dentist.
String? clinicRoleLabelFromName(AppLocalizations l10n, String? name) {
  if (name == null || name.isEmpty) return null;
  final match = ClinicRole.values.where(
    (r) => r.name.toLowerCase() == name.toLowerCase(),
  );
  return match.isEmpty ? null : clinicRoleLabel(l10n, match.first);
}
