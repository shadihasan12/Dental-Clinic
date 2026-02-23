import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_all_patients_use_case.dart';
import 'package:injectable/injectable.dart';

part 'patients_list_bloc.freezed.dart';
part 'patients_list_event.dart';
part 'patients_list_state.dart';

@injectable
class PatientsListBloc extends Bloc<PatientsListEvent, PatientsListState> {
  final GetAllPatientsUseCase _getAllPatients;

  PatientsListBloc({
    required GetAllPatientsUseCase getAllPatients,
  })  : _getAllPatients = getAllPatients,
        super(const PatientsListState.initial()) {
    on<_LoadPatients>(_onLoadPatients);
  }

  Future<void> _onLoadPatients(
    _LoadPatients event,
    Emitter<PatientsListState> emit,
  ) async {
    print("LOADING PATIENTS...");
    emit(const PatientsListState.loading());

    final result = await _getAllPatients(NoParams());

    result.fold(
      (error) => emit(
        PatientsListState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (patients) => emit(PatientsListState.loaded(patients)),
    );
  }
}
