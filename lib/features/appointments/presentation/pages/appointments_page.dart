import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/presentation/bloc/appointment_bloc.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentBloc()
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
      backgroundColor: Colors.white,
      body: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Text(
                state.error!,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontFamily.geist,
                  color: ColorManager.error,
                ),
              ),
            );
          }

          return Column(
            children: [
              // — Header (matches patients list style)
              _buildHeader(context, state),
              Divider(height: 1, color: Colors.grey.shade200),

              // — Date selector
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 10.h),
                child: _buildDateSelector(context, state),
              ),

              // — View toggle
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: _buildViewToggle(context, state),
              ),
              SizedBox(height: 12.h),

              // — Appointments list
              Expanded(
                child: state.filteredAppointments.isEmpty
                    ? _buildEmptyState(context)
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        itemCount: state.filteredAppointments.length,
                        separatorBuilder: (_, __) =>
                            Divider(height: 1, color: Colors.grey.shade100),
                        itemBuilder: (context, index) {
                          return _buildAppointmentRow(
                            state.filteredAppointments[index],
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
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
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${state.filteredAppointments.length} ${AppLocalizations.of(context)!.total}',
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 13.sp,
                      color: Colors.black38,
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
                context
                    .read<AppointmentBloc>()
                    .add(AppointmentEvent.selectDate(today));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
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
              onTap: () => context.pushNamed(AppRoutesNames.newAppointment),
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days.map((date) {
        final isSelected = date.day == state.selectedDate.day &&
            date.month == state.selectedDate.month &&
            date.year == state.selectedDate.year;
        final isToday =
            date.day == now.day && date.month == now.month && date.year == now.year;

        return GestureDetector(
          onTap: () => context
              .read<AppointmentBloc>()
              .add(AppointmentEvent.selectDate(date)),
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
                  _getDayName(date.weekday),
                  style: TextStyle(
                    fontFamily: FontFamily.geist,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white70 : Colors.black38,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  date.day.toString(),
                  style: TextStyle(
                    fontFamily: FontFamily.geist,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ─── View toggle ────────────────────────────────────────────────────────

  Widget _buildViewToggle(BuildContext context, AppointmentState state) {
    final views = [
      (AppointmentViewMode.day, 'Day'),
      (AppointmentViewMode.week, 'Week'),
    ];

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: views.map((v) {
          final isSelected = state.viewMode == v.$1;
          return Expanded(
            child: GestureDetector(
              onTap: () => context
                  .read<AppointmentBloc>()
                  .add(AppointmentEvent.changeViewMode(v.$1)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    v.$2,
                    style: TextStyle(
                      fontFamily: FontFamily.geist,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? ColorManager.primary : Colors.black38,
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

  Widget _buildAppointmentRow(AppointmentEntity appointment) {
    return Padding(
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
                    fontFamily: FontFamily.geist,
                    fontWeight: FontWeight.w500,
                    color: Colors.black45,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${appointment.durationMinutes}m',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: FontFamily.geist,
                    color: Colors.black26,
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
                    fontFamily: FontFamily.geist,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  appointment.treatmentType,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontFamily.geist,
                    color: Colors.black38,
                  ),
                ),
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
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 12.h),
          Text(
            AppLocalizations.of(context)!.noAppointments,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 14.sp,
              color: Colors.black38,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Helpers ────────────────────────────────────────────────────────────

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  Color _getStatusColor(AppointmentStatus status) {
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
}