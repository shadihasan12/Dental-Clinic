import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_user_entity.dart';

/// Who may change whose roles in a clinic, as the server decides it. The
/// staff screens ask this before offering a control, so nobody is shown one
/// that can only be answered 403.
///
/// "Runs the clinic" means its owner, or an ADMIN of it.
///
/// - The ADMIN role is given, taken away, or its holder removed only by
///   whoever runs the clinic.
/// - The owner's roles are changed only by the owner, who keeps ADMIN.
/// - Nobody else changes their own roles, an admin included.
class StaffRoleRules {
  const StaffRoleRules({
    required this.viewerIsOwner,
    required this.viewerIsAdmin,
  });

  /// Reads the signed-in user's standing off [roster] - each member comes
  /// with `roles` and `is_owner`. The cached flags stand in only when the
  /// roster does not list them.
  factory StaffRoleRules.forViewer({
    required List<ClinicUserEntity> roster,
    required String? viewerEmail,
    required bool cachedIsOwner,
    required bool cachedIsAdmin,
  }) {
    for (final member in roster) {
      if (viewerEmail != null && member.email == viewerEmail) {
        return StaffRoleRules(
          viewerIsOwner: member.isOwner,
          viewerIsAdmin: member.roles.contains(ClinicRole.admin),
        );
      }
    }
    return StaffRoleRules(
      viewerIsOwner: cachedIsOwner,
      viewerIsAdmin: cachedIsAdmin,
    );
  }

  final bool viewerIsOwner;
  final bool viewerIsAdmin;

  bool get runsClinic => viewerIsOwner || viewerIsAdmin;

  /// ADMIN is offered, to give or to take away, only by whoever runs the
  /// clinic.
  bool get canGrantAdmin => runsClinic;

  /// Whether the roles on a row may be edited at all.
  bool canEditRoles({required bool isSelf, required bool targetIsOwner}) {
    // The owner's roles are the owner's own to change.
    if (targetIsOwner) return viewerIsOwner && isSelf;
    return !isSelf;
  }

  /// Whether ADMIN can be neither ticked nor unticked on a row being edited:
  /// the owner keeps it, and only whoever runs the clinic hands it out.
  bool isAdminLocked({required bool targetIsOwner}) =>
      targetIsOwner || !canGrantAdmin;

  /// Whether a member may be removed: never oneself or the owner, and an
  /// ADMIN only by whoever runs the clinic - which removing anyone already
  /// takes.
  bool canRemove({required bool isSelf, required bool targetIsOwner}) =>
      runsClinic && !isSelf && !targetIsOwner;
}
