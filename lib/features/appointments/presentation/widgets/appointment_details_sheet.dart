import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppointmentDetailsSheet extends StatelessWidget {
  final AppointmentEntity appointment;

  const AppointmentDetailsSheet({super.key, required this.appointment});

  static void show(BuildContext context, AppointmentEntity appointment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AppointmentDetailsSheet(appointment: appointment),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final statusColor = _statusColor(appointment.status);
    final endTime = appointment.dateTime
        .add(Duration(minutes: appointment.durationMinutes));

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: _Handle()),
              SizedBox(height: 16.h),

              _Header(
                appointment: appointment,
                statusColor: statusColor,
                statusLabel: _statusLabel(context, appointment.status),
              ),
              SizedBox(height: 20.h),

              Row(
                children: [
                  Expanded(
                    child: _StatTile(
                      icon: Icons.calendar_today_outlined,
                      label: l10n.date,
                      value: appointment.formattedDate,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _StatTile(
                      icon: Icons.access_time_rounded,
                      label: l10n.time,
                      value:
                          '${appointment.formattedTime} – ${_formatTime(endTime)}',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              _StatTile(
                icon: Icons.timelapse_outlined,
                label: l10n.duration,
                value: _formatDuration(context, appointment.durationMinutes),
                fullWidth: true,
              ),

              SizedBox(height: 20.h),

              if (appointment.treatmentType.isNotEmpty) ...[
                _SectionLabel(l10n.treatment),
                SizedBox(height: 8.h),
                _Pill(
                  icon: Icons.medical_services_outlined,
                  label: appointment.treatmentType,
                ),
                SizedBox(height: 16.h),
              ],

              if (appointment.doctorName.isNotEmpty) ...[
                _SectionLabel(l10n.doctor),
                SizedBox(height: 8.h),
                _DoctorRow(name: appointment.doctorName),
                SizedBox(height: 16.h),
              ],

              if (appointment.notes != null &&
                  appointment.notes!.trim().isNotEmpty) ...[
                _SectionLabel(l10n.notes),
                SizedBox(height: 8.h),
                _NotesCard(notes: appointment.notes!),
                SizedBox(height: 16.h),
              ],

              if (appointment.patientId.isNotEmpty) ...[
                SizedBox(height: 4.h),
                _ViewPatientButton(
                  onTap: () {
                    Navigator.of(context).pop();
                    context.pushNamed(
                      AppRoutesNames.patientDetails,
                      extra: <String, dynamic>{
                        'patientId': appointment.patientId,
                        'patientName': appointment.patientName,
                        'tabIndex': 0,
                      },
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  static Color _statusColor(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.confirmed:
        return ColorManager.success;
      case AppointmentStatus.pending:
        return ColorManager.warning;
      case AppointmentStatus.completed:
        return ColorManager.info;
      case AppointmentStatus.cancelled:
        return ColorManager.error;
      case AppointmentStatus.noShow:
        return ColorManager.gray400;
    }
  }

  static String _statusLabel(BuildContext context, AppointmentStatus status) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case AppointmentStatus.confirmed:
        return l10n.confirmed;
      case AppointmentStatus.pending:
        return l10n.scheduled;
      case AppointmentStatus.completed:
        return l10n.completed;
      case AppointmentStatus.cancelled:
        return l10n.cancelled;
      case AppointmentStatus.noShow:
        return l10n.noShow;
    }
  }

  static String _formatTime(DateTime d) {
    final h = d.hour.toString().padLeft(2, '0');
    final m = d.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  static String _formatDuration(BuildContext context, int minutes) {
    if (minutes < 60) return '$minutes min';
    final hours = minutes ~/ 60;
    final remaining = minutes % 60;
    if (remaining == 0) return '${hours}h';
    return '${hours}h ${remaining}m';
  }
}

class _Handle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: ColorManager.of(context).border,
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final AppointmentEntity appointment;
  final Color statusColor;
  final String statusLabel;

  const _Header({
    required this.appointment,
    required this.statusColor,
    required this.statusLabel,
  });

  @override
  Widget build(BuildContext context) {
    final initials = _initials(appointment.patientName);

    return Row(
      children: [
        Container(
          width: 52.w,
          height: 52.w,
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Center(
            child: Text(
              initials,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appointment.patientName.isNotEmpty
                    ? appointment.patientName
                    : '—',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.of(context).textPrimary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                AppLocalizations.of(context)!.appointmentDetails,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.of(context).textTertiary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            statusLabel,
            style: TextStyle(
              fontSize: 11.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
        ),
      ],
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '?';
    final first = parts.first.characters.first;
    final last = parts.length > 1 ? parts.last.characters.first : '';
    return '$first$last'.toUpperCase();
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool fullWidth;

  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBgSecondary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon,
                  size: 14.w, color: ColorManager.of(context).textTertiary),
              SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.of(context).textTertiary,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w600,
              color: ColorManager.of(context).textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13.sp,
        fontFamily: FontHelper.fontFamily(context),
        fontWeight: FontWeight.w600,
        color: ColorManager.of(context).textSecondary,
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Pill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: ColorManager.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.w, color: ColorManager.primary),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DoctorRow extends StatelessWidget {
  final String name;
  const _DoctorRow({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBgSecondary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: ColorManager.info.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              size: 18.w,
              color: ColorManager.info,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: ColorManager.of(context).textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotesCard extends StatelessWidget {
  final String notes;
  const _NotesCard({required this.notes});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBgSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.of(context).borderLight),
      ),
      child: Text(
        notes,
        style: TextStyle(
          fontSize: 13.sp,
          fontFamily: FontHelper.fontFamily(context),
          color: ColorManager.of(context).textPrimary,
          height: 1.5,
        ),
      ),
    );
  }
}

class _ViewPatientButton extends StatelessWidget {
  final VoidCallback onTap;
  const _ViewPatientButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_outline, size: 18.w, color: ColorManager.white),
            SizedBox(width: 8.w),
            Text(
              AppLocalizations.of(context)!.viewPatientDetails,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w600,
                color: ColorManager.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
