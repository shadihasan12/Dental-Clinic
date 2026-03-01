import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/add_treatment_use_case.dart';
import 'package:injectable/injectable.dart';

part 'add_treatment_bloc.freezed.dart';
part 'add_treatment_event.dart';
part 'add_treatment_state.dart';

@injectable
class AddTreatmentBloc extends Bloc<AddTreatmentEvent, AddTreatmentState> {
  final AddTreatmentUseCase _addTreatment;

  AddTreatmentBloc({
    required AddTreatmentUseCase addTreatment,
  })  : _addTreatment = addTreatment,
        super(const AddTreatmentState.initial()) {
    on<_Submit>(_onSubmit);
  }

  Future<void> _onSubmit(
    _Submit event,
    Emitter<AddTreatmentState> emit,
  ) async {
    emit(const AddTreatmentState.saving());

    final result = await _addTreatment(event.params);

    result.fold(
      (error) => emit(
        AddTreatmentState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (treatment) => emit(AddTreatmentState.success(treatment)),
    );
  }
}
