import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_patient_cases_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_patient_details_use_case.dart';
import 'package:injectable/injectable.dart';

part 'patient_details_bloc.freezed.dart';
part 'patient_details_event.dart';
part 'patient_details_state.dart';

@injectable
class PatientDetailsBloc
    extends Bloc<PatientDetailsEvent, PatientDetailsState> {
  final GetPatientDetailsUseCase _getPatientDetails;
  final GetPatientCasesUseCase _getPatientCases;

  PatientDetailsBloc({
    required GetPatientDetailsUseCase getPatientDetails,
    required GetPatientCasesUseCase getPatientCases,
  })  : _getPatientDetails = getPatientDetails,
        _getPatientCases = getPatientCases,
        super(const PatientDetailsState.initial()) {
    on<_LoadPatientDetails>(_onLoadPatientDetails);
    on<_MarkCaseAsFinished>(_onMarkCaseAsFinished);
  }

  Future<void> _onLoadPatientDetails(
    _LoadPatientDetails event,
    Emitter<PatientDetailsState> emit,
  ) async {
    emit(const PatientDetailsState.loading());

    final patientResult = await _getPatientDetails(event.patientId);

    NetworkExceptions? patientError;
    PatientEntity? patient;
    patientResult.fold(
      (error) => patientError = error,
      (value) => patient = value,
    );
    if (patientError != null) {
      emit(PatientDetailsState.error(
        NetworkExceptions.getErrorMessage(patientError!),
      ));
      return;
    }

    final casesResult = await _getPatientCases(
      PatientCasesParams(patientId: event.patientId),
    );

    casesResult.fold(
      (error) => emit(
        PatientDetailsState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (cases) => emit(
        PatientDetailsState.loaded(
          patient: patient!,
          activeCase: cases.activeCase,
          completedCases: cases.completedCases,
        ),
      ),
    );
  }

  void _onMarkCaseAsFinished(
    _MarkCaseAsFinished event,
    Emitter<PatientDetailsState> emit,
  ) {
    state.mapOrNull(
      loaded: (loaded) {
        if (loaded.activeCase == null) return;
        final completedCase = loaded.activeCase!.copyWith(
          status: 'Completed',
          endDate: DateTime.now(),
        );
        emit(PatientDetailsState.loaded(
          patient: loaded.patient,
          activeCase: null,
          completedCases: [completedCase, ...loaded.completedCases],
        ));
      },
    );
  }
}
