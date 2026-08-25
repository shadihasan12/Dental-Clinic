import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/features/home/domain/entities/notification_entity.dart';
import 'package:dental_clinic_app/features/root/presentation/pages/root_page.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

/// Turns a notification's `data` payload into a destination.
///
/// The same map arrives two ways: typed from `GET /notifications`, and as
/// all-strings through FCM (an FCM constraint). `type` is always present and
/// names the screen.
///
/// Unknown `type` values MUST NOT crash — new categories are added
/// server-side and will reach builds that have never heard of them. Falling
/// through to the notification list is the correct behaviour.
class NotificationRouting {
  NotificationRouting._();

  /// Index of the Appointments tab in [RootPage]'s bottom bar.
  static const int _appointmentsTabIndex = 2;

  /// Index of the "Case" tab on the patient-details screen — payments live
  /// inside it.
  static const int _caseTabIndex = 1;

  static const String notificationsPath = '/notifications';

  static String? _string(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value == null) return null;
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }

  /// The `type` this payload carries, or an empty string when absent.
  static String typeOf(Map<String, dynamic> data) =>
      _string(data, 'type') ?? _string(data, 'category') ?? '';

  /// Where a tap on this payload should land, expressed as a location string.
  ///
  /// Used only for de-duplicating consecutive taps; the actual navigation goes
  /// through [navigate], because some destinations need `extra` objects that a
  /// path cannot carry.
  static String locationFor(Map<String, dynamic> data) {
    switch (typeOf(data)) {
      case NotificationCategories.appointmentReminder:
        return '/';
      case NotificationCategories.paymentReminder:
        return '/patients-details';
      case NotificationCategories.clinicInvitation:
        return '/my-clinics';
      default:
        return notificationsPath;
    }
  }

  /// Navigates [router] to wherever [data] points.
  ///
  /// `push`, not `go`: every route involved is top-level, so `go` would
  /// replace the whole stack and leave the destination with nothing to pop
  /// back to.
  static void navigate(GoRouter router, Map<String, dynamic> data) {
    final type = typeOf(data);

    switch (type) {
      case NotificationCategories.appointmentReminder:
        // There is no standalone appointment-detail route; the appointments
        // list is a RootPage tab, so switch to it instead of pushing.
        router.go('/');
        RootPage.selectedTab.value = _appointmentsTabIndex;
        return;

      case NotificationCategories.paymentReminder:
        final patientId = _string(data, 'patient_id');
        if (patientId == null) break;
        router.pushNamed(
          AppRoutesNames.patientDetails,
          extra: <String, dynamic>{
            'patientId': patientId,
            'patientName': '',
            'tabIndex': _caseTabIndex,
          },
        );
        return;

      case NotificationCategories.clinicInvitation:
        // Received invitations are a section of the "My clinics" screen.
        router.pushNamed(AppRoutesNames.myClinics);
        return;

      case NotificationCategories.announcement:
        break;

      default:
        if (kDebugMode) {
          debugPrint('[notifications] unknown type "$type" - showing inbox');
        }
        break;
    }

    // Announcements, and anything this build does not recognise, land safely
    // on the inbox.
    router.pushNamed(AppRoutesNames.notifications);
  }
}
