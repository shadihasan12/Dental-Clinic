import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_topics_synchronizer.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/entities/notification_settings_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/use_cases/get_notification_settings_use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/use_cases/update_notification_settings_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'notification_settings_bloc.freezed.dart';
part 'notification_settings_event.dart';
part 'notification_settings_state.dart';

@injectable
class NotificationSettingsBloc
    extends Bloc<NotificationSettingsEvent, NotificationSettingsState> {
  final GetNotificationSettingsUseCase _getSettings;
  final UpdateNotificationSettingUseCase _updateSetting;
  final NotificationTopicsSynchronizer _topics;

  NotificationSettingsBloc({
    required GetNotificationSettingsUseCase getSettings,
    required UpdateNotificationSettingUseCase updateSetting,
    required NotificationTopicsSynchronizer topics,
  })  : _getSettings = getSettings,
        _updateSetting = updateSetting,
        _topics = topics,
        super(const NotificationSettingsState()) {
    on<_Load>(_onLoad);
    on<_Toggle>(_onToggle);
  }

  Future<void> _onLoad(
    _Load event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    emit(state.copyWith(
      status: NotificationSettingsStatus.loading,
      errorMessage: null,
    ));

    final result = await _getSettings(NoParams());

    await result.fold(
      (error) async => emit(state.copyWith(
        status: NotificationSettingsStatus.failure,
        errorMessage: NetworkExceptions.getErrorMessage(error),
      )),
      (settings) async {
        emit(state.copyWith(
          status: NotificationSettingsStatus.success,
          settings: settings,
          errorMessage: null,
        ));
        // Opening the screen is a good moment to re-assert the subscriptions:
        // we have a fresh, authoritative list of audiences in hand.
        await _topics.applyFrom(settings);
      },
    );
  }

  Future<void> _onToggle(
    _Toggle event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    final index = state.settings.indexWhere((s) => s.key == event.key);
    if (index == -1) return;

    final previous = state.settings[index];
    if (previous.enabled == event.enabled) return;

    // Optimistic: a switch that lags behind the finger feels broken. `pending`
    // keeps the row from being toggled again while the PATCH is in flight.
    final optimistic = [...state.settings];
    optimistic[index] = previous.copyWith(enabled: event.enabled);
    emit(state.copyWith(
      settings: optimistic,
      pendingKeys: {...state.pendingKeys, event.key},
    ));

    final result = await _updateSetting(
      UpdateNotificationSettingParams(
        category: event.key,
        enabled: event.enabled,
      ),
    );

    final pending = {...state.pendingKeys}..remove(event.key);

    await result.fold(
      (error) async {
        // Put the switch back where the server still has it.
        final reverted = [...state.settings];
        final i = reverted.indexWhere((s) => s.key == event.key);
        if (i != -1) reverted[i] = previous;
        emit(state.copyWith(
          settings: reverted,
          pendingKeys: pending,
          errorMessage: NetworkExceptions.getErrorMessage(error),
        ));
      },
      (_) async {
        emit(state.copyWith(pendingKeys: pending, errorMessage: null));
        // A broadcast category's switch *is* its topic subscription — flipping
        // it off has to unsubscribe, or the push keeps arriving.
        if (previous.isBroadcast) {
          await _topics.applyFrom(state.settings);
        }
      },
    );
  }
}
