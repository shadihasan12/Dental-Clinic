import 'package:dental_clinic_app/features/profile/presentation/pages/notifications_settngs/domain/entities/notification_settings_entity.dart';

/// Wire model for one entry of `GET /notification-settings`.
class NotificationSettingModel {
  final String key;
  final String name;
  final String? description;
  final bool enabled;
  final String? audience;

  const NotificationSettingModel({
    required this.key,
    required this.name,
    this.description,
    required this.enabled,
    this.audience,
  });

  factory NotificationSettingModel.fromJson(Map<String, dynamic> json) {
    return NotificationSettingModel(
      key: json['key'] as String? ?? '',
      name: json['name'] as String? ?? '',
      // Documented as possibly absent, not merely null.
      description: json['description'] as String?,
      enabled: json['enabled'] as bool? ?? false,
      // Present only for broadcast categories.
      audience: json['audience'] as String?,
    );
  }

  NotificationSettingEntity toEntity() {
    return NotificationSettingEntity(
      key: key,
      name: name,
      description: description,
      enabled: enabled,
      audience: audience,
    );
  }
}
