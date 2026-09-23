import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/repositories/clinic_repository.dart';
import 'package:injectable/injectable.dart';

/// Makes a clinic the active one - the single path for "Use this clinic" and
/// for a notification that belongs to another clinic.
@injectable
class SwitchActiveClinicUseCase {
  SwitchActiveClinicUseCase(
    this._repository,
    this._tokenStorage,
    this._userStorage,
  );

  final ClinicRepository _repository;
  final TokenStorage _tokenStorage;
  final UserStorage _userStorage;

  bool isActive(String clinicId) => _tokenStorage.getClinicId() == clinicId;

  /// Switches to [clinicId] if it is not already active. False when the user
  /// is not a member of it (or it could not be checked), in which case
  /// nothing changes.
  Future<bool> call(String clinicId) async {
    if (isActive(clinicId)) return true;
    final result = await _repository.getMyClinics();
    final memberships = result.getOrElse(() => const []);
    for (final membership in memberships) {
      if (membership.clinicId == clinicId) {
        await activate(membership);
        return true;
      }
    }
    return false;
  }

  Future<void> activate(ClinicMembershipEntity membership) async {
    // The auth interceptor reads from TokenStorage on every request, so
    // saving here is enough to flip every subsequent call to the new
    // clinic. The user storage carries the display name for the home
    // header.
    await _tokenStorage.saveClinicId(membership.clinicId);
    await _userStorage.saveClinicName(membership.clinicName);
    await _userStorage.saveUserRole(membership.role.name);
    await _userStorage.saveIsClinicOwner(membership.isOwner);
    // profileUpdated rebuilds widgets that read the cached clinic/role
    // (e.g. the home header); clinicChanged tells the root page to refetch
    // permissions and remount every tab so each clinic-scoped API reloads.
    UserStorage.notifyProfileUpdated();
    UserStorage.notifyClinicChanged();
  }
}
