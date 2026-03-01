part of 'add_treatment_bloc.dart';

@freezed
class AddTreatmentState with _$AddTreatmentState {
  const factory AddTreatmentState.initial() = _Initial;
  const factory AddTreatmentState.saving() = _Saving;
  const factory AddTreatmentState.success(TreatmentItem treatment) = _Success;
  const factory AddTreatmentState.error(String message) = _Error;
}
