import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';

/// Single source of truth for the visual treatment of [AppointmentStatus].
class AppointmentStatusStyles {
  AppointmentStatusStyles._();

  /// Order shown in the status picker. Mirrors a typical clinic workflow.
  static const List<AppointmentStatus> all = [
    AppointmentStatus.scheduled,
    AppointmentStatus.confirmed,
    AppointmentStatus.completed,
    AppointmentStatus.noShow,
    AppointmentStatus.cancelledByClinic,
    AppointmentStatus.cancelledByPatient,
  ];

  static Color color(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.scheduled:
        return ColorManager.warning;
      case AppointmentStatus.confirmed:
        return ColorManager.success;
      case AppointmentStatus.completed:
        return ColorManager.info;
      case AppointmentStatus.cancelledByClinic:
      case AppointmentStatus.cancelledByPatient:
        return ColorManager.error;
      case AppointmentStatus.noShow:
        return ColorManager.gray400;
    }
  }

  static String label(BuildContext context, AppointmentStatus status) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case AppointmentStatus.scheduled:
        return l10n.scheduled;
      case AppointmentStatus.confirmed:
        return l10n.confirmed;
      case AppointmentStatus.completed:
        return l10n.completed;
      case AppointmentStatus.cancelledByClinic:
        return l10n.cancelledByClinic;
      case AppointmentStatus.cancelledByPatient:
        return l10n.cancelledByPatient;
      case AppointmentStatus.noShow:
        return l10n.noShow;
    }
  }

  static IconData icon(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.scheduled:
        return Icons.schedule_outlined;
      case AppointmentStatus.confirmed:
        return Icons.check_circle_outline_rounded;
      case AppointmentStatus.completed:
        return Icons.task_alt_rounded;
      case AppointmentStatus.cancelledByClinic:
        return Icons.cancel_outlined;
      case AppointmentStatus.cancelledByPatient:
        return Icons.person_off_outlined;
      case AppointmentStatus.noShow:
        return Icons.event_busy_outlined;
    }
  }
}
