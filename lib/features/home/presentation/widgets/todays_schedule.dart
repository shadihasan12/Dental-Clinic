import 'package:dental_clinic_app/core/resources/resources.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/appointment_status_styles.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodaysSchedule extends StatelessWidget {
  const TodaysSchedule({
    super.key,
    required this.appointments,
    this.isLoading = false,
    this.error,
    this.onViewAllTap,
  });

  final List<AppointmentEntity> appointments;
  final bool isLoading;
  final String? error;
  final VoidCallback? onViewAllTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.todaysSchedule,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: ColorManager.of(context).textTertiary,
              ),
            ),
            GestureDetector(
              onTap: onViewAllTap,
              child: Text(
                l10n.viewAll,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        _buildBody(context, l10n),
      ],
    );
  }

  Widget _buildBody(BuildContext context, AppLocalizations l10n) {
    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    if (error != null) {
      return _Hint(
        icon: Icons.error_outline,
        message: error!,
      );
    }
    if (appointments.isEmpty) {
      return _Hint(
        icon: Icons.event_available_outlined,
        message: l10n.noAppointments,
      );
    }
    return Column(
      children: [
        for (var i = 0; i < appointments.length; i++) ...[
          _AppointmentRow(appointment: appointments[i]),
          if (i < appointments.length - 1)
            Divider(
              height: 1,
              color: ColorManager.of(context).borderLight,
            ),
        ],
      ],
    );
  }
}

class _AppointmentRow extends StatelessWidget {
  const _AppointmentRow({required this.appointment});

  final AppointmentEntity appointment;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          SizedBox(
            width: 65.w,
            child: Text(
              appointment.formattedTime,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: c.textTertiary,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment.patientName.isNotEmpty
                      ? appointment.patientName
                      : '—',
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: c.textPrimary,
                  ),
                ),
                if (appointment.treatmentType.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    appointment.treatmentType,
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 12.sp,
                      color: c.textTertiary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          _StatusBadge(status: appointment.status),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    final color = AppointmentStatusStyles.color(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        AppointmentStatusStyles.label(context, status),
        style: TextStyle(
          fontFamily: FontHelper.fontFamily(context),
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _Hint extends StatelessWidget {
  const _Hint({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 32.w,
              color: ColorManager.of(context).textTertiary,
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 13.sp,
                color: ColorManager.of(context).textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
