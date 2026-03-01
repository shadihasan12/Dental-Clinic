import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings_entity.freezed.dart';

@freezed
class NotificationSettingsEntity with _$NotificationSettingsEntity {
  const factory NotificationSettingsEntity({
    // Reminders
    @Default(true) bool appointmentReminders,
    @Default(true) bool paymentReminders,
    @Default(false) bool patientFollowUp,
    // Updates
    @Default(true) bool newsAndUpdates,
    @Default(true) bool newFeatures,
    @Default(false) bool promotionalOffers,
    @Default(true) bool statisticsUpdates,
    // Communication
    @Default(true) bool pushNotifications,
    @Default(true) bool emailNotifications,
  }) = _NotificationSettingsEntity;
}
