import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_user_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/add_clinic_user_use_case.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/get_clinic_users_use_case.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/remove_clinic_user_use_case.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/update_user_roles_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'clinic_users_event.dart';
part 'clinic_users_state.dart';
part 'clinic_users_bloc.freezed.dart';

@injectable
class ClinicUsersBloc extends Bloc<ClinicUsersEvent, ClinicUsersState> {
  final GetClinicUsersUseCase _getClinicUsers;
  final AddClinicUserUseCase _addClinicUser;
  final UpdateUserRolesUseCase _updateUserRoles;
  final RemoveClinicUserUseCase _removeClinicUser;
  final String clinicId;

  ClinicUsersBloc(
    this._getClinicUsers,
    this._addClinicUser,
    this._updateUserRoles,
    this._removeClinicUser,
    @factoryParam this.clinicId,
  ) : super(const ClinicUsersState.initial()) {
    on<_Load>(_onLoad);
    on<_AddUser>(_onAddUser);
    on<_UpdateRoles>(_onUpdateRoles);
    on<_RemoveUser>(_onRemoveUser);
  }

  List<ClinicUserEntity> _currentUsers() {
    return state.maybeWhen(
      loaded: (users) => users,
      submitting: (users) => users,
      submitSuccess: (users, _) => users,
      submitError: (users, _) => users,
      orElse: () => [],
    );
  }

  Future<void> _onLoad(_Load event, Emitter<ClinicUsersState> emit) async {
    emit(const ClinicUsersState.loading());
    final result = await _getClinicUsers(clinicId);
    result.fold(
      (error) =>
          emit(ClinicUsersState.error(NetworkExceptions.getErrorMessage(error))),
      (users) => emit(ClinicUsersState.loaded(users)),
    );
  }

  Future<void> _onAddUser(
      _AddUser event, Emitter<ClinicUsersState> emit) async {
    final current = _currentUsers();
    emit(ClinicUsersState.submitting(current));
    final result = await _addClinicUser(AddClinicUserParams(
      clinicId: clinicId,
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      mobileNumber: event.mobileNumber,
      password: event.password,
      passwordConfirmation: event.passwordConfirmation,
      roles: event.roles,
      specialtyId: event.specialtyId,
    ));
    result.fold(
      (error) => emit(ClinicUsersState.submitError(
        current,
        NetworkExceptions.getErrorMessage(error),
      )),
      (newUser) => emit(ClinicUsersState.submitSuccess(
        [...current, newUser],
        'userAddedSuccess',
      )),
    );
  }

  Future<void> _onUpdateRoles(
      _UpdateRoles event, Emitter<ClinicUsersState> emit) async {
    final current = _currentUsers();
    emit(ClinicUsersState.submitting(current));
    final result = await _updateUserRoles(
      clinicId: clinicId,
      userId: event.userId,
      roles: event.roles,
    );
    result.fold(
      (error) => emit(ClinicUsersState.submitError(
        current,
        NetworkExceptions.getErrorMessage(error),
      )),
      (_) {
        final updated = current.map((u) {
          if (u.id == event.userId) {
            final parsedRoles = event.roles.map(_parseRole).toList();
            return u.copyWith(roles: parsedRoles);
          }
          return u;
        }).toList();
        emit(ClinicUsersState.submitSuccess(updated, 'rolesUpdatedSuccess'));
      },
    );
  }

  Future<void> _onRemoveUser(
      _RemoveUser event, Emitter<ClinicUsersState> emit) async {
    final current = _currentUsers();
    emit(ClinicUsersState.submitting(current));
    final result = await _removeClinicUser(
      clinicId: clinicId,
      userId: event.userId,
    );
    result.fold(
      (error) => emit(ClinicUsersState.submitError(
        current,
        NetworkExceptions.getErrorMessage(error),
      )),
      (_) => emit(ClinicUsersState.submitSuccess(
        current.where((u) => u.id != event.userId).toList(),
        'userRemovedSuccess',
      )),
    );
  }

  ClinicRole _parseRole(String raw) {
    switch (raw.toUpperCase()) {
      case 'ADMIN':
        return ClinicRole.admin;
      case 'DENTIST':
        return ClinicRole.dentist;
      case 'SECRETARY':
        return ClinicRole.secretary;
      default:
        return ClinicRole.receptionist;
    }
  }
}
