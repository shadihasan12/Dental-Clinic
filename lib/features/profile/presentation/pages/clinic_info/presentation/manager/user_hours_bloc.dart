import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
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

    final userResult = await _repository.getUserHours(_userId);

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

    // No hours saved for this user yet — seed from the clinic's working
    // days so the form has something for the user to edit and save.
    final clinicResult = await _repository.getWorkingDays();
    clinicResult.fold(
      (e) => emit(UserHoursState.error(NetworkExceptions.getErrorMessage(e))),
      (clinicDays) => emit(UserHoursState.loaded(_seedFromClinic(clinicDays))),
    );
  }

  List<UserWorkingDayApiModel> _seedFromClinic(List<WorkingDayApiModel> days) {
    // Seed every clinic working day as enabled and full-time so the user
    // can immediately save sensible defaults and customise from there.
    return days
        .map(
          (c) => UserWorkingDayApiModel(
            clinicWorkingDayId: c.id,
            dayOfWeek: c.dayOfWeek,
            isWorking: true,
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
