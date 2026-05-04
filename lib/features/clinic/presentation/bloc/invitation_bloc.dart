import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/get_received_invitations_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'invitation_event.dart';
part 'invitation_state.dart';
part 'invitation_bloc.freezed.dart';

@injectable
class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  final GetReceivedInvitationsUseCase _getReceivedInvitations;

  InvitationBloc(this._getReceivedInvitations)
      : super(const InvitationState()) {
    on<_LoadSentInvitations>(_onLoadSentInvitations);
    on<_LoadReceivedInvitations>(_onLoadReceivedInvitations);
    on<_FilterReceivedByStatus>(_onFilterReceivedByStatus);
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

      emit(state.copyWith(isLoading: false, sentInvitations: invitations));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onLoadReceivedInvitations(
    _LoadReceivedInvitations event,
    Emitter<InvitationState> emit,
  ) async {
    await _fetchReceived(state.receivedFilter, emit);
  }

  Future<void> _onFilterReceivedByStatus(
    _FilterReceivedByStatus event,
    Emitter<InvitationState> emit,
  ) async {
    if (event.status == state.receivedFilter && state.error == null) return;
    emit(state.copyWith(receivedFilter: event.status));
    await _fetchReceived(event.status, emit);
  }

  Future<void> _fetchReceived(
    InvitationStatus filter,
    Emitter<InvitationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await _getReceivedInvitations(filter);

    result.fold(
      (error) => emit(state.copyWith(
        isLoading: false,
        error: NetworkExceptions.getErrorMessage(error),
      )),
      (invitations) => emit(state.copyWith(
        isLoading: false,
        receivedInvitations: invitations,
      )),
    );
  }

  Future<void> _onSendInvitation(
    _SendInvitation event,
    Emitter<InvitationState> emit,
  ) async {
    emit(state.copyWith(isSending: true, error: null, sendSuccess: false));

    try {
      if (state.inviteeEmail.isEmpty) {
        emit(state.copyWith(
          isSending: false,
          error: 'Please enter an email address',
        ));
        return;
      }

      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 800));

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
      emit(state.copyWith(isSending: false, error: e.toString()));
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
      emit(state.copyWith(isUpdating: false, error: e.toString()));
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
      emit(state.copyWith(isUpdating: false, error: e.toString()));
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
      emit(state.copyWith(isUpdating: false, error: e.toString()));
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
