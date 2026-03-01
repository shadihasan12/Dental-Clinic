part of 'add_treatment_bloc.dart';

@freezed
class AddTreatmentEvent with _$AddTreatmentEvent {
  const factory AddTreatmentEvent.submit(AddTreatmentParams params) = _Submit;
}
