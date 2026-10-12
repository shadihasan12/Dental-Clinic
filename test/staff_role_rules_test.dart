import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_user_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/staff_role_rules.dart';
import 'package:flutter_test/flutter_test.dart';

/// The server's rules for who changes whose roles. The staff screens offer
/// only what these allow, so a control never leads to a 403.
void main() {
  ClinicUserEntity member(
    String email, {
    List<ClinicRole> roles = const [ClinicRole.dentist],
    bool isOwner = false,
  }) {
    return ClinicUserEntity(
      id: email,
      firstName: 'A',
      lastName: 'B',
      email: email,
      roles: roles,
      isOwner: isOwner,
    );
  }

  final roster = [
    member('owner@x.com', roles: [ClinicRole.admin], isOwner: true),
    member('admin@x.com', roles: [ClinicRole.admin, ClinicRole.dentist]),
    member('dentist@x.com'),
  ];

  StaffRoleRules viewer(String email) => StaffRoleRules.forViewer(
    roster: roster,
    viewerEmail: email,
    cachedIsOwner: false,
    cachedIsAdmin: false,
  );

  test('nobody but the owner edits their own roles', () {
    for (final email in ['admin@x.com', 'dentist@x.com']) {
      expect(
        viewer(email).canEditRoles(isSelf: true, targetIsOwner: false),
        isFalse,
        reason: email,
      );
    }
    expect(
      viewer('owner@x.com').canEditRoles(isSelf: true, targetIsOwner: true),
      isTrue,
    );
  });

  test('the owner\'s roles are changed only by the owner', () {
    expect(
      viewer('admin@x.com').canEditRoles(isSelf: false, targetIsOwner: true),
      isFalse,
    );
  });

  test('the owner keeps ADMIN, on their own row too', () {
    expect(viewer('owner@x.com').isAdminLocked(targetIsOwner: true), isTrue);
    expect(viewer('owner@x.com').isAdminLocked(targetIsOwner: false), isFalse);
  });

  test('ADMIN is handed out only by whoever runs the clinic', () {
    expect(viewer('owner@x.com').canGrantAdmin, isTrue);
    expect(viewer('admin@x.com').canGrantAdmin, isTrue);
    expect(viewer('dentist@x.com').canGrantAdmin, isFalse);
    expect(viewer('dentist@x.com').isAdminLocked(targetIsOwner: false), isTrue);
  });

  test('a member is removed by whoever runs the clinic, never the owner', () {
    final admin = viewer('admin@x.com');
    expect(admin.canRemove(isSelf: false, targetIsOwner: false), isTrue);
    expect(admin.canRemove(isSelf: false, targetIsOwner: true), isFalse);
    expect(admin.canRemove(isSelf: true, targetIsOwner: false), isFalse);
    expect(
      viewer('dentist@x.com').canRemove(isSelf: false, targetIsOwner: false),
      isFalse,
    );
  });

  test('the cached flags stand in when the roster does not list the user', () {
    final rules = StaffRoleRules.forViewer(
      roster: roster,
      viewerEmail: 'ghost@x.com',
      cachedIsOwner: false,
      cachedIsAdmin: true,
    );
    expect(rules.runsClinic, isTrue);
  });
}
