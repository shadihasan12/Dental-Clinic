import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/user_hours_models.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/working_days_models.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/repositories/working_days_repository.dart';
import 'package:injectable/injectable.dart';

part 'user_hours_bloc.freezed.dart';
part 'user_hours_event.dart';
part 'user_hours_state.dart';

@injectable
class UserHoursBloc extends Bloc<UserHoursEvent, UserHoursState> {
  final WorkingDaysRepository _repository;
  final UserStorage _userStorage;
  final String _userId;

  UserHoursBloc(
    this._repository,
    this._userStorage, {
    @factoryParam required String userId,
  }) : _userId = userId,
       super(const UserHoursState.initial()) {
    on<_Load>(_onLoad);
    on<_Save>(_onSave);
  }

  Future<void> _onLoad(_Load event, Emitter<UserHoursState> emit) async {
    emit(const UserHoursState.loading());

    final userResult = await _repository.getMyHours();

    final userError = userResult.fold(
      (e) => NetworkExceptions.getErrorMessage(e),
      (_) => null,
    );
    if (userError != null) {
      emit(UserHoursState.error(userError));
      return;
    }

    final userDays = userResult.getOrElse(() => const []);
    if (userDays.isNotEmpty) {
      emit(UserHoursState.loaded(userDays));
      return;
    }

    // No hours saved yet. The user-hours upsert requires a real
    // `clinic_working_day_id` per day, so we can't just save the
    // generic static seed — we have to anchor each row to a clinic
    // working day. Branch on role:
    //
    //   • Admin → try to read the clinic's working days. If they
    //     exist, seed the user form from them (real IDs, save works).
    //     If they're empty, route the admin to set them up first.
    //   • Non-admin → we can't read /clinics/working-days (admin-only).
    //     Surface a "ask your admin" empty state instead of letting
    //     the user hit a 400 on save.
    final isAdmin = _userStorage.isAdmin;
    if (!isAdmin) {
      emit(const UserHoursState.needsClinicHours(isAdmin: false));
      return;
    }

    final clinicResult = await _repository.getWorkingDays();
    final clinicDays = clinicResult.fold<List<WorkingDayApiModel>>(
      // On error (network, 403, anything), treat clinic hours as not
      // set up — the admin's next step is to create them, same as if
      // the list had legitimately been empty.
      (_) => const [],
      (days) => days,
    );

    if (clinicDays.isEmpty) {
      emit(const UserHoursState.needsClinicHours(isAdmin: true));
      return;
    }

    emit(UserHoursState.loaded(_seedFromClinic(clinicDays), isSeed: true));
  }

  /// Seed every clinic working day as enabled and full-time so the
  /// admin can save sensible defaults in one tap. We keep
  /// `clinicWorkingDayId` from the clinic record so the upsert
  /// validation passes.
  List<UserWorkingDayApiModel> _seedFromClinic(List<WorkingDayApiModel> days) {
    return days
        .map(
          (c) => UserWorkingDayApiModel(
            clinicWorkingDayId: c.id,
            dayOfWeek: c.dayOfWeek,
            isWorking: c.isOpen,
            isFullTime: true,
            ranges: const [],
          ),
        )
        .toList();
  }

  Future<void> _onSave(_Save event, Emitter<UserHoursState> emit) async {
    emit(const UserHoursState.saving());
    final result = await _repository.upsertUserHours(_userId, event.days);
    result.fold(
      (e) => emit(UserHoursState.error(NetworkExceptions.getErrorMessage(e))),
      (_) => emit(const UserHoursState.saved()),
    );
  }
}
