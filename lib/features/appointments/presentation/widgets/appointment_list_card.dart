import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/appointment_details_sheet.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/appointment_status_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// One appointment, drawn the same way on the home screen and on the
/// appointments screen - the row a dentist learns to read once.
///
/// The status hue runs down the leading edge as a 3px border and repeats in
/// the time tile, so the state is readable without parsing the pill. In RTL
/// the accent moves to the trailing edge with the rest of the mirror.
class AppointmentListCard extends StatelessWidget {
  const AppointmentListCard({super.key, required this.appointment, this.onTap});

  final AppointmentEntity appointment;

  /// Defaults to opening the details sheet.
  final VoidCallback? onTap;

  bool get _isCancelled =>
      appointment.status == AppointmentStatus.cancelledByClinic ||
      appointment.status == AppointmentStatus.cancelledByPatient ||
      appointment.status == AppointmentStatus.noShow;

  static String formatDuration(int minutes) {
    if (minutes < 60) return '${minutes}m';
    final hours = minutes ~/ 60;
    final rest = minutes % 60;
    return rest == 0 ? '${hours}h' : '${hours}h ${rest}m';
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final tone = AppointmentStatusStyles.color(appointment.status);
    final radius = BorderRadius.circular(14.r);

    return Material(
      color: c.cardBg,
      borderRadius: radius,
      child: InkWell(
        onTap:
            onTap ?? () => AppointmentDetailsSheet.show(context, appointment),
        borderRadius: radius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            // Uniform border only: a BoxDecoration with differing sides and
            // a borderRadius throws while painting, which leaves the card
            // blank but still tappable. The status accent is drawn as a
            // positioned stripe instead.
            border: Border.all(color: c.borderLight),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Full-height status stripe on the leading edge; RTL moves it
              // to the trailing edge with the rest of the mirror.
              PositionedDirectional(
                start: 0,
                top: 0,
                bottom: 0,
                width: 3.w,
                child: ColoredBox(color: tone),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(14.w, 10.h, 11.w, 10.h),
                child: Row(
                  children: [
                    Container(
                      width: 52.w,
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      decoration: BoxDecoration(
                        color: tone.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            appointment.formattedTime,
                            style: TextStyle(
                              fontFamily: family,
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                              color: tone,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            formatDuration(appointment.durationMinutes),
                            style: TextStyle(
                              fontFamily: family,
                              fontSize: 9.5.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.2,
                              color: tone.withValues(alpha: 0.75),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 11.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appointment.patientName.isNotEmpty
                                ? appointment.patientName
                                : '-',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: family,
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w600,
                              color: _isCancelled
                                  ? ColorManager.gray400
                                  : c.textPrimary,
                              decoration: _isCancelled
                                  ? TextDecoration.lineThrough
                                  : null,
                              decorationColor: ColorManager.gray400,
                            ),
                          ),
                          if (appointment.treatmentType.isNotEmpty) ...[
                            SizedBox(height: 2.h),
                            Text(
                              appointment.treatmentType,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: family,
                                fontSize: 11.sp,
                                color: c.textTertiary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    AppointmentStatusPill(status: appointment.status),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentStatusPill extends StatelessWidget {
  const AppointmentStatusPill({super.key, required this.status});

  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    final tone = AppointmentStatusStyles.color(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        AppointmentStatusStyles.label(context, status),
        style: TextStyle(
          fontFamily: FontHelper.fontFamily(context),
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          height: 1.3,
          color: tone,
        ),
      ),
    );
  }
}

/// Keeps every slot of the real card at full size - time tile, two text
/// lines, status pill - so the list does not reflow when the request lands.
class AppointmentCardSkeleton extends StatelessWidget {
  const AppointmentCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: c.borderLight),
      ),
      padding: EdgeInsets.fromLTRB(11.w, 10.h, 11.w, 10.h),
      child: Row(
        children: [
          ShimmerBox(
            width: 52.w,
            height: 38.h,
            radius: BorderRadius.circular(10.r),
          ),
          SizedBox(width: 11.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(width: 130.w, height: 12.h),
                SizedBox(height: 6.h),
                ShimmerBox(width: 80.w, height: 10.h),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          ShimmerBox(
            width: 58.w,
            height: 18.h,
            radius: BorderRadius.circular(6.r),
          ),
        ],
      ),
    );
  }
}
