import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/add_payment_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_patient_details_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/mark_case_as_finished_use_case.dart';
import 'package:injectable/injectable.dart';

part 'patient_details_bloc.freezed.dart';
part 'patient_details_event.dart';
part 'patient_details_state.dart';

@injectable
class PatientDetailsBloc
    extends Bloc<PatientDetailsEvent, PatientDetailsState> {
  final GetPatientDetailsUseCase _getPatientDetails;
  final MarkCaseAsFinishedUseCase _markCaseAsFinished;
  final AddPaymentUseCase _addPayment;

  PatientDetailsBloc({
    required GetPatientDetailsUseCase getPatientDetails,
    required MarkCaseAsFinishedUseCase markCaseAsFinished,
    required AddPaymentUseCase addPayment,
  })  : _getPatientDetails = getPatientDetails,
        _markCaseAsFinished = markCaseAsFinished,
        _addPayment = addPayment,
        super(const PatientDetailsState.initial()) {
    on<_LoadPatientDetails>(_onLoadPatientDetails);
    on<_MarkCaseAsFinished>(_onMarkCaseAsFinished);
    on<_AddPayment>(_onAddPayment);
  }

  Future<void> _onLoadPatientDetails(
    _LoadPatientDetails event,
    Emitter<PatientDetailsState> emit,
  ) async {
    emit(const PatientDetailsState.loading());

    final result = await _getPatientDetails(event.patientId);

    result.fold(
      (error) => emit(
        PatientDetailsState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (details) => emit(
        PatientDetailsState.loaded(
          patient: details.patient,
          activeCase: details.activeCase,
          completedCases: details.completedCases,
        ),
      ),
    );
  }

  Future<void> _onMarkCaseAsFinished(
    _MarkCaseAsFinished event,
    Emitter<PatientDetailsState> emit,
  ) async {
    final result = await _markCaseAsFinished(
      MarkCaseAsFinishedParams(
        patientId: event.patientId,
        caseId: event.caseId,
        title: event.title,
      ),
    );

    result.fold(
      (error) => emit(
        PatientDetailsState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (_) => add(PatientDetailsEvent.loadPatientDetails(event.patientId)),
    );
  }

  Future<void> _onAddPayment(
    _AddPayment event,
    Emitter<PatientDetailsState> emit,
  ) async {
    final result = await _addPayment(
      AddPaymentParams(
        patientId: event.patientId,
        caseId: event.caseId,
        amount: event.amount,
        currencyId: event.currencyId,
        caseCurrencyId: event.caseCurrencyId,
        amountInCaseCurrency: event.amountInCaseCurrency,
        exchangeRate: event.exchangeRate,
        notes: event.notes,
      ),
    );

    result.fold(
      (error) => emit(
        PatientDetailsState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (_) => add(PatientDetailsEvent.loadPatientDetails(event.patientId)),
    );
  }
}
