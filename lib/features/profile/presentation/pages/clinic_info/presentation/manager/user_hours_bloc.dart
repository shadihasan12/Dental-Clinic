import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/user_hours_models.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/repositories/working_days_repository.dart';
import 'package:injectable/injectable.dart';

part 'user_hours_bloc.freezed.dart';
part 'user_hours_event.dart';
part 'user_hours_state.dart';

@injectable
class UserHoursBloc extends Bloc<UserHoursEvent, UserHoursState> {
  final WorkingDaysRepository _repository;
  final String _userId;

  UserHoursBloc(
    this._repository, {
    @factoryParam required String userId,
  })  : _userId = userId,
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

    // No hours saved for this user yet — seed with static defaults so
    // the form has something for the user to edit and submit. We
    // intentionally don't fetch the clinic's working days here: that
    // endpoint is admin-only and 403s for non-admin doctors, who are
    // the primary users of this page.
    emit(UserHoursState.loaded(_staticSeed()));
  }

  /// Static 7-day defaults: Mon–Fri working full-time, Sat & Sun off.
  /// Matches the clinic-working-days page's own initial defaults so a
  /// doctor's first save lines up with what their clinic typically
  /// expects. `clinicWorkingDayId` is left blank — the server links
  /// the user-day to the clinic-day by `day_of_week` on upsert.
  List<UserWorkingDayApiModel> _staticSeed() {
    return List.generate(7, (i) {
      final dayOfWeek = i + 1; // 1=Mon … 7=Sun
      final isWeekend = dayOfWeek == 6 || dayOfWeek == 7;
      return UserWorkingDayApiModel(
        clinicWorkingDayId: '',
        dayOfWeek: dayOfWeek,
        isWorking: !isWeekend,
        isFullTime: true,
        ranges: const [],
      );
    });
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
