import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
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
  final TokenStorage _tokenStorage;
  final String _userId;

  UserHoursBloc(
    this._repository,
    this._userStorage,
    this._tokenStorage, {
    @factoryParam required String userId,
  })  : _userId = userId,
        super(const UserHoursState.initial()) {
    on<_Load>(_onLoad);
    on<_Save>(_onSave);
  }

  /// Whether this page is the signed-in user looking at their own schedule.
  ///
  /// The two cases read from different endpoints: `my-hours` resolves the user
  /// from the bearer token, while the admin screens must name the member in
  /// the path. Using the first for everyone was why opening any member's page
  /// showed the admin's own hours.
  bool get _isSelf {
    final me = _tokenStorage.getUserId();
    return me != null && me.isNotEmpty && me == _userId;
  }

  Future<void> _onLoad(_Load event, Emitter<UserHoursState> emit) async {
    emit(const UserHoursState.loading());

    final userResult = _isSelf
        ? await _repository.getMyHours()
        : await _repository.getUserHours(_userId);

    final userError = userResult.fold(
      (e) => NetworkExceptions.getErrorMessage(e),
      (_) => null,
    );
    if (userError != null) {
      emit(UserHoursState.error(userError));
      return;
    }

    // The clinic's own schedule is now read on every load, not just when
    // seeding. The form needs it while editing: a full-time day is saved with
    // the clinic's real ranges rather than an empty list, a new shift starts
    // from the clinic's opening time, and an edit is checked against those
    // hours before it is sent.
    //
    // Reading it is admin-only, so a failure is not fatal - it just means the
    // form does without those three things.
    final clinicResult = await _repository.getWorkingDays();
    final clinicDays = clinicResult.fold<List<WorkingDayApiModel>>(
      (_) => const [],
      (days) => days,
    );

    final userDays = userResult.getOrElse(() => const []);
    if (userDays.isNotEmpty) {
      emit(UserHoursState.loaded(userDays, clinicDays: clinicDays));
      return;
    }

    // No hours saved yet. The user-hours upsert requires a real
    // `clinic_working_day_id` per day, so we can't just save the
    // generic static seed — we have to anchor each row to a clinic
    // working day. Branch on role:
    //
    //   • Admin → seed the user form from the clinic's working days
    //     (real IDs, so the save is accepted). If the clinic has none,
    //     route the admin to set them up first.
    //   • Non-admin → we can't read /clinics/working-days (admin-only),
    //     so clinicDays is empty and there is nothing to anchor to.
    //     Surface a "ask your admin" empty state instead of letting
    //     the user hit a 400 on save.
    if (clinicDays.isEmpty) {
      emit(UserHoursState.needsClinicHours(isAdmin: _userStorage.isAdmin));
      return;
    }

    emit(
      UserHoursState.loaded(
        _seedFromClinic(clinicDays),
        isSeed: true,
        clinicDays: clinicDays,
      ),
    );
  }

  /// Seed every clinic working day as enabled and full-time so the
  /// admin can save sensible defaults in one tap. We keep
  /// `clinicWorkingDayId` from the clinic record so the upsert
  /// validation passes, and the clinic's own ranges so a full-time day
  /// carries real times rather than an empty list.
  List<UserWorkingDayApiModel> _seedFromClinic(List<WorkingDayApiModel> days) {
    return days
        .map(
          (c) => UserWorkingDayApiModel(
            clinicWorkingDayId: c.id,
            dayOfWeek: c.dayOfWeek,
            isWorking: c.isOpen,
            isFullTime: true,
            ranges: c.ranges,
          ),
        )
        .toList();
  }

  Future<void> _onSave(_Save event, Emitter<UserHoursState> emit) async {
    emit(const UserHoursState.saving());

    final result = await _repository.upsertUserHours(_userId, event.days);
    result.fold(
      // saveFailed, not error: the page holds the edited days itself and keeps
      // the form up, so the user's work survives a rejected save.
      (e) =>
          emit(UserHoursState.saveFailed(NetworkExceptions.getErrorMessage(e))),
      (_) => emit(const UserHoursState.saved()),
    );
  }
}
