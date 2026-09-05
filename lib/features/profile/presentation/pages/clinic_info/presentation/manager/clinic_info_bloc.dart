import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/entities/clinic_info_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/use_cases/get_clinic_info_use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/use_cases/update_clinic_info_use_case.dart';
import 'package:injectable/injectable.dart';

part 'clinic_info_bloc.freezed.dart';
part 'clinic_info_event.dart';
part 'clinic_info_state.dart';

@injectable
class ClinicInfoBloc extends Bloc<ClinicInfoEvent, ClinicInfoState> {
  final GetClinicInfoUseCase _getClinicInfo;
  final UpdateClinicInfoUseCase _updateClinicInfo;

  ClinicInfoBloc({
    required GetClinicInfoUseCase getClinicInfo,
    required UpdateClinicInfoUseCase updateClinicInfo,
  })  : _getClinicInfo = getClinicInfo,
        _updateClinicInfo = updateClinicInfo,
        super(const ClinicInfoState.initial()) {
    on<_LoadClinicInfo>(_onLoad);
    on<_UpdateClinicInfo>(_onUpdate);
  }

  Future<void> _onLoad(
    _LoadClinicInfo event,
    Emitter<ClinicInfoState> emit,
  ) async {
    emit(const ClinicInfoState.loading());

    final result = await _getClinicInfo(NoParams());

    result.fold(
      (error) =>
          emit(ClinicInfoState.error(NetworkExceptions.getErrorMessage(error))),
      (clinicInfo) => emit(ClinicInfoState.loaded(clinicInfo)),
    );
  }

  Future<void> _onUpdate(
    _UpdateClinicInfo event,
    Emitter<ClinicInfoState> emit,
  ) async {
    emit(ClinicInfoState.saving(event.clinicInfo));

    final result = await _updateClinicInfo(event.clinicInfo);

    result.fold(
      (error) =>
          emit(ClinicInfoState.error(NetworkExceptions.getErrorMessage(error))),
      (clinicInfo) => emit(ClinicInfoState.saved(clinicInfo)),
    );
  }
}
