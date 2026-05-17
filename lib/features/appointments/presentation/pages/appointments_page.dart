import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/presentation/manager/appointment_bloc.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/appointment_details_sheet.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/appointment_status_styles.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard_helper.dart';
import 'package:intl/intl.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<AppointmentBloc>()
            ..add(const AppointmentEvent.loadAppointments()),
      child: const _AppointmentsContent(),
    );
  }
}

class _AppointmentsContent extends StatelessWidget {
  const _AppointmentsContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          return Column(
            children: [
              _buildHeader(context, state),
              Divider(height: 1, color: ColorManager.of(context).divider),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 10.h),
                child: _buildDateSelector(context, state),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: _buildViewToggle(context, state),
              ),
              SizedBox(height: 12.h),
              Expanded(child: _buildBody(context, state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, AppointmentState state) {
    if (state.isLoading) {
      return _buildLoadingSkeleton(context);
    }
    if (state.error != null) {
      return Center(
        child: Text(
          state.error!,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: FontHelper.fontFamily(context),
            color: ColorManager.error,
          ),
        ),
      );
    }
    if (state.filteredAppointments.isEmpty) {
      return _buildEmptyState(context);
    }
    if (state.viewMode == AppointmentViewMode.week) {
      return _buildWeekList(context, state.filteredAppointments);
    }
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
      itemCount: state.filteredAppointments.length,
      separatorBuilder: (_, _) =>
          Divider(height: 1, color: ColorManager.of(context).divider),
      itemBuilder: (context, index) {
        return _buildAppointmentRow(
          context,
          state.filteredAppointments[index],
        );
      },
    );
  }

  Widget _buildWeekList(
    BuildContext context,
    List<AppointmentEntity> appointments,
  ) {
    final groups = _groupByDay(appointments);
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final entry = groups[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDayHeader(context, entry.key),
            for (var i = 0; i < entry.value.length; i++) ...[
              _buildAppointmentRow(context, entry.value[i]),
              if (i < entry.value.length - 1)
                Divider(height: 1, color: ColorManager.of(context).divider),
            ],
            SizedBox(height: 8.h),
          ],
        );
      },
    );
  }

  Widget _buildDayHeader(BuildContext context, DateTime day) {
    final today = DateTime.now();
    final isToday = day.year == today.year &&
        day.month == today.month &&
        day.day == today.day;
    final label =
        '${_getDayName(context, day)}, ${_getMonthName(context, day)} ${day.day}';

    return Padding(
      padding: EdgeInsets.only(top: 12.h, bottom: 6.h),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w600,
              color: isToday
                  ? ColorManager.primary
                  : ColorManager.of(context).textSecondary,
            ),
          ),
          if (isToday) ...[
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                AppLocalizations.of(context)!.today,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<MapEntry<DateTime, List<AppointmentEntity>>> _groupByDay(
    List<AppointmentEntity> items,
  ) {
    final map = <DateTime, List<AppointmentEntity>>{};
    for (final a in items) {
      final day = DateTime(a.dateTime.year, a.dateTime.month, a.dateTime.day);
      (map[day] ??= []).add(a);
    }
    final sorted = map.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    for (final entry in sorted) {
      entry.value.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    }
    return sorted;
  }

  String _getMonthName(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context).toString();
    return DateFormat('MMM', locale).format(date);
  }

  // ─── Header ─────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context, AppointmentState state) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.appointments,
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.of(context).textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${state.filteredAppointments.length} ${AppLocalizations.of(context)!.total}',
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 13.sp,
                      color: ColorManager.of(context).textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            // Today button
            GestureDetector(
              onTap: () {
                final now = DateTime.now();
                final today = DateTime(now.year, now.month, now.day);
                context.read<AppointmentBloc>().add(
                  AppointmentEvent.selectDate(today),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: ColorManager.of(context).cardBgSecondary,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  AppLocalizations.of(context)!.today,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            // Add button
            GestureDetector(
              onTap: () async {
                if (!await SubscriptionGuardHelper.requireActive(context)) {
                  return;
                }
                if (!context.mounted) return;
                await context.pushNamed(AppRoutesNames.newAppointment);
                if (context.mounted) {
                  context.read<AppointmentBloc>().add(
                        const AppointmentEvent.loadAppointments(),
                      );
                }
              },
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: Colors.white, size: 20.w),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Date selector ──────────────────────────────────────────────────────

  Widget _buildDateSelector(BuildContext context, AppointmentState state) {
    final now = DateTime.now();
    final days = List.generate(7, (i) => now.add(Duration(days: i - 2)));

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: constraints.maxWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: days.map((date) {
        final isSelected =
            date.day == state.selectedDate.day &&
            date.month == state.selectedDate.month &&
            date.year == state.selectedDate.year;
        final isToday =
            date.day == now.day &&
            date.month == now.month &&
            date.year == now.year;

        return GestureDetector(
          onTap: () => context.read<AppointmentBloc>().add(
            AppointmentEvent.selectDate(date),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? ColorManager.primary
                  : isToday
                  ? ColorManager.primary.withValues(alpha: 0.08)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: [
                Text(
                  _getDayName(context, date),
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white70 : ColorManager.of(context).textTertiary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  date.day.toString(),
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : ColorManager.of(context).textPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // ─── View toggle ────────────────────────────────────────────────────────

  Widget _buildViewToggle(BuildContext context, AppointmentState state) {
    final views = [
      (AppointmentViewMode.day, AppLocalizations.of(context)!.day),
      (AppointmentViewMode.week, AppLocalizations.of(context)!.week),
    ];

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBgSecondary,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: views.map((v) {
          final isSelected = state.viewMode == v.$1;
          return Expanded(
            child: GestureDetector(
              onTap: () => context.read<AppointmentBloc>().add(
                AppointmentEvent.changeViewMode(v.$1),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? ColorManager.of(context).cardBg : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    v.$2,
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? ColorManager.primary : ColorManager.of(context).textTertiary,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ─── Appointment row ────────────────────────────────────────────────────

  Widget _buildAppointmentRow(
    BuildContext context,
    AppointmentEntity appointment,
  ) {
    return InkWell(
      onTap: () => AppointmentDetailsSheet.show(context, appointment),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
        children: [
          // Time
          SizedBox(
            width: 60.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment.formattedTime,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w500,
                    color: ColorManager.of(context).textTertiary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${appointment.durationMinutes}m',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: ColorManager.of(context).textSubtle,
                  ),
                ),
              ],
            ),
          ),

          // Status bar
          Container(
            width: 3.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: _getStatusColor(appointment.status),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(width: 12.w),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment.patientName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w500,
                    color: ColorManager.of(context).textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  appointment.treatmentType,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    color: ColorManager.of(context).textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }

  // ─── Loading skeleton ───────────────────────────────────────────────────

  Widget _buildLoadingSkeleton(BuildContext context) {
    return AppShimmer(
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
        itemCount: 6,
        separatorBuilder: (_, _) =>
            Divider(height: 1, color: ColorManager.of(context).divider),
        itemBuilder: (context, index) => _buildAppointmentRowSkeleton(context),
      ),
    );
  }

  Widget _buildAppointmentRowSkeleton(BuildContext context) {
    final fill = ColorManager.of(context).shimmerBase;
    Widget bar({required double width, required double height, double r = 4}) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(r),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          // Time column placeholder (time + duration)
          SizedBox(
            width: 60.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bar(width: 44.w, height: 12.h),
                SizedBox(height: 6.h),
                bar(width: 28.w, height: 10.h),
              ],
            ),
          ),
          // Status bar placeholder
          bar(width: 3.w, height: 40.h, r: 2),
          SizedBox(width: 12.w),
          // Patient name + treatment placeholders
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bar(width: 140.w, height: 14.h),
                SizedBox(height: 6.h),
                bar(width: 90.w, height: 12.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Empty state ────────────────────────────────────────────────────────

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 48.w,
            color: ColorManager.of(context).border,
          ),
          SizedBox(height: 12.h),
          Text(
            AppLocalizations.of(context)!.noAppointments,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 14.sp,
              color: ColorManager.of(context).textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Helpers ────────────────────────────────────────────────────────────

  String _getDayName(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context).toString();
    return DateFormat('EEE', locale).format(date);
  }

  Color _getStatusColor(AppointmentStatus status) {
    return AppointmentStatusStyles.color(status);
  }
}
