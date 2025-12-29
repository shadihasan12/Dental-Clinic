import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/approval_request_entity.dart';

part 'approvals_event.dart';
part 'approvals_state.dart';
part 'approvals_bloc.freezed.dart';

class ApprovalsBloc extends Bloc<ApprovalsEvent, ApprovalsState> {
  ApprovalsBloc() : super(const ApprovalsState()) {
    on<_LoadPendingApprovals>(_onLoadPendingApprovals);
    on<_ApproveRequest>(_onApproveRequest);
    on<_RejectRequest>(_onRejectRequest);
    on<_RequestPatientDeletion>(_onRequestPatientDeletion);
  }

  Future<void> _onLoadPendingApprovals(
    _LoadPendingApprovals event,
    Emitter<ApprovalsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock pending approvals
      final approvals = <ApprovalRequestEntity>[
        ApprovalRequestEntity(
          id: '1',
          clinicId: event.clinicId,
          requesterId: 'receptionist_1',
          requesterName: 'Sarah Receptionist',
          type: ApprovalType.deletePatient,
          status: ApprovalStatus.pending,
          payload: {
            'patientId': 'patient_123',
            'patientName': 'John Doe',
            'reason': 'Patient requested removal',
          },
          createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        ),
        ApprovalRequestEntity(
          id: '2',
          clinicId: event.clinicId,
          requesterId: 'dentist_1',
          requesterName: 'Dr. Jane Dentist',
          type: ApprovalType.deletePatient,
          status: ApprovalStatus.pending,
          payload: {
            'patientId': 'patient_456',
            'patientName': 'Jane Smith',
            'reason': 'Duplicate record',
          },
          createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        ),
      ];

      emit(state.copyWith(
        isLoading: false,
        pendingApprovals: approvals,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onApproveRequest(
    _ApproveRequest event,
    Emitter<ApprovalsState> emit,
  ) async {
    emit(state.copyWith(isProcessing: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      final updatedApprovals = state.pendingApprovals
          .where((req) => req.id != event.requestId)
          .toList();

      emit(state.copyWith(
        isProcessing: false,
        pendingApprovals: updatedApprovals,
        approveSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isProcessing: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onRejectRequest(
    _RejectRequest event,
    Emitter<ApprovalsState> emit,
  ) async {
    emit(state.copyWith(isProcessing: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      final updatedApprovals = state.pendingApprovals
          .where((req) => req.id != event.requestId)
          .toList();

      emit(state.copyWith(
        isProcessing: false,
        pendingApprovals: updatedApprovals,
        rejectSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isProcessing: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onRequestPatientDeletion(
    _RequestPatientDeletion event,
    Emitter<ApprovalsState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      emit(state.copyWith(
        isSubmitting: false,
        submitSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        error: e.toString(),
      ));
    }
  }
}
