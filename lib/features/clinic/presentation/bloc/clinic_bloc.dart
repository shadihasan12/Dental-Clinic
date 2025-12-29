import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';

part 'clinic_event.dart';
part 'clinic_state.dart';
part 'clinic_bloc.freezed.dart';

class ClinicBloc extends Bloc<ClinicEvent, ClinicState> {
  ClinicBloc() : super(const ClinicState()) {
    on<_LoadClinic>(_onLoadClinic);
    on<_LoadMembers>(_onLoadMembers);
    on<_UpdateClinicInfo>(_onUpdateClinicInfo);
    on<_UpdateMemberRole>(_onUpdateMemberRole);
    on<_RemoveMember>(_onRemoveMember);
    on<_LeaveClinic>(_onLeaveClinic);
  }

  Future<void> _onLoadClinic(
    _LoadClinic event,
    Emitter<ClinicState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock clinic data
      final clinic = ClinicEntity(
        id: event.clinicId,
        name: 'Sample Dental Clinic',
        adminUserId: 'admin_user_id',
        address: '123 Main Street',
        phone: '+1 234 567 8900',
        email: 'clinic@example.com',
        createdAt: DateTime.now(),
      );

      emit(state.copyWith(
        isLoading: false,
        clinic: clinic,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMembers(
    _LoadMembers event,
    Emitter<ClinicState> emit,
  ) async {
    emit(state.copyWith(isMembersLoading: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock members data
      final members = <ClinicMembershipEntity>[
        ClinicMembershipEntity(
          id: '1',
          userId: 'admin_user_id',
          clinicId: event.clinicId,
          clinicName: state.clinic?.name ?? '',
          role: ClinicRole.admin,
          status: MembershipStatus.active,
          userName: 'Dr. John Admin',
          userEmail: 'admin@clinic.com',
          joinedAt: DateTime.now().subtract(const Duration(days: 365)),
        ),
        ClinicMembershipEntity(
          id: '2',
          userId: 'dentist_user_id',
          clinicId: event.clinicId,
          clinicName: state.clinic?.name ?? '',
          role: ClinicRole.dentist,
          status: MembershipStatus.active,
          userName: 'Dr. Jane Dentist',
          userEmail: 'jane@clinic.com',
          joinedAt: DateTime.now().subtract(const Duration(days: 180)),
        ),
      ];

      emit(state.copyWith(
        isMembersLoading: false,
        members: members,
      ));
    } catch (e) {
      emit(state.copyWith(
        isMembersLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateClinicInfo(
    _UpdateClinicInfo event,
    Emitter<ClinicState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      emit(state.copyWith(
        isUpdating: false,
        clinic: event.clinic,
        updateSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isUpdating: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateMemberRole(
    _UpdateMemberRole event,
    Emitter<ClinicState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      final updatedMembers = state.members.map((member) {
        if (member.id == event.membershipId) {
          return member.copyWith(role: event.newRole);
        }
        return member;
      }).toList();

      emit(state.copyWith(
        isUpdating: false,
        members: updatedMembers,
        updateSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isUpdating: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onRemoveMember(
    _RemoveMember event,
    Emitter<ClinicState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      final updatedMembers = state.members
          .where((member) => member.id != event.membershipId)
          .toList();

      emit(state.copyWith(
        isUpdating: false,
        members: updatedMembers,
        removeSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isUpdating: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLeaveClinic(
    _LeaveClinic event,
    Emitter<ClinicState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      emit(state.copyWith(
        isUpdating: false,
        leaveSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isUpdating: false,
        error: e.toString(),
      ));
    }
  }
}
