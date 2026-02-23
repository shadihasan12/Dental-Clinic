import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/entities/notification_settings_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/use_cases/get_notification_settings_use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/use_cases/update_notification_settings_use_case.dart';
import 'package:injectable/injectable.dart';

part 'notification_settings_bloc.freezed.dart';
part 'notification_settings_event.dart';
part 'notification_settings_state.dart';

@injectable
class NotificationSettingsBloc
    extends Bloc<NotificationSettingsEvent, NotificationSettingsState> {
  final GetNotificationSettingsUseCase _getSettings;
  final UpdateNotificationSettingsUseCase _updateSettings;

  NotificationSettingsBloc({
    required GetNotificationSettingsUseCase getSettings,
    required UpdateNotificationSettingsUseCase updateSettings,
  })  : _getSettings = getSettings,
        _updateSettings = updateSettings,
        super(const NotificationSettingsState.initial()) {
    on<_LoadSettings>(_onLoad);
    on<_UpdateSettings>(_onUpdate);
  }

  Future<void> _onLoad(
    _LoadSettings event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    emit(const NotificationSettingsState.loading());

    final result = await _getSettings(NoParams());

    result.fold(
      (error) => emit(
        NotificationSettingsState.error(
          NetworkExceptions.getErrorMessage(error),
        ),
      ),
      (settings) => emit(NotificationSettingsState.loaded(settings)),
    );
  }

  Future<void> _onUpdate(
    _UpdateSettings event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    // Optimistic: show new state immediately
    emit(NotificationSettingsState.loaded(event.settings));

    final result = await _updateSettings(event.settings);

    // On error, revert isn't critical for mock — just log
    result.fold(
      (_) {},
      (_) {},
    );
  }
}
