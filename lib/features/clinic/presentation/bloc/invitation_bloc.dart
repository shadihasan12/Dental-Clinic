import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/get_received_invitations_use_case.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/get_sent_invitations_use_case.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/respond_to_invitation_use_case.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/send_invitation_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'invitation_event.dart';
part 'invitation_state.dart';
part 'invitation_bloc.freezed.dart';

@injectable
class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  final GetReceivedInvitationsUseCase _getReceivedInvitations;
  final GetSentInvitationsUseCase _getSentInvitations;
  final SendInvitationUseCase _sendInvitation;
  final AcceptInvitationUseCase _acceptInvitation;
  final DeclineInvitationUseCase _declineInvitation;

  InvitationBloc(
    this._getReceivedInvitations,
    this._getSentInvitations,
    this._sendInvitation,
    this._acceptInvitation,
    this._declineInvitation,
  ) : super(const InvitationState()) {
    on<_LoadSentInvitations>(_onLoadSentInvitations);
    on<_LoadReceivedInvitations>(_onLoadReceivedInvitations);
    on<_FilterReceivedByStatus>(_onFilterReceivedByStatus);
    on<_FilterSentByStatus>(_onFilterSentByStatus);
    on<_SendInvitation>(_onSendInvitation);
    on<_CancelInvitation>(_onCancelInvitation);
    on<_AcceptInvitation>(_onAcceptInvitation);
    on<_RejectInvitation>(_onRejectInvitation);
  }

  // ─── Received ──────────────────────────────────────────────────────────

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

  // ─── Sent (admin) ──────────────────────────────────────────────────────

  Future<void> _onLoadSentInvitations(
    _LoadSentInvitations event,
    Emitter<InvitationState> emit,
  ) async {
    await _fetchSent(state.sentFilter, emit);
  }

  Future<void> _onFilterSentByStatus(
    _FilterSentByStatus event,
    Emitter<InvitationState> emit,
  ) async {
    if (event.status == state.sentFilter && state.error == null) return;
    emit(state.copyWith(sentFilter: event.status));
    await _fetchSent(event.status, emit);
  }

  Future<void> _fetchSent(
    InvitationStatus filter,
    Emitter<InvitationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _getSentInvitations(filter);
    result.fold(
      (error) => emit(state.copyWith(
        isLoading: false,
        error: NetworkExceptions.getErrorMessage(error),
      )),
      (invitations) => emit(state.copyWith(
        isLoading: false,
        sentInvitations: invitations,
      )),
    );
  }

  // ─── Send ──────────────────────────────────────────────────────────────

  Future<void> _onSendInvitation(
    _SendInvitation event,
    Emitter<InvitationState> emit,
  ) async {
    emit(state.copyWith(
      isSending: true,
      sendSuccess: false,
      error: null,
    ));

    final result = await _sendInvitation(
      SendInvitationParams(email: event.email, roles: event.roles),
    );

    result.fold(
      (error) => emit(state.copyWith(
        isSending: false,
        error: NetworkExceptions.getErrorMessage(error),
      )),
      (invitation) {
        emit(state.copyWith(
          isSending: false,
          sendSuccess: true,
          sentInvitations: [invitation, ...state.sentInvitations],
        ));
      },
    );

    // Refresh the sent list from the server so it always reflects the
    // server's authoritative state for the current filter.
    if (state.sentFilter == InvitationStatus.pending) {
      await _fetchSent(state.sentFilter, emit);
    }
  }

  // ─── Cancel (mock, no endpoint yet) ────────────────────────────────────

  Future<void> _onCancelInvitation(
    _CancelInvitation event,
    Emitter<InvitationState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, error: null));
    // TODO: Replace with actual API call when the backend exposes one.
    await Future.delayed(const Duration(milliseconds: 300));
    final updated = state.sentInvitations
        .where((inv) => inv.id != event.invitationId)
        .toList();
    emit(state.copyWith(
      isUpdating: false,
      sentInvitations: updated,
      cancelSuccess: true,
    ));
  }

  // ─── Accept / Reject (real API) ────────────────────────────────────────

  Future<void> _onAcceptInvitation(
    _AcceptInvitation event,
    Emitter<InvitationState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, error: null));
    final result = await _acceptInvitation(event.invitationId);
    final error = result.fold(
      (e) => NetworkExceptions.getErrorMessage(e),
      (_) => null,
    );
    if (error != null) {
      emit(state.copyWith(isUpdating: false, error: error));
      return;
    }
    emit(state.copyWith(isUpdating: false, acceptSuccess: true));
    // Refresh from the server so the list reflects the new status (and the
    // row disappears if it no longer matches the active filter).
    await _fetchReceived(state.receivedFilter, emit);
  }

  Future<void> _onRejectInvitation(
    _RejectInvitation event,
    Emitter<InvitationState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, error: null));
    final result = await _declineInvitation(event.invitationId);
    final error = result.fold(
      (e) => NetworkExceptions.getErrorMessage(e),
      (_) => null,
    );
    if (error != null) {
      emit(state.copyWith(isUpdating: false, error: error));
      return;
    }
    emit(state.copyWith(isUpdating: false, rejectSuccess: true));
    await _fetchReceived(state.receivedFilter, emit);
  }
}
