import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/padding_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/presentation/bloc/appointment_bloc.dart';

/// Appointments page with BLoC state management
/// ✅ No setState - all state managed by AppointmentBloc
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
      backgroundColor: ColorManager.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          'Schedule',
          style: TextStyleManager.headlineMedium.copyWith(
            color: ColorManager.textPrimary,
          ),
        ),
        backgroundColor: ColorManager.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              // ✅ BLoC event instead of setState
              final now = DateTime.now();
              final today = DateTime(now.year, now.month, now.day);
              context.read<AppointmentBloc>().add(
                    AppointmentEvent.selectDate(today),
                  );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(AppRoutesNames.newAppointment),
        backgroundColor: ColorManager.primary,
        child: const Icon(Icons.add, color: ColorManager.white),
      ),
      body: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Text(
                state.error!,
                style: TextStyleManager.bodyMedium.copyWith(
                  color: ColorManager.error,
                ),
              ),
            );
          }

          return Column(
            children: [
              // View Toggle & Date
              Container(
                color: ColorManager.white,
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    // View Toggle
                    _buildViewToggle(context, state),
                    SizedBox(height: 16.h),
                    // Date selector
                    _buildDateSelector(context, state),
                  ],
                ),
              ),

              // Appointments List
              Expanded(
                child: state.filteredAppointments.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: PaddingManager.all16,
                        itemCount: state.filteredAppointments.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: _buildAppointmentCard(
                              state.filteredAppointments[index],
                            ),
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

  /// View toggle widget - ✅ Uses BLoC event instead of setState
  Widget _buildViewToggle(BuildContext context, AppointmentState state) {
    final views = [
      (AppointmentViewMode.day, 'Day'),
      (AppointmentViewMode.week, 'Week'),
    ];

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ColorManager.gray100,
        borderRadius: BorderRadiusManager.lg,
      ),
      child: Row(
        children: views.map((viewData) {
          final mode = viewData.$1;
          final label = viewData.$2;
          final isSelected = state.viewMode == mode;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<AppointmentBloc>().add(
                      AppointmentEvent.changeViewMode(mode),
                    );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorManager.white
                      : ColorManager.transparent,
                  borderRadius: BorderRadiusManager.md,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: ColorManager.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    label,
                    style: TextStyleManager.labelLarge.copyWith(
                      color: isSelected
                          ? ColorManager.primary
                          : ColorManager.textSecondary,
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

  Widget _buildDateSelector(BuildContext context, AppointmentState state) {
    final now = DateTime.now();
    final days = List.generate(7, (index) {
      return now.add(Duration(days: index - 2));
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days.map((date) {
        final isSelected = date.day == state.selectedDate.day &&
            date.month == state.selectedDate.month &&
            date.year == state.selectedDate.year;
        final isToday = date.day == now.day &&
            date.month == now.month &&
            date.year == now.year;

        return GestureDetector(
          onTap: () {
            context.read<AppointmentBloc>().add(
                  AppointmentEvent.selectDate(date),
                );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? ColorManager.primary
                  : isToday
                      ? ColorManager.primary10
                      : ColorManager.transparent,
              borderRadius: BorderRadiusManager.lg,
            ),
            child: Column(
              children: [
                Text(
                  _getDayName(date.weekday),
                  style: TextStyleManager.labelSmall.copyWith(
                    color: isSelected
                        ? ColorManager.white.withValues(alpha: 0.9)
                        : ColorManager.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  date.day.toString(),
                  style: TextStyleManager.titleMedium.copyWith(
                    color: isSelected
                        ? ColorManager.white
                        : ColorManager.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 64.w,
            color: ColorManager.textTertiary,
          ),
          SizedBox(height: 16.h),
          Text(
            'No appointments scheduled',
            style: TextStyleManager.titleMedium.copyWith(
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(AppointmentEntity appointment) {
    return CustomCard(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appointment.formattedTime,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: FontFamily.geist,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.primary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '${appointment.durationMinutes} min',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontFamily.geist,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          // Divider
          Container(
            width: 3.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: _getStatusColor(appointment.status),
              borderRadius: BorderRadiusManager.full,
            ),
          ),
          SizedBox(width: 16.w),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        appointment.patientName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: FontFamily.geist,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  appointment.treatmentType,
                  style: TextStyle(
                    color: ColorManager.textSecondary,
                    fontSize: 14.sp,
                    fontFamily: FontFamily.geist,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  String _getStatusLabel(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.confirmed:
        return 'Confirmed';
      case AppointmentStatus.pending:
        return 'Pending';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
      case AppointmentStatus.noShow:
        return 'No Show';
    }
  }

  StatusType _getStatusType(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.confirmed:
        return StatusType.success;
      case AppointmentStatus.pending:
        return StatusType.pending;
      case AppointmentStatus.completed:
        return StatusType.completed;
      case AppointmentStatus.cancelled:
        return StatusType.error;
      case AppointmentStatus.noShow:
        return StatusType.pending;
    }
  }
}
