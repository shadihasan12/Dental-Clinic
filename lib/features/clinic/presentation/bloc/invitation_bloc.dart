import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';

part 'invitation_event.dart';
part 'invitation_state.dart';
part 'invitation_bloc.freezed.dart';

class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  InvitationBloc() : super(const InvitationState()) {
    on<_LoadSentInvitations>(_onLoadSentInvitations);
    on<_LoadReceivedInvitations>(_onLoadReceivedInvitations);
    on<_SendInvitation>(_onSendInvitation);
    on<_CancelInvitation>(_onCancelInvitation);
    on<_AcceptInvitation>(_onAcceptInvitation);
    on<_RejectInvitation>(_onRejectInvitation);
    on<_UpdateInviteeEmail>(_onUpdateInviteeEmail);
    on<_UpdateInviteeRole>(_onUpdateInviteeRole);
    on<_UpdateInviteMessage>(_onUpdateInviteMessage);
    on<_ResetInviteForm>(_onResetInviteForm);
  }

  Future<void> _onLoadSentInvitations(
    _LoadSentInvitations event,
    Emitter<InvitationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock sent invitations
      final invitations = <InvitationEntity>[
        InvitationEntity(
          id: '1',
          clinicId: event.clinicId,
          clinicName: 'Sample Clinic',
          inviteeEmail: 'pending@example.com',
          role: ClinicRole.dentist,
          status: InvitationStatus.pending,
          invitedByUserId: 'admin_user_id',
          invitedByName: 'Dr. Admin',
          message: 'Join our team!',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          expiresAt: DateTime.now().add(const Duration(days: 5)),
        ),
      ];

      emit(state.copyWith(
        isLoading: false,
        sentInvitations: invitations,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLoadReceivedInvitations(
    _LoadReceivedInvitations event,
    Emitter<InvitationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock received invitations
      final invitations = <InvitationEntity>[
        InvitationEntity(
          id: '2',
          clinicId: 'clinic_abc',
          clinicName: 'Bright Smile Dental',
          inviteeEmail: event.userEmail,
          role: ClinicRole.dentist,
          status: InvitationStatus.pending,
          invitedByUserId: 'admin_smith_id',
          invitedByName: 'Dr. Smith',
          message: 'We would love to have you join our team!',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          expiresAt: DateTime.now().add(const Duration(days: 6)),
        ),
      ];

      emit(state.copyWith(
        isLoading: false,
        receivedInvitations: invitations,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onSendInvitation(
    _SendInvitation event,
    Emitter<InvitationState> emit,
  ) async {
    emit(state.copyWith(isSending: true, error: null, sendSuccess: false));

    try {
      // Validate
      if (state.inviteeEmail.isEmpty) {
        emit(state.copyWith(
          isSending: false,
          error: 'Please enter an email address',
        ));
        return;
      }

      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 800));

      // Add to sent invitations
      final newInvitation = InvitationEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        clinicId: event.clinicId,
        clinicName: event.clinicName,
        inviteeEmail: state.inviteeEmail,
        role: state.inviteeRole,
        status: InvitationStatus.pending,
        invitedByUserId: 'current_user_id', // TODO: Get from auth state
        message: state.inviteMessage,
        createdAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(days: 7)),
      );

      emit(state.copyWith(
        isSending: false,
        sendSuccess: true,
        sentInvitations: [...state.sentInvitations, newInvitation],
        inviteeEmail: '',
        inviteeRole: ClinicRole.dentist,
        inviteMessage: '',
      ));
    } catch (e) {
      emit(state.copyWith(
        isSending: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onCancelInvitation(
    _CancelInvitation event,
    Emitter<InvitationState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      final updatedInvitations = state.sentInvitations
          .where((inv) => inv.id != event.invitationId)
          .toList();

      emit(state.copyWith(
        isUpdating: false,
        sentInvitations: updatedInvitations,
        cancelSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isUpdating: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onAcceptInvitation(
    _AcceptInvitation event,
    Emitter<InvitationState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      final updatedInvitations = state.receivedInvitations
          .where((inv) => inv.id != event.invitationId)
          .toList();

      emit(state.copyWith(
        isUpdating: false,
        receivedInvitations: updatedInvitations,
        acceptSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isUpdating: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onRejectInvitation(
    _RejectInvitation event,
    Emitter<InvitationState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      final updatedInvitations = state.receivedInvitations
          .where((inv) => inv.id != event.invitationId)
          .toList();

      emit(state.copyWith(
        isUpdating: false,
        receivedInvitations: updatedInvitations,
        rejectSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isUpdating: false,
        error: e.toString(),
      ));
    }
  }

  void _onUpdateInviteeEmail(
    _UpdateInviteeEmail event,
    Emitter<InvitationState> emit,
  ) {
    emit(state.copyWith(inviteeEmail: event.email));
  }

  void _onUpdateInviteeRole(
    _UpdateInviteeRole event,
    Emitter<InvitationState> emit,
  ) {
    emit(state.copyWith(inviteeRole: event.role));
  }

  void _onUpdateInviteMessage(
    _UpdateInviteMessage event,
    Emitter<InvitationState> emit,
  ) {
    emit(state.copyWith(inviteMessage: event.message));
  }

  void _onResetInviteForm(
    _ResetInviteForm event,
    Emitter<InvitationState> emit,
  ) {
    emit(state.copyWith(
      inviteeEmail: '',
      inviteeRole: ClinicRole.dentist,
      inviteMessage: '',
      sendSuccess: false,
      error: null,
    ));
  }
}
