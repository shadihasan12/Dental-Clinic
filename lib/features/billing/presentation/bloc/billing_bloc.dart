import 'dart:async';
import 'dart:io';

import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/payment_instructions_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/billing/domain/use_cases/create_invoice_use_case.dart';
import 'package:dental_clinic_app/features/billing/domain/use_cases/list_invoices_use_case.dart';
import 'package:dental_clinic_app/features/billing/domain/use_cases/submit_payment_proof_use_case.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'billing_event.dart';
part 'billing_state.dart';
part 'billing_bloc.freezed.dart';

@injectable
class BillingBloc extends Bloc<BillingEvent, BillingState> {
  BillingBloc({
    required ListInvoicesUseCase listInvoices,
    required CreateInvoiceUseCase createInvoice,
    required SubmitPaymentProofUseCase submitProof,
    required BillingRepository repository,
  })  : _listInvoices = listInvoices,
        _createInvoice = createInvoice,
        _submitProof = submitProof,
        _repository = repository,
        super(const BillingState()) {
    on<_LoadInvoices>(_onLoadInvoices);
    on<_CreateInvoice>(_onCreateInvoice);
    on<_SelectInvoice>(_onSelectInvoice);
    on<_SubmitProof>(_onSubmitProof);
    on<_ClearFlags>(_onClearFlags);
    on<_AdminApproveInvoice>(_onAdminApproveInvoice);
    on<_AdminRejectInvoice>(_onAdminRejectInvoice);
    on<_InvoiceMutated>(_onInvoiceMutated);

    _changesSub = _repository.watchChanges().listen(
          (invoice) => add(BillingEvent.invoiceMutated(invoice)),
        );
  }

  final ListInvoicesUseCase _listInvoices;
  final CreateInvoiceUseCase _createInvoice;
  final SubmitPaymentProofUseCase _submitProof;
  final BillingRepository _repository;

  late final StreamSubscription<InvoiceEntity> _changesSub;

  @override
  Future<void> close() {
    _changesSub.cancel();
    return super.close();
  }

  Future<void> _onLoadInvoices(
    _LoadInvoices event,
    Emitter<BillingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _listInvoices(
      ListInvoicesParams(clinicId: event.clinicId),
    );
    result.fold(
      (err) => emit(state.copyWith(
        isLoading: false,
        error: NetworkExceptions.getErrorMessage(err),
      )),
      (invoices) => emit(state.copyWith(
        isLoading: false,
        clinicId: event.clinicId,
        invoices: invoices,
      )),
    );
  }

  Future<void> _onCreateInvoice(
    _CreateInvoice event,
    Emitter<BillingState> emit,
  ) async {
    emit(state.copyWith(isProcessing: true, error: null));
    final result = await _createInvoice(
      CreateInvoiceParams(
        clinicId: event.clinicId,
        plan: event.plan,
        cycle: event.cycle,
        isRenewal: event.isRenewal,
      ),
    );
    result.fold(
      (err) => emit(state.copyWith(
        isProcessing: false,
        error: NetworkExceptions.getErrorMessage(err),
      )),
      (invoice) {
        final next = [invoice, ...state.invoices];
        emit(state.copyWith(
          isProcessing: false,
          invoices: next,
          activeInvoice: invoice,
          activeInstructions: _repository.instructionsFor(invoice),
          createdInvoice: invoice,
        ));
      },
    );
  }

  void _onSelectInvoice(
    _SelectInvoice event,
    Emitter<BillingState> emit,
  ) {
    emit(state.copyWith(
      activeInvoice: event.invoice,
      activeInstructions: _repository.instructionsFor(event.invoice),
    ));
  }

  Future<void> _onSubmitProof(
    _SubmitProof event,
    Emitter<BillingState> emit,
  ) async {
    emit(state.copyWith(isProcessing: true, error: null));
    final result = await _submitProof(
      SubmitPaymentProofParams(
        invoiceId: event.invoiceId,
        receipt: event.receipt,
        referenceNumber: event.referenceNumber,
        method: event.method,
        notes: event.notes,
      ),
    );
    result.fold(
      (err) => emit(state.copyWith(
        isProcessing: false,
        error: NetworkExceptions.getErrorMessage(err),
      )),
      (invoice) => emit(state.copyWith(
        isProcessing: false,
        activeInvoice: invoice,
        proofSubmitted: true,
      )),
    );
  }

  void _onClearFlags(_ClearFlags event, Emitter<BillingState> emit) {
    emit(state.copyWith(
      createdInvoice: null,
      proofSubmitted: false,
      error: null,
    ));
  }

  Future<void> _onAdminApproveInvoice(
    _AdminApproveInvoice event,
    Emitter<BillingState> emit,
  ) async {
    emit(state.copyWith(isProcessing: true, error: null));
    final result = await _repository.approveInvoice(event.invoiceId);
    result.fold(
      (err) => emit(state.copyWith(
        isProcessing: false,
        error: NetworkExceptions.getErrorMessage(err),
      )),
      // The repo emits on the change stream; our _onInvoiceMutated will
      // handle the UI refresh. Here we just clear the processing flag.
      (_) => emit(state.copyWith(isProcessing: false)),
    );
  }

  Future<void> _onAdminRejectInvoice(
    _AdminRejectInvoice event,
    Emitter<BillingState> emit,
  ) async {
    emit(state.copyWith(isProcessing: true, error: null));
    final result = await _repository.rejectInvoice(
      event.invoiceId,
      reason: event.reason,
    );
    result.fold(
      (err) => emit(state.copyWith(
        isProcessing: false,
        error: NetworkExceptions.getErrorMessage(err),
      )),
      (_) => emit(state.copyWith(isProcessing: false)),
    );
  }

  void _onInvoiceMutated(
    _InvoiceMutated event,
    Emitter<BillingState> emit,
  ) {
    final updatedList = [
      for (final i in state.invoices)
        if (i.id == event.invoice.id) event.invoice else i,
    ];
    final isKnown = state.invoices.any((i) => i.id == event.invoice.id);
    final list = isKnown ? updatedList : [event.invoice, ...state.invoices];

    final activeMatches = state.activeInvoice?.id == event.invoice.id;
    emit(state.copyWith(
      invoices: list,
      activeInvoice: activeMatches ? event.invoice : state.activeInvoice,
      activeInstructions: activeMatches
          ? _repository.instructionsFor(event.invoice)
          : state.activeInstructions,
    ));
  }
}
