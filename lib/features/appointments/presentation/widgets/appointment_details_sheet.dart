import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/added_by_label.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/presentation/manager/appointment_bloc.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/appointment_status_styles.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppointmentDetailsSheet extends StatelessWidget {
  final AppointmentEntity appointment;

  const AppointmentDetailsSheet({super.key, required this.appointment});

  static void show(BuildContext context, AppointmentEntity appointment) {
    // Some entry points (home today's schedule) don't provide
    // AppointmentBloc — in that case we show details read-only and the
    // status pill becomes non-interactive.
    final AppointmentBloc? bloc = _tryReadBloc(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        final sheet = AppointmentDetailsSheet(appointment: appointment);
        if (bloc == null) return sheet;
        return BlocProvider.value(value: bloc, child: sheet);
      },
    );
  }

  static AppointmentBloc? _tryReadBloc(BuildContext context) {
    try {
      return context.read<AppointmentBloc>();
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final statusColor = AppointmentStatusStyles.color(appointment.status);
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
      child: Padding(
        padding: EdgeInsets.only(
          bottom: systemBottomInset(context),
        ),
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
                statusLabel:
                    AppointmentStatusStyles.label(context, appointment.status),
                onStatusTap: () => _openStatusPicker(context, appointment),
              ),
              SizedBox(height: 10.h),
              AddedByLabel(
                audits: appointment.audits,
                createdAt: appointment.createdAt,
              ),
              SizedBox(height: 16.h),

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

  void _openStatusPicker(
    BuildContext context,
    AppointmentEntity appointment,
  ) {
    final bloc = _tryReadBloc(context);
    if (bloc == null) return; // entry point doesn't support editing

    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) => _StatusPickerSheet(
        current: appointment.status,
        onSelected: (status) {
          if (status == appointment.status) {
            Navigator.pop(sheetContext);
            return;
          }
          bloc.add(
            AppointmentEvent.updateAppointmentStatus(appointment.id, status),
          );
          // Close the picker first, then the details sheet so the user lands
          // back on the list and sees the updated row when it reloads.
          Navigator.pop(sheetContext);
          Navigator.of(context).pop();
        },
      ),
    );
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
  final VoidCallback onStatusTap;

  const _Header({
    required this.appointment,
    required this.statusColor,
    required this.statusLabel,
    required this.onStatusTap,
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
        InkWell(
          onTap: onStatusTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.edit_outlined,
                  size: 12.w,
                  color: statusColor,
                ),
              ],
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

class _StatusPickerSheet extends StatelessWidget {
  final AppointmentStatus current;
  final ValueChanged<AppointmentStatus> onSelected;

  const _StatusPickerSheet({
    required this.current,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(
        bottom: systemBottomInset(context),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 12.h, 0, 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorManager.of(context).border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  l10n.changeStatus,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF111111),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Divider(height: 1, color: ColorManager.of(context).borderLight),
            for (var i = 0; i < AppointmentStatusStyles.all.length; i++) ...[
              _StatusRow(
                status: AppointmentStatusStyles.all[i],
                selected: AppointmentStatusStyles.all[i] == current,
                onTap: () => onSelected(AppointmentStatusStyles.all[i]),
              ),
              if (i < AppointmentStatusStyles.all.length - 1)
                Divider(
                  height: 1,
                  indent: 16.w,
                  color: ColorManager.of(context).borderLight,
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  final AppointmentStatus status;
  final bool selected;
  final VoidCallback onTap;

  const _StatusRow({
    required this.status,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppointmentStatusStyles.color(status);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: Row(
          children: [
            Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                AppointmentStatusStyles.icon(status),
                size: 16.w,
                color: color,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                AppointmentStatusStyles.label(context, status),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  color: const Color(0xFF111111),
                ),
              ),
            ),
            if (selected)
              Icon(
                Icons.check_rounded,
                size: 18.w,
                color: ColorManager.primary,
              ),
          ],
        ),
      ),
    );
  }
}
