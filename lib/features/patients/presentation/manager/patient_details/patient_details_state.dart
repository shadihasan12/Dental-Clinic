part of 'patient_details_bloc.dart';

@freezed
class PatientDetailsState with _$PatientDetailsState {
  const factory PatientDetailsState.initial() = _Initial;

  const factory PatientDetailsState.loading() = _Loading;

  const factory PatientDetailsState.loaded({
    required PatientEntity patient,
    required DentalCase? activeCase,
    required List<DentalCase> completedCases,
  }) = _Loaded;

  const factory PatientDetailsState.error(String message) = _Error;
}
