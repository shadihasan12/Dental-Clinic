import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/get_my_clinics_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'my_clinics_event.dart';
part 'my_clinics_state.dart';
part 'my_clinics_bloc.freezed.dart';

@injectable
class MyClinicsBloc extends Bloc<MyClinicsEvent, MyClinicsState> {
  final GetMyClinicsUseCase _getMyClinicsUseCase;
  final UserStorage _userStorage;

  MyClinicsBloc(this._getMyClinicsUseCase, this._userStorage)
      : super(const MyClinicsState.initial()) {
    on<_Load>(_onLoad);
  }

  Future<void> _onLoad(_Load event, Emitter<MyClinicsState> emit) async {
    emit(const MyClinicsState.loading());
    final result = await _getMyClinicsUseCase();
    result.fold(
      (error) => emit(
        MyClinicsState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (clinics) {
        // Keep the cached role in sync with whichever clinic the user is
        // currently scoped to. The selected clinic id itself is owned by
        // the explicit "Use this clinic" action — we never override it
        // here, only backfill if login somehow left it empty.
        final activeId = _userStorage.getSelectedClinicId();
        final active = clinics.cast<ClinicMembershipEntity?>().firstWhere(
              (c) => c!.clinicId == activeId,
              orElse: () => clinics.isNotEmpty ? clinics.first : null,
            );
        if (active != null) {
          if (activeId == null || activeId.isEmpty) {
            _userStorage.saveSelectedClinicId(active.clinicId);
          }
          _userStorage.saveUserRole(active.role.name);
        }
        emit(MyClinicsState.loaded(clinics));
      },
    );
  }
}
