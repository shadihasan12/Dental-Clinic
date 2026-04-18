import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
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
    if (Responsive.isDesktop(context)) {
      return const _DesktopAppointments();
    }
    return const _MobileAppointments();
  }
}

// ═══════════════════════════════════════════════════════════════════════
// MOBILE LAYOUT (unchanged)
// ═══════════════════════════════════════════════════════════════════════

class _MobileAppointments extends StatelessWidget {
  const _MobileAppointments();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
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
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.error,
                ),
              ),
            );
          }

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

              Expanded(
                child: state.filteredAppointments.isEmpty
                    ? _buildEmptyState(context)
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        itemCount: state.filteredAppointments.length,
                        separatorBuilder: (_, _) =>
                            Divider(height: 1, color: ColorManager.of(context).divider),
                        itemBuilder: (context, index) {
                          return _buildAppointmentRow(
                            context,
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

  Widget _buildDateSelector(BuildContext context, AppointmentState state) {
    final now = DateTime.now();
    final days = List.generate(7, (i) => now.add(Duration(days: i - 2)));

    return Row(
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
                  _getDayName(date.weekday),
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
    );
  }

  Widget _buildViewToggle(BuildContext context, AppointmentState state) {
    final views = [
      (AppointmentViewMode.day, 'Day'),
      (AppointmentViewMode.week, 'Week'),
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

  Widget _buildAppointmentRow(
    BuildContext context,
    AppointmentEntity appointment,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
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

          Container(
            width: 3.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: _statusColor(appointment.status),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(width: 12.w),

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
    );
  }

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

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP LAYOUT
// ═══════════════════════════════════════════════════════════════════════

class _DesktopAppointments extends StatelessWidget {
  const _DesktopAppointments();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      body: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: c.textTertiary),
                    const SizedBox(height: 12),
                    Text(
                      state.error!,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: fontFamily,
                        color: ColorManager.error,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 1180;
              final horizontalPadding = constraints.maxWidth >= 1400 ? 32.0 : 24.0;

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  24,
                  horizontalPadding,
                  28,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1440),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _DesktopPageHeader(state: state, fontFamily: fontFamily),
                        const SizedBox(height: 22),
                        _DesktopStatsRow(state: state, fontFamily: fontFamily),
                        const SizedBox(height: 22),
                        isWide
                            ? _DesktopTwoColumnBody(
                                state: state,
                                fontFamily: fontFamily,
                              )
                            : _DesktopStackedBody(
                                state: state,
                                fontFamily: fontFamily,
                              ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ─── Page header ──────────────────────────────────────────────────────

class _DesktopPageHeader extends StatelessWidget {
  const _DesktopPageHeader({required this.state, required this.fontFamily});

  final AppointmentState state;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.appointments,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: c.textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _headerSubtitle(state, l10n),
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13.5,
                  color: c.textTertiary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        _TodayChip(fontFamily: fontFamily),
        const SizedBox(width: 10),
        _PrimaryNewAppointmentButton(fontFamily: fontFamily),
      ],
    );
  }

  String _headerSubtitle(AppointmentState state, AppLocalizations l10n) {
    final date = state.selectedDate;
    final formatted = _longDate(date);
    return '$formatted  ·  ${state.filteredAppointments.length} ${l10n.appointments.toLowerCase()}';
  }

  String _longDate(DateTime d) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    const weekdays = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      'Friday', 'Saturday', 'Sunday',
    ];
    return '${weekdays[d.weekday - 1]}, ${months[d.month - 1]} ${d.day}, ${d.year}';
  }
}

class _TodayChip extends StatelessWidget {
  const _TodayChip({required this.fontFamily});

  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Material(
      color: c.cardBg,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          context.read<AppointmentBloc>().add(
                AppointmentEvent.selectDate(today),
              );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          decoration: BoxDecoration(
            border: Border.all(color: c.borderLight),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.today_outlined, size: 16, color: ColorManager.primary),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.today,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: c.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrimaryNewAppointmentButton extends StatelessWidget {
  const _PrimaryNewAppointmentButton({required this.fontFamily});

  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorManager.primary,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => context.pushNamed(AppRoutesNames.newAppointment),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: ColorManager.primary.withValues(alpha: 0.25),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.add_rounded, size: 18, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.newAppointment,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Stats row ────────────────────────────────────────────────────────

class _DesktopStatsRow extends StatelessWidget {
  const _DesktopStatsRow({required this.state, required this.fontFamily});

  final AppointmentState state;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final todayCount = state.appointments.where((a) {
      return a.dateTime.year == now.year &&
          a.dateTime.month == now.month &&
          a.dateTime.day == now.day;
    }).length;
    final pending =
        state.getAppointmentCountByStatus(AppointmentStatus.pending);
    final confirmed =
        state.getAppointmentCountByStatus(AppointmentStatus.confirmed);
    final completed =
        state.getAppointmentCountByStatus(AppointmentStatus.completed);

    final cards = [
      _StatCardData(
        icon: Icons.calendar_today_outlined,
        color: const Color(0xFF3B82F6),
        value: todayCount.toString(),
        label: l10n.todaysAppointments,
      ),
      _StatCardData(
        icon: Icons.schedule_rounded,
        color: ColorManager.warningLight,
        value: pending.toString(),
        label: l10n.pending,
      ),
      _StatCardData(
        icon: Icons.check_circle_outline_rounded,
        color: ColorManager.primary,
        value: confirmed.toString(),
        label: 'Confirmed',
      ),
      _StatCardData(
        icon: Icons.task_alt_rounded,
        color: ColorManager.success,
        value: completed.toString(),
        label: l10n.completed,
      ),
    ];

    return Row(
      children: [
        for (int i = 0; i < cards.length; i++) ...[
          Expanded(
            child: _StatCard(data: cards[i], fontFamily: fontFamily),
          ),
          if (i != cards.length - 1) const SizedBox(width: 14),
        ],
      ],
    );
  }
}

class _StatCardData {
  final IconData icon;
  final Color color;
  final String value;
  final String label;
  const _StatCardData({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.data, required this.fontFamily});

  final _StatCardData data;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.borderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(data.icon, color: data.color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.value,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: c.textPrimary,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  data.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 12.5,
                    color: c.textTertiary,
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
}

// ─── Two-column body ──────────────────────────────────────────────────

class _DesktopTwoColumnBody extends StatelessWidget {
  const _DesktopTwoColumnBody({
    required this.state,
    required this.fontFamily,
  });

  final AppointmentState state;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: _ScheduleCard(state: state, fontFamily: fontFamily),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 320,
          child: Column(
            children: [
              _MiniCalendarCard(state: state, fontFamily: fontFamily),
              const SizedBox(height: 16),
              _UpcomingCard(state: state, fontFamily: fontFamily),
              const SizedBox(height: 16),
              _StatusBreakdownCard(state: state, fontFamily: fontFamily),
            ],
          ),
        ),
      ],
    );
  }
}

class _DesktopStackedBody extends StatelessWidget {
  const _DesktopStackedBody({
    required this.state,
    required this.fontFamily,
  });

  final AppointmentState state;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ScheduleCard(state: state, fontFamily: fontFamily),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _MiniCalendarCard(state: state, fontFamily: fontFamily),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _UpcomingCard(state: state, fontFamily: fontFamily),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Schedule card ────────────────────────────────────────────────────

class _ScheduleCard extends StatefulWidget {
  const _ScheduleCard({required this.state, required this.fontFamily});

  final AppointmentState state;
  final String fontFamily;

  @override
  State<_ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<_ScheduleCard> {
  final _searchController = TextEditingController();
  String _query = '';
  AppointmentStatus? _statusFilter;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AppointmentEntity> get _visible {
    final q = _query.trim().toLowerCase();
    return widget.state.filteredAppointments.where((a) {
      if (_statusFilter != null && a.status != _statusFilter) return false;
      if (q.isEmpty) return true;
      return a.patientName.toLowerCase().contains(q) ||
          a.treatmentType.toLowerCase().contains(q) ||
          a.doctorName.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final visible = _visible;
    final hasActiveFilters = _query.isNotEmpty || _statusFilter != null;

    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.borderLight),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 14),
            child: _ScheduleHeader(
              state: widget.state,
              fontFamily: widget.fontFamily,
              visibleCount: visible.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 14),
            child: _ScheduleToolbar(
              searchController: _searchController,
              onQueryChanged: (v) => setState(() => _query = v),
              statusFilter: _statusFilter,
              onStatusChanged: (s) => setState(() => _statusFilter = s),
              fontFamily: widget.fontFamily,
            ),
          ),
          Divider(height: 1, color: c.borderLight),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 14, 22, 10),
            child: _DesktopDateStrip(
              state: widget.state,
              fontFamily: widget.fontFamily,
            ),
          ),
          Divider(height: 1, color: c.borderLight),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 14),
            child: _ScheduleList(
              appointments: visible,
              fontFamily: widget.fontFamily,
              hasActiveFilters: hasActiveFilters,
              onClearFilters: () {
                setState(() {
                  _query = '';
                  _statusFilter = null;
                });
                _searchController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleToolbar extends StatelessWidget {
  const _ScheduleToolbar({
    required this.searchController,
    required this.onQueryChanged,
    required this.statusFilter,
    required this.onStatusChanged,
    required this.fontFamily,
  });

  final TextEditingController searchController;
  final ValueChanged<String> onQueryChanged;
  final AppointmentStatus? statusFilter;
  final ValueChanged<AppointmentStatus?> onStatusChanged;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;

    final statusOptions = <_StatusOption>[
      _StatusOption(null, l10n.filter == 'Filter' ? 'All' : l10n.filter),
      _StatusOption(AppointmentStatus.confirmed, 'Confirmed'),
      _StatusOption(AppointmentStatus.pending, l10n.pending),
      _StatusOption(AppointmentStatus.completed, l10n.completed),
      _StatusOption(AppointmentStatus.cancelled, l10n.cancelled),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 620;
        final search = Container(
          height: 40,
          decoration: BoxDecoration(
            color: c.cardBgSecondary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: c.borderLight),
          ),
          child: TextField(
            controller: searchController,
            onChanged: onQueryChanged,
            style: TextStyle(
              fontSize: 13,
              fontFamily: fontFamily,
              color: c.textPrimary,
            ),
            decoration: InputDecoration(
              isDense: true,
              hintText: '${l10n.search}...',
              hintStyle: TextStyle(
                fontSize: 13,
                fontFamily: fontFamily,
                color: c.textSubtle,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                size: 18,
                color: c.textSubtle,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        );

        final filters = SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < statusOptions.length; i++) ...[
                _StatusFilterChip(
                  label: statusOptions[i].label,
                  color: statusOptions[i].status == null
                      ? null
                      : _statusColor(statusOptions[i].status!),
                  selected: statusFilter == statusOptions[i].status,
                  onTap: () => onStatusChanged(statusOptions[i].status),
                  fontFamily: fontFamily,
                ),
                if (i != statusOptions.length - 1) const SizedBox(width: 6),
              ],
            ],
          ),
        );

        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              search,
              const SizedBox(height: 10),
              filters,
            ],
          );
        }

        return Row(
          children: [
            SizedBox(width: 260, child: search),
            const SizedBox(width: 14),
            Expanded(child: filters),
          ],
        );
      },
    );
  }
}

class _StatusOption {
  final AppointmentStatus? status;
  final String label;
  const _StatusOption(this.status, this.label);
}

class _StatusFilterChip extends StatefulWidget {
  const _StatusFilterChip({
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
    required this.fontFamily,
  });

  final String label;
  final Color? color;
  final bool selected;
  final VoidCallback onTap;
  final String fontFamily;

  @override
  State<_StatusFilterChip> createState() => _StatusFilterChipState();
}

class _StatusFilterChipState extends State<_StatusFilterChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final accent = widget.color ?? ColorManager.primary;

    final Color bg;
    if (widget.selected) {
      bg = accent.withValues(alpha: 0.14);
    } else if (_hovered) {
      bg = c.cardBgSecondary;
    } else {
      bg = Colors.transparent;
    }

    final Color fg = widget.selected ? accent : c.textSecondary;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: widget.selected
                  ? accent.withValues(alpha: 0.45)
                  : c.borderLight,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.color != null) ...[
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  fontFamily: widget.fontFamily,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScheduleHeader extends StatelessWidget {
  const _ScheduleHeader({
    required this.state,
    required this.fontFamily,
    required this.visibleCount,
  });

  final AppointmentState state;
  final String fontFamily;
  final int visibleCount;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final total = state.filteredAppointments.length;
    final filtered = visibleCount != total;

    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: ColorManager.primary10,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(
            Icons.event_note_rounded,
            color: ColorManager.primary,
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.schedule,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: c.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                filtered
                    ? '$visibleCount / $total'
                    : '$total ${l10n.total.toLowerCase()}',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 12,
                  color: c.textTertiary,
                ),
              ),
            ],
          ),
        ),
        _ViewModeToggle(state: state, fontFamily: fontFamily),
      ],
    );
  }
}

class _ViewModeToggle extends StatelessWidget {
  const _ViewModeToggle({required this.state, required this.fontFamily});

  final AppointmentState state;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final views = [
      (AppointmentViewMode.day, 'Day'),
      (AppointmentViewMode.week, 'Week'),
    ];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: views.map((v) {
          final selected = state.viewMode == v.$1;
          return GestureDetector(
            onTap: () => context.read<AppointmentBloc>().add(
                  AppointmentEvent.changeViewMode(v.$1),
                ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: selected ? c.cardBg : Colors.transparent,
                borderRadius: BorderRadius.circular(7),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                v.$2,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? ColorManager.primary
                      : c.textTertiary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _DesktopDateStrip extends StatelessWidget {
  const _DesktopDateStrip({required this.state, required this.fontFamily});

  final AppointmentState state;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final selected = state.selectedDate;
    final now = DateTime.now();
    final days = List.generate(
      14,
      (i) => DateTime(selected.year, selected.month, selected.day)
          .add(Duration(days: i - 5)),
    );

    return Row(
      children: [
        _ArrowButton(
          icon: Icons.chevron_left_rounded,
          onTap: () {
            context.read<AppointmentBloc>().add(
                  AppointmentEvent.selectDate(
                    selected.subtract(const Duration(days: 1)),
                  ),
                );
          },
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ClipRect(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: days.map((date) {
                final isSelected = _sameDay(date, selected);
                final isToday = _sameDay(date, now);

                return Expanded(
                  child: GestureDetector(
                    onTap: () => context.read<AppointmentBloc>().add(
                          AppointmentEvent.selectDate(date),
                        ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorManager.primary
                            : isToday
                                ? ColorManager.primary.withValues(alpha: 0.08)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: isToday && !isSelected
                            ? Border.all(
                                color: ColorManager.primary
                                    .withValues(alpha: 0.25),
                              )
                            : null,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _dayShort(date.weekday),
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              color: isSelected
                                  ? Colors.white.withValues(alpha: 0.85)
                                  : c.textTertiary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            date.day.toString(),
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? Colors.white
                                  : c.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        _ArrowButton(
          icon: Icons.chevron_right_rounded,
          onTap: () {
            context.read<AppointmentBloc>().add(
                  AppointmentEvent.selectDate(
                    selected.add(const Duration(days: 1)),
                  ),
                );
          },
        ),
      ],
    );
  }

  String _dayShort(int wd) {
    const d = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return d[wd - 1];
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Material(
      color: c.cardBgSecondary,
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        borderRadius: BorderRadius.circular(9),
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, color: c.textSecondary, size: 20),
        ),
      ),
    );
  }
}

// ─── Schedule list ────────────────────────────────────────────────────

class _ScheduleList extends StatelessWidget {
  const _ScheduleList({
    required this.appointments,
    required this.fontFamily,
    required this.hasActiveFilters,
    required this.onClearFilters,
  });

  final List<AppointmentEntity> appointments;
  final String fontFamily;
  final bool hasActiveFilters;
  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return _EmptyState(
        fontFamily: fontFamily,
        filtered: hasActiveFilters,
        onClearFilters: onClearFilters,
      );
    }

    final sorted = [...appointments]
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemCount: sorted.length,
      itemBuilder: (context, index) => _AppointmentRowDesktop(
        appointment: sorted[index],
        fontFamily: fontFamily,
      ),
    );
  }
}

class _AppointmentRowDesktop extends StatefulWidget {
  const _AppointmentRowDesktop({
    required this.appointment,
    required this.fontFamily,
  });

  final AppointmentEntity appointment;
  final String fontFamily;

  @override
  State<_AppointmentRowDesktop> createState() => _AppointmentRowDesktopState();
}

class _AppointmentRowDesktopState extends State<_AppointmentRowDesktop> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final a = widget.appointment;
    final statusColor = _statusColor(a.status);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.fromLTRB(12, 12, 16, 12),
        decoration: BoxDecoration(
          color: _hovered
              ? ColorManager.primary.withValues(alpha: 0.06)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered
                ? ColorManager.primary.withValues(alpha: 0.22)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 78,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    a.formattedTime,
                    style: TextStyle(
                      fontFamily: widget.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: c.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${a.durationMinutes} min',
                    style: TextStyle(
                      fontFamily: widget.fontFamily,
                      fontSize: 11.5,
                      color: c.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 4,
              height: 44,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 14),
            _Avatar(
              name: a.patientName,
              color: statusColor,
              fontFamily: widget.fontFamily,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    a.patientName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: widget.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: c.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(
                        Icons.medical_services_outlined,
                        size: 12,
                        color: c.textTertiary,
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          a.treatmentType,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: widget.fontFamily,
                            fontSize: 12.5,
                            color: c.textTertiary,
                          ),
                        ),
                      ),
                      if (a.doctorName.isNotEmpty) ...[
                        const SizedBox(width: 10),
                        Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(
                            color: c.textSubtle,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.person_outline,
                          size: 12,
                          color: c.textTertiary,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            a.doctorName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: widget.fontFamily,
                              fontSize: 12.5,
                              color: c.textTertiary,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _StatusPill(
              status: a.status,
              fontFamily: widget.fontFamily,
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.name,
    required this.color,
    required this.fontFamily,
  });

  final String name;
  final Color color;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        _initials(name),
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status, required this.fontFamily});

  final AppointmentStatus status;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(status);
    final label = _statusLabel(context, status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
          color: color,
        ),
      ),
    );
  }
}

// ─── Empty state ──────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.fontFamily,
    this.filtered = false,
    this.onClearFilters,
  });

  final String fontFamily;
  final bool filtered;
  final VoidCallback? onClearFilters;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 74,
              height: 74,
              decoration: BoxDecoration(
                color: ColorManager.primary10,
                shape: BoxShape.circle,
              ),
              child: Icon(
                filtered
                    ? Icons.filter_alt_off_rounded
                    : Icons.event_available_outlined,
                size: 34,
                color: ColorManager.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              filtered ? l10n.noAppointments : l10n.noAppointments,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: c.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              filtered
                  ? 'Try clearing filters to see more results.'
                  : 'Pick a different day or create a new appointment.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 13,
                color: c.textTertiary,
              ),
            ),
            const SizedBox(height: 18),
            if (filtered && onClearFilters != null)
              Material(
                color: c.cardBgSecondary,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: onClearFilters,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.filter_alt_off_outlined,
                          size: 16,
                          color: c.textSecondary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Clear filters',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: c.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              Material(
                color: ColorManager.primary10,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () =>
                      context.pushNamed(AppRoutesNames.newAppointment),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_rounded,
                          size: 16,
                          color: ColorManager.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          l10n.newAppointment,
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── Mini calendar ────────────────────────────────────────────────────

class _MiniCalendarCard extends StatelessWidget {
  const _MiniCalendarCard({required this.state, required this.fontFamily});

  final AppointmentState state;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final selected = state.selectedDate;
    final firstOfMonth = DateTime(selected.year, selected.month, 1);
    final daysInMonth =
        DateTime(selected.year, selected.month + 1, 0).day;
    final leadingBlanks = (firstOfMonth.weekday - 1) % 7;
    final totalCells = leadingBlanks + daysInMonth;
    final rowCount = (totalCells / 7).ceil();
    final now = DateTime.now();

    final appointmentDays = state.appointments
        .where((a) =>
            a.dateTime.year == selected.year &&
            a.dateTime.month == selected.month)
        .map((a) => a.dateTime.day)
        .toSet();

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _monthYear(selected),
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
              ),
              _MiniArrow(
                icon: Icons.chevron_left_rounded,
                onTap: () => context.read<AppointmentBloc>().add(
                      AppointmentEvent.selectDate(
                        DateTime(
                          selected.year,
                          selected.month - 1,
                          selected.day.clamp(
                              1,
                              DateTime(selected.year, selected.month, 0).day),
                        ),
                      ),
                    ),
              ),
              const SizedBox(width: 4),
              _MiniArrow(
                icon: Icons.chevron_right_rounded,
                onTap: () => context.read<AppointmentBloc>().add(
                      AppointmentEvent.selectDate(
                        DateTime(
                          selected.year,
                          selected.month + 1,
                          selected.day.clamp(
                              1,
                              DateTime(selected.year, selected.month + 2, 0)
                                  .day),
                        ),
                      ),
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const ['M', 'T', 'W', 'T', 'F', 'S', 'S'].map((d) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: _DayLabel(label: d),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 4),
          for (int row = 0; row < rowCount; row++)
            Row(
              children: List.generate(7, (col) {
                final cellIndex = row * 7 + col;
                final dayNum = cellIndex - leadingBlanks + 1;
                if (cellIndex < leadingBlanks || dayNum > daysInMonth) {
                  return const Expanded(child: SizedBox(height: 34));
                }
                final date =
                    DateTime(selected.year, selected.month, dayNum);
                final isSelected = _sameDay(date, selected);
                final isToday = _sameDay(date, now);
                final hasAppt = appointmentDays.contains(dayNum);

                return Expanded(
                  child: GestureDetector(
                    onTap: () => context.read<AppointmentBloc>().add(
                          AppointmentEvent.selectDate(date),
                        ),
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      height: 34,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorManager.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: isToday && !isSelected
                            ? Border.all(
                                color: ColorManager.primary
                                    .withValues(alpha: 0.5),
                              )
                            : null,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            '$dayNum',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 12,
                              fontWeight: isSelected || isToday
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : c.textPrimary,
                            ),
                          ),
                          if (hasAppt && !isSelected)
                            Positioned(
                              bottom: 4,
                              child: Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: ColorManager.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }

  String _monthYear(DateTime d) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${months[d.month - 1]} ${d.year}';
  }
}

class _MiniArrow extends StatelessWidget {
  const _MiniArrow({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: onTap,
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: c.cardBgSecondary,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Icon(icon, size: 16, color: c.textSecondary),
        ),
      ),
    );
  }
}

class _DayLabel extends StatelessWidget {
  const _DayLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 10.5,
        fontWeight: FontWeight.w600,
        color: c.textTertiary,
        letterSpacing: 0.5,
      ),
    );
  }
}

// ─── Upcoming card ────────────────────────────────────────────────────

class _UpcomingCard extends StatelessWidget {
  const _UpcomingCard({required this.state, required this.fontFamily});

  final AppointmentState state;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final upcoming = state.upcomingAppointments.take(4).toList();

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: ColorManager.primary10,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(
                  Icons.upcoming_rounded,
                  size: 15,
                  color: ColorManager.primary,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Upcoming',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: c.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (upcoming.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.noAppointments,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 12.5,
                    color: c.textTertiary,
                  ),
                ),
              ),
            )
          else
            for (int i = 0; i < upcoming.length; i++)
              Padding(
                padding: EdgeInsets.only(
                  bottom: i == upcoming.length - 1 ? 0 : 10,
                ),
                child: _UpcomingRow(
                  appointment: upcoming[i],
                  fontFamily: fontFamily,
                ),
              ),
        ],
      ),
    );
  }
}

class _UpcomingRow extends StatelessWidget {
  const _UpcomingRow({required this.appointment, required this.fontFamily});

  final AppointmentEntity appointment;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final color = _statusColor(appointment.status);

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => context.read<AppointmentBloc>().add(
              AppointmentEvent.selectDate(
                DateTime(
                  appointment.dateTime.year,
                  appointment.dateTime.month,
                  appointment.dateTime.day,
                ),
              ),
            ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 8, 10, 8),
          decoration: BoxDecoration(
            color: c.cardBgSecondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 34,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.patientName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: c.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${_shortDate(appointment.dateTime)}  ·  ${appointment.formattedTime}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 11,
                        color: c.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _shortDate(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[d.month - 1]} ${d.day}';
  }
}

// ─── Status breakdown ─────────────────────────────────────────────────

class _StatusBreakdownCard extends StatelessWidget {
  const _StatusBreakdownCard({
    required this.state,
    required this.fontFamily,
  });

  final AppointmentState state;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final total = state.appointments.length;

    final rows = <_BreakdownRow>[
      _BreakdownRow(
        label: 'Confirmed',
        status: AppointmentStatus.confirmed,
        count: state
            .getAppointmentCountByStatus(AppointmentStatus.confirmed),
      ),
      _BreakdownRow(
        label: l10n.pending,
        status: AppointmentStatus.pending,
        count:
            state.getAppointmentCountByStatus(AppointmentStatus.pending),
      ),
      _BreakdownRow(
        label: l10n.completed,
        status: AppointmentStatus.completed,
        count:
            state.getAppointmentCountByStatus(AppointmentStatus.completed),
      ),
      _BreakdownRow(
        label: l10n.cancelled,
        status: AppointmentStatus.cancelled,
        count:
            state.getAppointmentCountByStatus(AppointmentStatus.cancelled),
      ),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: ColorManager.primary10,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(
                  Icons.donut_small_rounded,
                  size: 15,
                  color: ColorManager.primary,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                l10n.status,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: c.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                '$total ${l10n.total.toLowerCase()}',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 11.5,
                  color: c.textTertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          for (int i = 0; i < rows.length; i++)
            Padding(
              padding:
                  EdgeInsets.only(bottom: i == rows.length - 1 ? 0 : 10),
              child: _BreakdownBar(
                row: rows[i],
                total: total,
                fontFamily: fontFamily,
              ),
            ),
        ],
      ),
    );
  }
}

class _BreakdownRow {
  final String label;
  final AppointmentStatus status;
  final int count;
  const _BreakdownRow({
    required this.label,
    required this.status,
    required this.count,
  });
}

class _BreakdownBar extends StatelessWidget {
  const _BreakdownBar({
    required this.row,
    required this.total,
    required this.fontFamily,
  });

  final _BreakdownRow row;
  final int total;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final color = _statusColor(row.status);
    final pct = total == 0 ? 0.0 : row.count / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                row.label,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 12.5,
                  color: c.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              row.count.toString(),
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: c.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: pct,
            minHeight: 5,
            backgroundColor: c.cardBgSecondary,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}

// ─── Shared helpers ───────────────────────────────────────────────────

bool _sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

Color _statusColor(AppointmentStatus status) {
  switch (status) {
    case AppointmentStatus.confirmed:
      return ColorManager.primary;
    case AppointmentStatus.pending:
      return ColorManager.warningLight;
    case AppointmentStatus.completed:
      return ColorManager.success;
    case AppointmentStatus.cancelled:
      return ColorManager.error;
    case AppointmentStatus.noShow:
      return ColorManager.gray400;
  }
}

String _statusLabel(BuildContext context, AppointmentStatus status) {
  final l10n = AppLocalizations.of(context)!;
  switch (status) {
    case AppointmentStatus.confirmed:
      return 'Confirmed';
    case AppointmentStatus.pending:
      return l10n.pending;
    case AppointmentStatus.completed:
      return l10n.completed;
    case AppointmentStatus.cancelled:
      return l10n.cancelled;
    case AppointmentStatus.noShow:
      return 'No Show';
  }
}
