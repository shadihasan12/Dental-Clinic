import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings_entity.freezed.dart';

/// One switch on the notification-settings screen, exactly as the server
/// described it.
///
/// The whole screen is built from a list of these — no category name,
/// description or ordering is hardcoded anywhere in the app, because they can
/// change server-side without a release.
///
/// Categories that cannot be switched off (`clinic_invitation` today) are
/// simply absent from the response. They still arrive and still appear in the
/// inbox; do not render a disabled switch for them, you will never see them
/// here.
@freezed
class NotificationSettingEntity with _$NotificationSettingEntity {
  const factory NotificationSettingEntity({
    /// Send this back when toggling. Never shown to the user.
    required String key,

    /// The switch label, already translated by the server.
    required String name,

    /// Sub-label. May be absent entirely — check before rendering.
    String? description,
    @Default(true) bool enabled,

    /// Present only for broadcast categories, and the **only** source of
    /// Firebase topic names in this app. Today: `announcement_ar` /
    /// `announcement_en`, and the server decides which. Subscribe to the exact
    /// string, only while [enabled] is true; never build the name.
    String? audience,
  }) = _NotificationSettingEntity;

  const NotificationSettingEntity._();

  /// Whether this category is delivered through a topic rather than straight
  /// to the device token.
  bool get isBroadcast => audience != null && audience!.isNotEmpty;
}
