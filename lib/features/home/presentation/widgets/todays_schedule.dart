import 'package:dental_clinic_app/core/resources/resources.dart';
import 'package:dental_clinic_app/core/widgets/state_card.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/appointment_list_card.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The first thing on the home screen: what the day actually looks like.
///
/// Rows are [AppointmentListCard], the same card the appointments screen
/// uses, so a row means the same thing in both places. All three list states
/// - skeleton, empty, error - are designed rather than improvised, and the
/// skeleton keeps the final card height so nothing jumps.
class TodaysSchedule extends StatelessWidget {
  const TodaysSchedule({
    super.key,
    required this.appointments,
    this.totalCount,
    this.isLoading = false,
    this.error,
    this.onViewAllTap,
    this.onNewAppointment,
    this.onRetry,
  });

  final List<AppointmentEntity> appointments;

  /// Full count for the day; [appointments] may be truncated for the home
  /// screen, so the header still reports the real number.
  final int? totalCount;
  final bool isLoading;
  final String? error;
  final VoidCallback? onViewAllTap;
  final VoidCallback? onNewAppointment;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    final count = totalCount ?? appointments.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              l10n.todaysSchedule,
              style: TextStyle(
                fontFamily: family,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: c.textPrimary,
              ),
            ),
            if (!isLoading && error == null && count > 0) ...[
              SizedBox(width: 6.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    color: ColorManager.primaryDarker,
                  ),
                ),
              ),
            ],
            const Spacer(),
            if (appointments.isNotEmpty)
              GestureDetector(
                onTap: onViewAllTap,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Text(
                    l10n.viewAll,
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.primaryDarker,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 10.h),
        _buildBody(context, l10n),
      ],
    );
  }

  Widget _buildBody(BuildContext context, AppLocalizations l10n) {
    if (isLoading) {
      return Column(
        children: [
          for (var i = 0; i < 3; i++) ...[
            if (i > 0) SizedBox(height: 8.h),
            const AppointmentCardSkeleton(),
          ],
        ],
      );
    }
    if (error != null) {
      return StateCard(
        icon: Icons.cloud_off_rounded,
        tone: ColorManager.error,
        title: l10n.scheduleLoadFailed,
        message: error,
        detail: l10n.scheduleUnchangedHint,
        actionLabel: l10n.retry,
        onAction: onRetry,
      );
    }
    if (appointments.isEmpty) {
      return StateCard(
        icon: Icons.calendar_today_outlined,
        title: l10n.noAppointmentsToday,
        message: l10n.noAppointmentsTodayHint,
        actionLabel: '+ ${l10n.newAppointment}',
        onAction: onNewAppointment,
      );
    }
    return Column(
      children: [
        for (var i = 0; i < appointments.length; i++) ...[
          if (i > 0) SizedBox(height: 8.h),
          AppointmentListCard(appointment: appointments[i]),
        ],
      ],
    );
  }
}
