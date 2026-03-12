part of 'my_clinics_bloc.dart';

@freezed
class MyClinicsState with _$MyClinicsState {
  const factory MyClinicsState.initial() = _Initial;
  const factory MyClinicsState.loading() = _Loading;
  const factory MyClinicsState.loaded(
    List<ClinicMembershipEntity> clinics,
  ) = _Loaded;
  const factory MyClinicsState.error(String message) = _Error;
}
