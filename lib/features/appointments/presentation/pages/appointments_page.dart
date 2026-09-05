import 'package:dental_clinic_app/core/utils/bloc_settled.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/state_card.dart';
import 'package:dental_clinic_app/custom_widgets/app_snackbar.dart';
import 'package:dental_clinic_app/custom_widgets/denta_refresh.dart';
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
import 'package:dental_clinic_app/features/appointments/presentation/widgets/appointment_list_card.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard_helper.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';

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

/// The day (or week) of appointments, in the same visual language as the home
/// schedule: the count sits in the header, the rows are [AppointmentListCard],
/// and every list state is a [StateCard] rather than a bare centred icon.
class _AppointmentsContent extends StatelessWidget {
  const _AppointmentsContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: BlocConsumer<AppointmentBloc, AppointmentState>(
        // A rejected status change has to say so. The list itself is still
        // valid, so this is a snackbar over the day rather than an error
        // state replacing it - and it carries the server's own reason, which
        // is the part that used to be swallowed.
        listenWhen: (prev, curr) =>
            prev.actionError != curr.actionError && curr.actionError != null,
        listener: (context, state) {
          AppSnackbar.showError(
            context,
            title: AppLocalizations.of(context)!.statusChangeFailed,
            message: state.actionError,
          );
          context.read<AppointmentBloc>().add(
            const AppointmentEvent.clearActionError(),
          );
        },
        builder: (context, state) {
          return Column(
            children: [
              _buildHeader(context, state),
              Divider(height: 1, color: ColorManager.of(context).borderLight),
              Padding(
                padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 10.h),
                child: _buildDateSelector(context, state),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: _buildViewToggle(context, state),
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: DentaRefresh(
                  onRefresh: () => _refresh(context),
                  child: _buildBody(context, state),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Re-runs the day/week query. The band stays open until the bloc settles on
  /// a non-loading state, so the spinner tracks the request rather than a timer.
  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<AppointmentBloc>();
    bloc.add(const AppointmentEvent.loadAppointments());
    await bloc.stream.settled((state) => !state.isLoading);
  }

  Widget _buildBody(BuildContext context, AppointmentState state) {
    final l10n = AppLocalizations.of(context)!;

    if (state.isLoading) return _buildLoadingSkeleton(context);

    if (state.error != null) {
      return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 24.h),
        child: StateCard(
          icon: Icons.cloud_off_rounded,
          tone: ColorManager.error,
          title: l10n.appointmentsLoadFailed,
          message: state.error,
          detail: l10n.scheduleUnchangedHint,
          actionLabel: l10n.retry,
          onAction: () => context.read<AppointmentBloc>().add(
            const AppointmentEvent.loadAppointments(),
          ),
        ),
      );
    }

    if (state.filteredAppointments.isEmpty) {
      return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 24.h),
        child: StateCard(
          icon: Icons.calendar_today_outlined,
          title: l10n.noAppointmentsScheduled,
          message: l10n.noAppointmentsScheduledHint,
          actionLabel: '+ ${l10n.newAppointment}',
          onAction: () => _openNewAppointment(context),
        ),
      );
    }

    if (state.viewMode == AppointmentViewMode.week) {
      return _buildWeekList(context, state.filteredAppointments);
    }

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 24.h),
      itemCount: state.filteredAppointments.length,
      separatorBuilder: (_, i) => SizedBox(height: 8.h),
      itemBuilder: (context, index) =>
          AppointmentListCard(appointment: state.filteredAppointments[index]),
    );
  }

  Widget _buildWeekList(
    BuildContext context,
    List<AppointmentEntity> appointments,
  ) {
    final groups = _groupByDay(appointments);
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 24.h),
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final entry = groups[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDayHeader(context, entry.key, entry.value.length),
            for (var i = 0; i < entry.value.length; i++) ...[
              if (i > 0) SizedBox(height: 8.h),
              AppointmentListCard(appointment: entry.value[i]),
            ],
            SizedBox(height: 16.h),
          ],
        );
      },
    );
  }

  Widget _buildDayHeader(BuildContext context, DateTime day, int count) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final today = DateTime.now();
    final isToday =
        day.year == today.year &&
        day.month == today.month &&
        day.day == today.day;
    final label =
        '${_getDayName(context, day)}, ${_getMonthName(context, day)} ${day.day}';

    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 10.h),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: family,
              fontWeight: FontWeight.w600,
              color: isToday ? ColorManager.primaryDarker : c.textPrimary,
            ),
          ),
          SizedBox(width: 6.w),
          _CountPill(count: count),
          if (isToday) ...[
            SizedBox(width: 6.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                AppLocalizations.of(context)!.today,
                style: TextStyle(
                  fontSize: 10.sp,
                  height: 1.3,
                  fontFamily: family,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.primaryDarker,
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
    final sorted = map.entries.toList()..sort((a, b) => a.key.compareTo(b.key));
    for (final entry in sorted) {
      entry.value.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    }
    return sorted;
  }

  String _getMonthName(BuildContext context, DateTime date) =>
      AppDate.monthAbbr(context, date);

  Future<void> _openNewAppointment(BuildContext context) async {
    if (!await SubscriptionGuardHelper.requireActive(context)) return;
    if (!context.mounted) return;
    await context.pushNamed(AppRoutesNames.newAppointment);
    if (!context.mounted) return;
    context.read<AppointmentBloc>().add(
      const AppointmentEvent.loadAppointments(),
    );
  }

  // ─── Header ─────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context, AppointmentState state) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 12.h),
        child: Row(
          children: [
            Text(
              l10n.appointments,
              style: TextStyle(
                fontFamily: family,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: c.textPrimary,
              ),
            ),
            if (!state.isLoading && state.error == null) ...[
              SizedBox(width: 6.w),
              _CountPill(count: state.filteredAppointments.length),
            ],
            const Spacer(),
            // Jump back to today. Outlined rather than filled - it is the
            // secondary action next to New.
            _OutlinedAction(
              label: l10n.today,
              onTap: () {
                final now = DateTime.now();
                context.read<AppointmentBloc>().add(
                  AppointmentEvent.selectDate(
                    DateTime(now.year, now.month, now.day),
                  ),
                );
              },
            ),
            SizedBox(width: 8.w),
            _NewButton(
              label: l10n.newButton,
              onTap: () => _openNewAppointment(context),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Date selector ──────────────────────────────────────────────────────

  Widget _buildDateSelector(BuildContext context, AppointmentState state) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
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

              // Borderless pills, as before: a filled primary for the
              // selected day, a soft primary wash for today, nothing at all
              // for the rest.
              return GestureDetector(
                onTap: () => context.read<AppointmentBloc>().add(
                  AppointmentEvent.selectDate(date),
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 8.h,
                  ),
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
                          fontFamily: family,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white70 : c.textTertiary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        date.day.toString(),
                        style: TextStyle(
                          fontFamily: family,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : c.textPrimary,
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
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final views = [
      (AppointmentViewMode.day, l10n.day),
      (AppointmentViewMode.week, l10n.week),
    ];

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Row(
        children: views.map((v) {
          final isSelected = state.viewMode == v.$1;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => context.read<AppointmentBloc>().add(
                AppointmentEvent.changeViewMode(v.$1),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 7.h),
                decoration: BoxDecoration(
                  color: isSelected ? c.cardBg : Colors.transparent,
                  borderRadius: BorderRadius.circular(9.r),
                  border: Border.all(
                    color: isSelected ? c.borderLight : Colors.transparent,
                  ),
                ),
                child: Center(
                  child: Text(
                    v.$2,
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 12.sp,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: isSelected
                          ? ColorManager.primaryDarker
                          : c.textTertiary,
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

  // ─── Loading skeleton ───────────────────────────────────────────────────

  Widget _buildLoadingSkeleton(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 24.h),
      itemCount: 6,
      separatorBuilder: (_, i) => SizedBox(height: 8.h),
      itemBuilder: (context, index) => const AppointmentCardSkeleton(),
    );
  }

  // ─── Helpers ────────────────────────────────────────────────────────────

  String _getDayName(BuildContext context, DateTime date) =>
      AppDate.weekdayAbbr(context, date);
}

/// The count that belongs next to a title, in the primary tint.
class _CountPill extends StatelessWidget {
  const _CountPill({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        '$count',
        style: TextStyle(
          fontFamily: FontHelper.fontFamily(context),
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          height: 1.3,
          color: ColorManager.primaryDarker,
        ),
      ),
    );
  }
}

/// Secondary header action: white with a primary hairline.
class _OutlinedAction extends StatelessWidget {
  const _OutlinedAction({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Material(
      color: c.cardBg,
      borderRadius: BorderRadius.circular(11.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.r),
            border: Border.all(color: ColorManager.primaryLighter),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w600,
              color: ColorManager.primaryDarker,
            ),
          ),
        ),
      ),
    );
  }
}

/// Rectangular primary button, matching the patients list. A round `+` gave
/// the action no name; the word carries it.
class _NewButton extends StatelessWidget {
  const _NewButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorManager.primary,
      borderRadius: BorderRadius.circular(11.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
          // Icon and label are centred on the row's cross axis; the label
          // carries no `height` override, because shrinking its line box
          // pushes the glyphs off the icon's centre - visibly so in Cairo.
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 16.w, color: ColorManager.white),
              SizedBox(width: 5.w),
              Text(
                label,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
