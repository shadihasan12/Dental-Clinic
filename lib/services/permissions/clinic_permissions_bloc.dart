import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_clinic_app/services/permissions/clinic_permissions_entity.dart';
import 'package:dental_clinic_app/services/permissions/clinic_permissions_service.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';

part 'clinic_permissions_bloc.freezed.dart';

@freezed
class ClinicPermissionsEvent with _$ClinicPermissionsEvent {
  const factory ClinicPermissionsEvent.load() = _Load;

  /// Re-reads the permissions without passing through `loading`.
  ///
  /// For resume, after a payment and after a 402: a full [load] would flash
  /// every [PermissionGate] to a spinner and reshuffle the tab bar while the
  /// user is looking at it. A failed refresh keeps what was already loaded.
  const factory ClinicPermissionsEvent.refresh() = _Refresh;
}

@freezed
class ClinicPermissionsState with _$ClinicPermissionsState {
  const factory ClinicPermissionsState.initial() = _Initial;
  const factory ClinicPermissionsState.loading() = _Loading;
  const factory ClinicPermissionsState.loaded(
    ClinicPermissionsEntity permissions,
  ) = _Loaded;
  const factory ClinicPermissionsState.error(String message) = _Error;
}

@lazySingleton
class ClinicPermissionsBloc
    extends Bloc<ClinicPermissionsEvent, ClinicPermissionsState> {
  final ClinicPermissionsService _service;

  ClinicPermissionsBloc(this._service)
      : super(const ClinicPermissionsState.initial()) {
    on<_Load>(_onLoad);
    on<_Refresh>(_onRefresh);
  }

  Future<void> _onLoad(
    _Load event,
    Emitter<ClinicPermissionsState> emit,
  ) async {
    emit(const ClinicPermissionsState.loading());

    final result = await _service.getPermissions();

    result.fold(
      (error) => emit(
        ClinicPermissionsState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (permissions) => emit(ClinicPermissionsState.loaded(permissions)),
    );
  }

  Future<void> _onRefresh(
    _Refresh event,
    Emitter<ClinicPermissionsState> emit,
  ) async {
    final result = await _service.getPermissions();
    result.fold(
      (_) {},
      (permissions) => emit(ClinicPermissionsState.loaded(permissions)),
    );
  }

  bool hasFeature(String slug) {
    return state.maybeWhen(
      loaded: (permissions) => permissions.hasFeature(slug),
      orElse: () => false,
    );
  }
}
