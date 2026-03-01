import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/add_patient_use_case.dart';
import 'package:injectable/injectable.dart';

part 'add_patient_bloc.freezed.dart';
part 'add_patient_event.dart';
part 'add_patient_state.dart';

@injectable
class AddPatientBloc extends Bloc<AddPatientEvent, AddPatientState> {
  final AddPatientUseCase _addPatient;

  AddPatientBloc({
    required AddPatientUseCase addPatient,
  })  : _addPatient = addPatient,
        super(const AddPatientState.initial()) {
    on<_Submit>(_onSubmit);
  }

  Future<void> _onSubmit(
    _Submit event,
    Emitter<AddPatientState> emit,
  ) async {
    emit(const AddPatientState.saving());

    final result = await _addPatient(event.patient);

    result.fold(
      (error) => emit(
        AddPatientState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (patient) => emit(AddPatientState.success(patient)),
    );
  }
}
