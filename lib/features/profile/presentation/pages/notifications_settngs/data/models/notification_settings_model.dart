import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/entities/notification_settings_entity.dart';

class NotificationSettingsModel {
  final bool appointmentReminders;
  final bool paymentReminders;
  final bool patientFollowUp;
  final bool newsAndUpdates;
  final bool newFeatures;
  final bool promotionalOffers;
  final bool statisticsUpdates;
  final bool pushNotifications;
  final bool emailNotifications;

  const NotificationSettingsModel({
    required this.appointmentReminders,
    required this.paymentReminders,
    required this.patientFollowUp,
    required this.newsAndUpdates,
    required this.newFeatures,
    required this.promotionalOffers,
    required this.statisticsUpdates,
    required this.pushNotifications,
    required this.emailNotifications,
  });

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) {
    return NotificationSettingsModel(
      appointmentReminders: json['appointmentReminders'] as bool? ?? true,
      paymentReminders: json['paymentReminders'] as bool? ?? true,
      patientFollowUp: json['patientFollowUp'] as bool? ?? false,
      newsAndUpdates: json['newsAndUpdates'] as bool? ?? true,
      newFeatures: json['newFeatures'] as bool? ?? true,
      promotionalOffers: json['promotionalOffers'] as bool? ?? false,
      statisticsUpdates: json['statisticsUpdates'] as bool? ?? true,
      pushNotifications: json['pushNotifications'] as bool? ?? true,
      emailNotifications: json['emailNotifications'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointmentReminders': appointmentReminders,
      'paymentReminders': paymentReminders,
      'patientFollowUp': patientFollowUp,
      'newsAndUpdates': newsAndUpdates,
      'newFeatures': newFeatures,
      'promotionalOffers': promotionalOffers,
      'statisticsUpdates': statisticsUpdates,
      'pushNotifications': pushNotifications,
      'emailNotifications': emailNotifications,
    };
  }

  factory NotificationSettingsModel.fromEntity(
    NotificationSettingsEntity entity,
  ) {
    return NotificationSettingsModel(
      appointmentReminders: entity.appointmentReminders,
      paymentReminders: entity.paymentReminders,
      patientFollowUp: entity.patientFollowUp,
      newsAndUpdates: entity.newsAndUpdates,
      newFeatures: entity.newFeatures,
      promotionalOffers: entity.promotionalOffers,
      statisticsUpdates: entity.statisticsUpdates,
      pushNotifications: entity.pushNotifications,
      emailNotifications: entity.emailNotifications,
    );
  }

  NotificationSettingsEntity toEntity() {
    return NotificationSettingsEntity(
      appointmentReminders: appointmentReminders,
      paymentReminders: paymentReminders,
      patientFollowUp: patientFollowUp,
      newsAndUpdates: newsAndUpdates,
      newFeatures: newFeatures,
      promotionalOffers: promotionalOffers,
      statisticsUpdates: statisticsUpdates,
      pushNotifications: pushNotifications,
      emailNotifications: emailNotifications,
    );
  }
}
